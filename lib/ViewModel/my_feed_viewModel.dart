import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aeda/Model/local_event_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

        String imagePath = eventData['imagePath'];
        String imageUrl = await getImageUrlFromStorage(imagePath);

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
          imagePath: imageUrl,
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

  // Function to fetch image URL from Firebase Storage
  Future<String> getImageUrlFromStorage(String imagePath) async {
    try {
      final Reference storageReference =
          FirebaseStorage.instance.ref(imagePath);
      final imageUrl = await storageReference.getDownloadURL();
      return imageUrl;
    } catch (error) {
      final logger = Logger();
      logger.e("Failed to fetch image from Firebase Storage: $error");
      return '';
    }
  }
}
