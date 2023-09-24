import 'package:flutter/material.dart';

class LogoTitle extends StatelessWidget {
  final int? paddingDivider;
  const LogoTitle({super.key, this.paddingDivider});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / (paddingDivider ?? 10)),
        child: const Text(
          "AEDA",
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontFamily: 'Karla',
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
