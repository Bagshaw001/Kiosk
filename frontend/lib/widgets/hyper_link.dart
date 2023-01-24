import 'package:flutter/material.dart';


class Hyperlink extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;
  const Hyperlink({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.white
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(text,
        style: Theme.of(context).textTheme.bodySmall!
            .copyWith(
            color: color,
          decoration: TextDecoration.underline
        ),
        ),
      ),
    );
  }
}
