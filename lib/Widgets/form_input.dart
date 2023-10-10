import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String labelText;
  final double? bottomPadding;
  final bool? obsecureText;
  final TextEditingController? textEditingController;

  const FormInput(
      {Key? key,
      required this.labelText,
      this.bottomPadding,
      this.obsecureText,
      this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: EdgeInsets.only(bottom: bottomPadding ?? 10),
          child: SizedBox(
            child: TextField(
              controller: textEditingController,
              obscureText: obsecureText ?? false,
              decoration: const InputDecoration(
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
