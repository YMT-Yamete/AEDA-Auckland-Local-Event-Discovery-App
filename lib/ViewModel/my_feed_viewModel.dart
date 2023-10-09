import 'package:aeda/View/interested_area.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aeda/Model/local_event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MyFeedViewModel extends ChangeNotifier {
  late int itemCount = 0;
  List<LocalEvent> localEventList = [];

  MyFeedViewModel() {
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot<Map<String, dynamic>> eventQuery =
          await FirebaseFirestore.instance.collection('events').get();

      localEventList.clear();

      await Future.forEach(eventQuery.docs, (eventDoc) async {
        Map<String, dynamic> eventData =
            eventDoc.data() as Map<String, dynamic>;

        LocalEvent event = LocalEvent(
          eventName: eventData['eventName'],
          date: eventData['date'],
          startTime: eventData['startTime'],
          endTime: eventData['endTime'],
          appUserEmail: eventData['appUserEmail'],
          address: eventData['address'],
          location: eventData['location'],
          category: eventData['category'],
          description: eventData['description'],
          imagePath: eventData['imagePath'],
        );

        localEventList.add(event);
      });

      itemCount = localEventList.length;

      notifyListeners();
    } catch (error) {
      final logger = Logger();
      logger.e(error);
    }
  }

  Future<void> checkUserInterestsAndNavigate(BuildContext context) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final String? userEmail = user.email;
      final DocumentSnapshot userInterestsSnapshot = await FirebaseFirestore
          .instance
          .collection('user_interests')
          .doc(userEmail)
          .get();

      // Check if the 'interests' field is empty or null
      final Map<String, dynamic>? userData =
          userInterestsSnapshot.data() as Map<String, dynamic>?;
      final List<dynamic>? userInterests =
          userData?['interests'] as List<dynamic>?;

      if (userInterests == null || userInterests.isEmpty) {
        // User doesn't have interested areas, navigate to InterestedAreaPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InterestedAreaPage(),
          ),
        );
      }
    }
  }
}
