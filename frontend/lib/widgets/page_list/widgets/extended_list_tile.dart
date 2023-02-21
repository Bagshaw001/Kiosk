import 'package:flutter/material.dart';


class ExtendedListTile extends StatelessWidget {
  final List<Widget>? content;
   ExtendedListTile({
    Key? key,
     this.content
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: content ?? const [Text("Empty")]
         ,

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
