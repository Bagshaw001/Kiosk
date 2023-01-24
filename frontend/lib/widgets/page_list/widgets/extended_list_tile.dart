import 'package:flutter/material.dart';


class ExtendedListTile extends StatelessWidget {
  const ExtendedListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Checkbox(value: false, onChanged: (value){}),
          Text("Simba Adomakoh"),
          Text("S04382"),
          Text("2"),
          Text("Price"),
          Text("06/20/2022"),
          ListTag(
            label: "Active",
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}




class ListTag extends StatelessWidget {
  final String label;
  final Color color;
  const ListTag({
    required this.label,
    required this.color,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Text(label),
    );
  }
}
