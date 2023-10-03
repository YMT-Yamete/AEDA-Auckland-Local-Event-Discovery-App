import 'package:aeda/View/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Widgets/one_button_alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  late String email;
  late String password;
  Future<void> login(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        await prefs.setStringList("authCredentials", [email, password]);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const OneButtonAlertDialog(
                title: "Warning", content: "No user found for that email.");
          },
        );
      } else if (e.code == 'wrong-password') {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const OneButtonAlertDialog(
                title: "Warning",
                content: "Wrong password provided for that user.");
          },
        );
      } else {
        prefs.remove("authCredentials");
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const OneButtonAlertDialog(
                title: "Warning", content: "Login failed.");
          },
        );
      }
    }
  }

  Future<void> redirectPage(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> authCredentials = prefs.getStringList("authCredentials") ?? [];
    if (authCredentials.isNotEmpty) {
      email = authCredentials[0];
      password = authCredentials[1];
      // ignore: use_build_context_synchronously
      login(context);
    }
  }
}
