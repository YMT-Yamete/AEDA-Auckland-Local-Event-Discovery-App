import 'package:aeda/Model/local_event_model.dart';
import 'package:flutter/material.dart';
import '../Widgets/top_back_bar.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatelessWidget {
  final LocalEvent event;
  const EventDetails({super.key, required this.event});

  String formatDate(String originalDate) {
    final dateTime = DateTime.parse(originalDate);
    final formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TopBackBar(),
            SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.all(10.0),
                    color: Color.fromARGB(255, 40, 40, 40),
                    child: Column(
                      children: [
                        Image.network(
                          event.imagePath,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Evant Name: ${event.eventName}",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Date: ${formatDate(event.date)}",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Location: ${event.location}",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Address: ${event.address}",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Divider(color: Colors.white),
                        Text(
                          "${event.description}",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
