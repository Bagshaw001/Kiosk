import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double? width;
  final double? height;
  final String? label;
  final bool? obscure;
  final TextEditingController? controller;
  const CustomTextField(
      {this.width,this.obscure, this.height, this.label, this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: width ?? size.width * 0.3,
      height: height ?? 90,
      child: TextFormField(
        obscureText: obscure ?? false,
        decoration: InputDecoration(label: Text(label ?? "")),
        controller: controller,
      ),
    );
  }
}
