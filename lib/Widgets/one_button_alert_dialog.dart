import 'package:flutter/material.dart';

class OneButtonAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  const OneButtonAlertDialog({
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
