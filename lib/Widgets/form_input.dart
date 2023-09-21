import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String labelText;
  final double? bottomPadding;
  final bool? obsecureText;

  const FormInput(
      {Key? key,
      required this.labelText,
      this.bottomPadding,
      this.obsecureText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: EdgeInsets.only(bottom: bottomPadding ?? 10),
          child: SizedBox(
            child: TextField(
              obscureText: obsecureText ?? false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
