import 'package:aeda/View/register.dart';
import 'package:aeda/ViewModel/login_viewModel.dart';
import 'package:aeda/Widgets/logo_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/bottom_wave.dart';
import '../Widgets/button.dart';
import '../Widgets/form_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool fieldsAreEmpty = false;
  @override
  void initState() {
    super.initState();
    fieldsAreEmpty = false;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);
    viewModel.redirectPage(context);
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
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
                    const LogoTitle(paddingDivider: 4),
                    FormInput(
                      labelText: 'Email',
                      textEditingController: emailController,
                    ),
                    FormInput(
                      labelText: 'Password',
                      bottomPadding: 25,
                      obsecureText: true,
                      textEditingController: passwordController,
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
                      labelText: 'Login',
                      onPressed: () {
                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          setState(() {
                            fieldsAreEmpty = true;
                          });
                        } else {
                          viewModel.email = emailController.text;
                          viewModel.password = passwordController.text;
                          viewModel.login(context);
                        }
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
                              builder: (context) => const RegisterPage(),
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
