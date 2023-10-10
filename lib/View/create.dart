import 'dart:io';
import 'package:aeda/Data/data.dart';
import 'package:aeda/ViewModel/create_viewModel.dart';
import 'package:aeda/ViewModel/my_feed_viewModel.dart';
import 'package:aeda/Widgets/top_back_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/button.dart';
import '../Widgets/form_input.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedLocation = '';
  String selectedCategory = '';
  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        selectedStartTime = pickedTime;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        selectedEndTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final CreateViewModel viewModel = Provider.of<CreateViewModel>(context);
    final MyFeedViewModel myFeedViewModel =
        Provider.of<MyFeedViewModel>(context);
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
                    const TopBackBar(),
                    FormInput(
                      labelText: 'Event Name',
                      textEditingController: eventNameController,
                    ),
                    FormInput(
                      labelText: 'Address',
                      textEditingController: addressController,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Location',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            child: DropdownButtonFormField<String>(
                              items: Data.locations.map((location) {
                                return DropdownMenuItem<String>(
                                  value: location,
                                  child: Text(
                                    location,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedLocation = newValue!;
                                });
                              },
                              decoration: const InputDecoration(
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
                        const Text(
                          'Category',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            child: DropdownButtonFormField<String>(
                              items: Data.categories.map((location) {
                                return DropdownMenuItem<String>(
                                  value: location,
                                  child: Text(location,
                                      style:
                                          const TextStyle(color: Colors.black)),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCategory = newValue!;
                                });
                              },
                              decoration: const InputDecoration(
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
                    FormInput(
                      labelText: 'Description',
                      textEditingController: descriptionController,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Photo',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    if (viewModel.image != null)
                      Column(
                        children: [
                          Image.file(
                            viewModel.image!,
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                          ),
                          GestureDetector(
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Remove Image",
                                style: TextStyle(
                                  color: Colors.red,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.red,
                                ),
                              ),
                            ),
                            onTap: () => viewModel.removeImage(),
                          ),
                          const SizedBox(height: 8.0)
                        ],
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              viewModel.pickImage();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Row(
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Date and Time",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () => _selectDate(context),
                              child: const Text(
                                'Select Event Date',
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            selectedDate != null
                                ? "${selectedDate?.toLocal()}".split(' ')[0]
                                : "",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () => _selectStartTime(context),
                                  child: const Text(
                                    'Select Start Time',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                selectedStartTime != null
                                    ? "${selectedStartTime?.format(context)}"
                                    : "",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () => _selectEndTime(context),
                                  child: const Text(
                                    'Select End Time',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                selectedEndTime != null
                                    ? "${selectedEndTime?.format(context)}"
                                    : "",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Button(
                      labelText: 'Create',
                      onPressed: () {
                        viewModel.eventName = eventNameController.text;
                        viewModel.date = selectedDate!.toString();
                        viewModel.startTime =
                            selectedStartTime!.format(context);
                        viewModel.endTime = selectedEndTime!.format(context);
                        viewModel.address = addressController.text;
                        viewModel.location = selectedLocation;
                        viewModel.category = selectedCategory;
                        viewModel.description = descriptionController.text;
                        viewModel.create(context);
                        myFeedViewModel.fetchDataFromFirestore();
                      },
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
