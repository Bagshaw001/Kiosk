import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double? width;
  final double? height;
  final String? label;
  final TextEditingController? controller;
  const CustomTextField({
    this.width,
    this.height,
    this.label,
    this.controller,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label ?? ""),
        TextFormField(
          controller: controller,
        )
      ],
    )
    );
  }
}