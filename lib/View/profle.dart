import 'package:aeda/View/edit_profile.dart';
import 'package:aeda/View/interested_area.dart';
import 'package:aeda/Widgets/button.dart';
import 'package:flutter/material.dart';
import '../Widgets/event_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/place_holder_profile.jpg',
                        width: 100, // Adjust the width as needed
                        height: 100, // Adjust the height as needed
                        fit: BoxFit
                            .cover, // You can use different BoxFit values to control how the image is scaled
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // TODO: Navigate to edit profile page
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfilePage(),
                              ),
                            );
                          },
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Button(
                  labelText: 'Edit Preferences',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InterestedAreaPage(),
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "My Events",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Saved",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return EventCard(index: index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}