import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  String? email;
  String? password;
  Future<void> login(BuildContext context) async {
    print("TODO: Login $email - $password");
  }
}
