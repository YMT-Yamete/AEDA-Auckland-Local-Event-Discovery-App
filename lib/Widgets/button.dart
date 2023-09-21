import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String labelText;
  final VoidCallback onPressed;
  const Button({super.key, required this.labelText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff005EFA),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            labelText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
