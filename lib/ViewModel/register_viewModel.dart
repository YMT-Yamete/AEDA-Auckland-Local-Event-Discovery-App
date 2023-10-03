import 'package:aeda/Model/user_model.dart';
import 'package:aeda/View/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import '../Widgets/one_button_alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterViewModel extends ChangeNotifier {
  late String username;
  late String email;
  late String password;
  late String confirmPassword;
  Future<void> register(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // TODO: Store username in firestore database
    if (password == confirmPassword) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (credential.user != null) {
          await prefs.setStringList("authCredentials", [email, password]);
          addUser(AppUser(
            username: username,
            email: email,
          ));
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const OneButtonAlertDialog(
                  title: "Warning",
                  content: "The password provided is too weak.");
            },
          );
        } else if (e.code == 'email-already-in-use') {
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const OneButtonAlertDialog(
                  title: "Warning",
                  content: "The account already exists for that email.");
            },
          );
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const OneButtonAlertDialog(
                title: "Warning",
                content: "An error occured while registering.");
          },
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const OneButtonAlertDialog(
              title: "Warning",
              content: "Password and confirm password must be the same.");
        },
      );
    }
  }

  Future<void> addUser(AppUser appUser) {
    final logger = Logger();
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users.add(appUser.toMap()).then((value) {
      logger.i("User Added");
      logger.i("Document ID: ${value.id}");
    }).catchError((error) {
      logger.e("Failed to Add User: $error");
    });
  }
}
