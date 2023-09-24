import 'package:aeda/View/change_password.dart';
import 'package:aeda/Widgets/top_back_bar.dart';
import 'package:flutter/material.dart';
import '../Widgets/bottom_wave.dart';
import '../Widgets/button.dart';
import '../Widgets/form_input.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BottomWave(),
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TopBackBar(),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 4,
                      ),
                      child: Column(
                        children: [
                          const FormInput(
                            labelText: 'Username',
                            bottomPadding: 25,
                          ),
                          Button(
                            labelText: 'Save',
                            onPressed: () {
                              // TODO: Save
                            },
                          ),
                          SizedBox(
                            child: GestureDetector(
                              child: const Text(
                                "Change Password.",
                                style: TextStyle(color: Colors.grey),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChangePasswordPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10.0),
                        ],
                      ),
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
