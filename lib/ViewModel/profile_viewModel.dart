import 'package:aeda/Model/local_event_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      for (var eventDoc in eventQuery.docs) {
        final eventData = eventDoc.data();

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
      }
    }

    return userEvents;
  }

  Future<void> deleteEvent(String imagePath) async {
    try {
      final CollectionReference events =
          FirebaseFirestore.instance.collection('events');

      final QuerySnapshot<Object?> query =
          await events.where('imagePath', isEqualTo: imagePath).limit(1).get();

      if (query.docs.isNotEmpty) {
        final DocumentSnapshot<Map<String, dynamic>> eventDoc =
            query.docs.first as DocumentSnapshot<Map<String, dynamic>>;
        await eventDoc.reference.delete();
        notifyListeners();
      }
    } catch (e) {
      final logger = Logger();
      logger.e(e);
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      final logger = Logger();
      logger.e("Error during sign out: $e");
    }
  }
}
