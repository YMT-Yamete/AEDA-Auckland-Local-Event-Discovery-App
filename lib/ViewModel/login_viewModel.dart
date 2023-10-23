import 'package:aeda/View/bottom_nav_bar.dart';
import 'package:aeda/ViewModel/profile_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aeda/Widgets/one_button_alert_dialog.dart';

class LoginViewModel extends ChangeNotifier {
  late String email;
  late String password;

  Future<void> login(
      BuildContext context, ProfileViewModel profileViewModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        await prefs.setStringList("authCredentials", [email, password]);
        profileViewModel.fetchUsername(credential.user!);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const OneButtonAlertDialog(
                title: "Warning", content: "No user found for that email.");
          },
        );
      } else if (e.code == 'wrong-password') {
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
}
