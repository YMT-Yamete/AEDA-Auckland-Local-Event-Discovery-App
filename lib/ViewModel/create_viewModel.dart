import 'dart:io';
import 'package:aeda/Model/local_event_model.dart';
import 'package:aeda/View/bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreateViewModel extends ChangeNotifier {
  late String eventName;
  late String date;
  late String startTime;
  late String endTime;
  late String address;
  late String location;
  late String category;
  late String description;
  late String imagePath;
  File? image;

  Future<void> create(BuildContext context) async {
    final logger = Logger();
    if (image != null) {
      try {
        final Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('event_images')
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

        final UploadTask uploadTask = storageReference.putFile(image!);

        await uploadTask.whenComplete(() async {
          imagePath = await storageReference.getDownloadURL();
        });
      } catch (e) {
        logger.e("Failed to upload event image: $e");
        return;
      }
    } else {
      imagePath = '';
    }
    User? currentUser = FirebaseAuth.instance.currentUser;
    LocalEvent localEvent = LocalEvent(
        eventName: eventName,
        date: date,
        startTime: startTime,
        endTime: endTime,
        address: address,
        location: location,
        category: category,
        description: description,
        imagePath: imagePath,
        appUserEmail: currentUser!.email);
    CollectionReference events =
        FirebaseFirestore.instance.collection('events');

    return events.add(localEvent.toMap()).then((value) {
      logger.i("Event Added");
      logger.i("Document ID: ${value.id}");
      removeImage();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(initialIndex: 0),
        ),
      );
    }).catchError((error) {
      logger.e("Failed to Add Event: $error");
    });
  }

  Future pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      final imageTemp = File(pickedImage.path);
      image = imageTemp;
      notifyListeners();
    } on PlatformException catch (e) {
      final logger = Logger();
      logger.e("Failed to pick image: $e");
    }
  }

  void removeImage() {
    image = null;
    notifyListeners();
  }
}
