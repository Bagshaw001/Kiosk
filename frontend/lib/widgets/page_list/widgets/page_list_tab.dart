import 'package:flutter/material.dart';

class PageListTab extends StatelessWidget {
  final String label;
  final Color color;
  final int count;
  final bool selected;
  const PageListTab({
    required this.label,
    required this.count,
    this.color = Colors.white,
    this.selected = false,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.5),
          border: Border.all(
              color: Colors.black,
              width: 1
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12)
          )
      ),
      child: Row(
        children: [
          Text(label),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16)
            ),
            child: Text("$count"),
          )
        ],
      ),
    );
  }
}