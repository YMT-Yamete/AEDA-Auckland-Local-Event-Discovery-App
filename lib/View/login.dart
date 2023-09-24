import 'package:aeda/View/register.dart';
import 'package:aeda/Widgets/logo_title.dart';
import 'package:flutter/material.dart';
import '../Widgets/bottom_wave.dart';
import '../Widgets/button.dart';
import '../Widgets/form_input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                    LogoTitle(paddingDivider: 4),
                    const FormInput(labelText: 'Email'),
                    const FormInput(
                        labelText: 'Password',
                        bottomPadding: 25,
                        obsecureText: true),
                    Button(
                      labelText: 'Login',
                      onPressed: () {
                        // TODO: Login
                      },
                    ),
                    SizedBox(
                      child: GestureDetector(
                        child: const Text(
                          "I don't have an account.",
                          style: TextStyle(color: Colors.grey),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
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
