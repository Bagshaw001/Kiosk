import 'package:flutter/material.dart';
import 'package:kiosk/utils/constants.dart';

class PageListTab extends StatelessWidget {
  final String label;
  final int count;
  late bool selected;
  final Color? color;
   PageListTab({
     this.color,
    required this.label,
    required this.count,
     required this.selected,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: selected ? Colors.white : (color ?? Colors.blue).withOpacity(0.5),
          border: Border.all(
              color: Colors.black,
              width: 0.5
          ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12)
          )
      ),
      child: Row(
        children: [
          Text(label),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              color: (selected ? blue : Colors.white)
            ),
            child: Text("$count",style: TextStyle(color: selected ? Colors.white : Colors.black),),
          )
        ],
      ),
    );
  }
}