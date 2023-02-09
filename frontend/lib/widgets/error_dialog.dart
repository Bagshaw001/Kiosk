import 'package:flutter/material.dart';


class ErrorDialog extends StatelessWidget {
  final String text;
  final String? title;
  const ErrorDialog({
    Key? key,
    this.title,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(title ?? "Something went wrong"),
      content: Text(text),
    );
  }
}
