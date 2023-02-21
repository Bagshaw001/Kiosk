import 'package:flutter/material.dart';
import 'package:kiosk/utils/constants.dart';


class CustomButton extends StatelessWidget {
  final bool filled;
  final String label;
  final Color? outlineTextColor;
  final Color? outlineBorderColor;
  final Function()? onPressed;
  const CustomButton({
    this.filled = false,
    required this.label,
    this.outlineTextColor,
    this.outlineBorderColor,
    this.onPressed,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return filled ? ElevatedButton(
      onPressed: onPressed ?? (){},

      child: Container(
          height: 30,
          margin: const EdgeInsets.all(4),
          child: Center(child: Text(label))),
    )
        : OutlinedButton(
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
          // width: 70,
          child: Center(child: Text(label,
            style: TextStyle(
              color: outlineTextColor
            ),
          ))),
    );
  }
}
