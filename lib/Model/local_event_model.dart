import 'package:flutter/material.dart';

class LocalEvent {
  String eventName;
  String date;
  String startTime;
  String endTime;
  String address;
  String location;
  String category;
  String description;
  String imagePath;
  String? appUserEmail;
  LocalEvent(
      {required this.eventName,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.address,
      required this.location,
      required this.category,
      required this.description,
      required this.imagePath,
      this.appUserEmail});
  Map<String, dynamic> toMap() {
    return {
      'eventName': eventName,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'address': address,
      'location': location,
      'category': category,
      'description': description,
      'imagePath': imagePath,
      'appUserEmail': appUserEmail,
    };
  }
}
