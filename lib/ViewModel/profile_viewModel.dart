import 'package:aeda/Model/local_event_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class ProfileViewModel extends ChangeNotifier {
  String username = "Loading...";

  ProfileViewModel() {
    fetchUsername();
  }

  Future<void> fetchUsername() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final QuerySnapshot<Map<String, dynamic>> userQuery =
            await FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: user.email)
                .limit(1)
                .get();
        if (userQuery.docs.isNotEmpty) {
          username = userQuery.docs.first.get('username');
          notifyListeners();
        }
      }
    } catch (e) {
      final logger = Logger();
      logger.e(e);
    }
  }

  Future<List<LocalEvent>> fetchUserEvents() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final List<LocalEvent> userEvents = [];

    if (user != null) {
      final QuerySnapshot<Map<String, dynamic>> eventQuery =
          await FirebaseFirestore.instance
              .collection('events')
              .where('appUserEmail', isEqualTo: user.email)
              .get();

      eventQuery.docs.forEach((eventDoc) {
        final eventData = eventDoc.data() as Map<String, dynamic>;

        final event = LocalEvent(
          eventName: eventData['eventName'],
          date: eventData['date'],
          startTime: eventData['startTime'],
          endTime: eventData['endTime'],
          address: eventData['address'],
          location: eventData['location'],
          category: eventData['category'],
          description: eventData['description'],
          imagePath: eventData['imagePath'],
          appUserEmail: eventData['appUserEmail'],
        );

        userEvents.add(event);
      });
    }

    return userEvents;
  }
}
