import 'package:flutter/material.dart';
import 'package:kiosk/utils/constants.dart';


class CustomButton extends StatelessWidget {
  final bool filled;
  final String label;
  final EdgeInsets? padding;
  final Color? outlineTextColor;
  final Color? outlineBorderColor;
  final Function()? onPressed;
  final double? width;
  const CustomButton({
    this.width,
    this.padding,
    this.filled = false,
    required this.label,
    this.outlineTextColor,
    this.outlineBorderColor,
    this.onPressed,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (filled) {
      return Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: ElevatedButton(
        onPressed: onPressed ?? (){},

        child: Container(
            height: 30,
            width: width,
            margin: const EdgeInsets.all(4),
            child: Center(child: Text(label))),
    ),
      );
    } else {
      return Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: OutlinedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: outlineBorderColor ?? blue,
                  width: 0.5
                ),

            ))
        ),
        onPressed: onPressed?? (){},
        child: SizedBox(
            height: 30,
            width: width,
            child: Center(child: Text(label,
              style: TextStyle(
                color: outlineTextColor
              ),
            ))),
    ),
      );
    }
  }
}
