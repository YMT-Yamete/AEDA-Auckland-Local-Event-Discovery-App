import 'package:aeda/Widgets/top_back_bar.dart';
import 'package:flutter/material.dart';
import '../Widgets/bottom_wave.dart';
import '../Widgets/button.dart';
import '../Widgets/form_input.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

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
                    const TopBackBar(),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 6,
                      ),
                      child: Column(
                        children: [
                          const FormInput(
                            labelText: 'Old Password',
                            obsecureText: true,
                          ),
                          const FormInput(
                            labelText: 'New Password',
                            obsecureText: true,
                          ),
                          const FormInput(
                            labelText: 'Confirm New Password',
                            obsecureText: true,
                            bottomPadding: 25,
                          ),
                          Button(
                            labelText: 'Save',
                            onPressed: () {
                              // TODO: Save
                            },
                          ),
                        ],
                      ),
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
