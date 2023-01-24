import 'package:flutter/material.dart';


class CardList extends StatelessWidget {
  final double? width;
  final double? height;
  final String label;
  final Widget Function(BuildContext,int) listBuilder;
  const CardList({
    required this.label,
    required this.listBuilder,
    this.width,
    this.height,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(4),
        width: width,
        height: height,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label),
                Column(
                  children: [
                    Text("Date"),
                    Text("12-12-2202"),
                  ],
                )
              ],
            ),
            Divider(),
            Expanded(child: ListView.builder(itemBuilder: listBuilder))
          ],
        ),
      ),
    );
  }
}
