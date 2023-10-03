import 'package:aeda/View/login.dart';
import 'package:aeda/ViewModel/register_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/bottom_wave.dart';
import '../Widgets/button.dart';
import '../Widgets/form_input.dart';
import '../Widgets/logo_title.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool fieldsAreEmpty = false;
  @override
  void initState() {
    super.initState();
    fieldsAreEmpty = false;
  }

  @override
  Widget build(BuildContext context) {
    final RegisterViewModel viewModel = Provider.of<RegisterViewModel>(context);
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

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
                    const LogoTitle(),
                    FormInput(
                      labelText: 'Username',
                      textEditingController: usernameController,
                    ),
                    FormInput(
                      labelText: 'Email',
                      textEditingController: emailController,
                    ),
                    FormInput(
                      labelText: 'Password',
                      obsecureText: true,
                      textEditingController: passwordController,
                    ),
                    FormInput(
                      labelText: 'Confirm Password',
                      bottomPadding: 25,
                      obsecureText: true,
                      textEditingController: confirmPasswordController,
                    ),
                    if (fieldsAreEmpty)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Please fill in all fields',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    Button(
                      labelText: 'Register',
                      onPressed: () {
                        if (usernameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            confirmPasswordController.text.isEmpty) {
                          setState(() {
                            fieldsAreEmpty = true;
                          });
                        } else {
                          viewModel.username = usernameController.text;
                          viewModel.email = emailController.text;
                          viewModel.password = passwordController.text;
                          viewModel.confirmPassword =
                              confirmPasswordController.text;
                          viewModel.register(context);
                        }
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
                              builder: (context) => const LoginPage(),
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
