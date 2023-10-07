import 'package:aeda/Model/local_event_model.dart';
import 'package:aeda/View/event_details.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final LocalEvent event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetails(),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10.0),
        color: Color.fromARGB(255, 40, 40, 40),
        child: Column(
          children: [
            Image.network(
              event.imagePath,
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text(
                event.eventName,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                event.description,
                style: TextStyle(fontSize: 16, color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
