import 'package:aeda/View/interested_area.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aeda/Model/local_event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MyFeedViewModel extends ChangeNotifier {
  late int itemCount = 0;
  bool isLoading = true;
  List<LocalEvent> localEventList = [];

  MyFeedViewModel() {
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      isLoading = true;
      notifyListeners();

      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final String? userEmail = user.email;

        final DocumentSnapshot userInterestsSnapshot = await FirebaseFirestore
            .instance
            .collection('user_interests')
            .doc(userEmail)
            .get();

        final Map<String, dynamic>? userData =
            userInterestsSnapshot.data() as Map<String, dynamic>?;
        final List<dynamic>? userInterests =
            userData?['interests'] as List<dynamic>?;

        if (userInterests != null && userInterests.isNotEmpty) {
          QuerySnapshot<Map<String, dynamic>> eventQuery =
              await FirebaseFirestore.instance
                  .collection('events')
                  .where('category', whereIn: userInterests)
                  .get();

          localEventList.clear();

          for (var eventDoc in eventQuery.docs) {
            Map<String, dynamic> eventData = eventDoc.data();

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
          }

          itemCount = localEventList.length;
        }
      }
    } catch (error) {
      final logger = Logger();
      logger.e(error);
    } finally {
      isLoading = false;
      notifyListeners();
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
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InterestedAreaPage(),
          ),
        );
      }
    }
  }

  Future<void> clearData() async {
    localEventList.clear();
    itemCount = 0;
    isLoading = false;
    notifyListeners();
  }

  Future<void> refreshData() async {
    try {
      isLoading = true;
      notifyListeners();

      // Fetch the latest data here and update localEventList and itemCount
      await fetchDataFromFirestore();
    } catch (error) {
      final logger = Logger();
      logger.e(error);
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners after refreshing data
    }
  }
}
