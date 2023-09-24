import 'dart:io';

import 'package:aeda/View/register.dart';
import 'package:aeda/Widgets/logo_title.dart';
import 'package:aeda/Widgets/top_back_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../Widgets/bottom_wave.dart';
import '../Widgets/button.dart';
import '../Widgets/form_input.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
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

  File? image;
  Future pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      final imageTemp = File(pickedImage.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

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
                    const FormInput(labelText: 'Event Name'),
                    const FormInput(labelText: 'Address'),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Photo',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                pickImage();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: Color(0xFF333333),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Add Photo',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Button(
                      labelText: 'Create',
                      onPressed: () {
                        // TODO: Create
                      },
                    ),
                    const SizedBox(height: 10.0),
                    if (image != null)
                      Image.file(
                        image!,
                        width: 100, // Adjust image width as needed
                        height: 100, // Adjust image height as needed
                      ),
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
