import 'package:flutter/material.dart';
import 'package:kiosk/utils/constants.dart';


class ActionCard extends StatelessWidget {
  final bool filled;
  final IconData icon;
  final String label;
  const ActionCard({
    required this.label,
    required this.icon,
    this.filled = true,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: filled ? blue.withOpacity(0.5) : null,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          Container(
            child: Icon(icon),
            margin: EdgeInsets.only(left: 8),
          ),
          Text(label)
        ],
      ),
    );
  }
}
