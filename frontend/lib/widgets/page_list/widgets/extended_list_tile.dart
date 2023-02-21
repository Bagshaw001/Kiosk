import 'package:flutter/material.dart';


class ExtendedListTile extends StatelessWidget {
  final List<String>? content;
   ExtendedListTile({
    Key? key,
     this.content
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
         [
          Checkbox(value: false, onChanged: (value){}),
           ...List.generate(content?.length ?? 0, (index) => Text(content![index] )),
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
