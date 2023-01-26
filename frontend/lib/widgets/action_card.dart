import 'package:flutter/material.dart';
import 'package:kiosk/utils/constants.dart';


class ActionCard extends StatelessWidget {
  final bool filled;
  final IconData icon;
  final String label;
  final bool alignRight;
  const ActionCard({
    required this.label,
    required this.icon,
    this.filled = true,
    this.alignRight = true,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: filled ? blue.withOpacity(0.5) : null,
            borderRadius: BorderRadius.circular(6),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: alignRight? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              child: Icon(icon,
              color: filled ? null : blue,),
              margin: EdgeInsets.symmetric(horizontal: 8),
            ),
            Text(label)
          ],
        ),
      ),
    );
  }
}
