import 'package:aeda/View/login.dart';
import 'package:flutter/material.dart';
import '../Widgets/bottom_wave.dart';
import '../Widgets/button.dart';
import '../Widgets/form_input.dart';
import '../Widgets/logo_title.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                    LogoTitle(),
                    const FormInput(labelText: 'Username'),
                    const FormInput(labelText: 'Email'),
                    const FormInput(
                      labelText: 'Password',
                      obsecureText: true,
                    ),
                    const FormInput(
                      labelText: 'Confirm Password',
                      bottomPadding: 25,
                      obsecureText: true,
                    ),
                    Button(
                      labelText: 'Register',
                      onPressed: () {
                        // TODO: Register
                      },
                    ),
                    SizedBox(
                      child: GestureDetector(
                        child: const Text(
                          "Already have an account.",
                          style: TextStyle(color: Colors.grey),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
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
