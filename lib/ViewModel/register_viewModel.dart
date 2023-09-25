import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  String? username;
  String? email;
  String? password;
  String? confirmPassword;
  Future<void> register(BuildContext context) async {
    print("TODO: Register $username - $email - $password - $confirmPassword");
  }
}
