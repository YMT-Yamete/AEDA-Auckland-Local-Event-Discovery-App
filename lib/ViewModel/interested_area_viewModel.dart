import 'package:aeda/Data/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class InterestedAreaViewModel extends ChangeNotifier {
  List<bool> isSelected =
      List.generate(Data.categories.length, (index) => false);
  List<String> selectedCategories = [];

  void toggleSelection(int index) {
    isSelected[index] = !isSelected[index];
    notifyListeners();
  }

  Future<void> saveUserInterests(
      String userEmail, List<String> interests) async {
    try {
      final CollectionReference userInterests =
          FirebaseFirestore.instance.collection('user_interests');

      await userInterests.doc(userEmail).set(
        {
          'interests': interests,
        },
        SetOptions(merge: true),
      );
    } catch (error) {
      final logger = Logger();
      logger.e('Error saving user interests: $error');
    }
  }

  void handleSubmit() {
    selectedCategories.clear();
    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i]) {
        selectedCategories.add(Data.categories[i]);
      }
    }

    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final String? userEmail = user.email;
      saveUserInterests(userEmail!, selectedCategories);
      notifyListeners();
    }
  }
}
