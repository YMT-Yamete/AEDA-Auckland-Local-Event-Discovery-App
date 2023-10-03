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
}
