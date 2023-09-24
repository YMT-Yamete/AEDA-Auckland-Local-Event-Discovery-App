import 'package:aeda/View/event_details.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final int index;
  const EventCard({super.key, required this.index});

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
            Image.asset(
              'assets/images/place_holder_img.jpg',
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text(
                'Event $index',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem ',
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
