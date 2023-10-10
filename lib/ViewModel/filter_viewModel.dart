import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FilterViewModel extends ChangeNotifier {
  String selectedLocation = '';
  String selectedCategory = '';
  List<DocumentSnapshot> allEvents = [];
  List<DocumentSnapshot> filteredPosts = [];

  Future<void> fetchEventsFromFirestore() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> eventQuery =
          await FirebaseFirestore.instance.collection('events').get();
      allEvents = eventQuery.docs;

      applyFilters(); // Apply filters initially
    } catch (e) {
      // Handle error
    }
  }

  void applyFilters() {
    // Reset filteredPosts
    filteredPosts = [];

    // Apply filters based on selectedLocation and selectedCategory
    filteredPosts = allEvents.where((event) {
      Map<String, dynamic> eventData = event.data() as Map<String, dynamic>;

      bool locationFilter = selectedLocation.isEmpty ||
          eventData['location']
              .toLowerCase()
              .contains(selectedLocation.toLowerCase());

      bool categoryFilter = selectedCategory.isEmpty ||
          eventData['category']
              .toLowerCase()
              .contains(selectedCategory.toLowerCase());

      return locationFilter && categoryFilter;
    }).toList();

    notifyListeners();
  }
}
