import 'package:aeda/View/register.dart';
import 'package:aeda/Widgets/logo_title.dart';
import 'package:aeda/Widgets/top_back_bar.dart';
import 'package:flutter/material.dart';
import '../Widgets/bottom_wave.dart';
import '../Widgets/button.dart';
import '../Widgets/form_input.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String selectedLocation = ''; // Store the selected location
  String selectedCategory = ''; // Store the selected category

  List<String> locations = [
    'Location 1',
    'Location 2',
    'Location 3'
  ]; // Replace with your location options
  List<String> categories = [
    'Category 1',
    'Category 2',
    'Category 3'
  ]; // Replace with your category options

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TopBackBar(),
                    const FormInput(labelText: 'Keyword'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 8.0),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            child: DropdownButtonFormField<String>(
                              items: locations.map((location) {
                                return DropdownMenuItem<String>(
                                  value: location,
                                  child: Text(
                                    location,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedLocation = newValue!;
                                });
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Category',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 8.0),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                            child: DropdownButtonFormField<String>(
                              items: categories.map((location) {
                                return DropdownMenuItem<String>(
                                  value: location,
                                  child: Text(location,
                                      style: TextStyle(color: Colors.black)),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCategory = newValue!;
                                });
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Button(
                      labelText: 'Filter',
                      onPressed: () {
                        // TODO: Login
                      },
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
