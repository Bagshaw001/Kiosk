import "package:flutter/material.dart";
import 'package:kiosk/widgets/custom_button.dart';


class TodoCard extends StatefulWidget {
  const TodoCard({Key? key}) : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Placeholder(
              fallbackHeight: size.height * 0.12,
            ),
            Text("Todo"),
            ListTile(
              visualDensity: VisualDensity.compact,
              leading: Column(
                children: [
                  Text("THU"),
                  Text("25")
                ],
              ),
              title: Text("Reply customers"),
              trailing: Radio(
                value: false,
                onChanged: (val){},
                groupValue: false,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(label: "Edit", filled: true,),
                CustomButton(label: "Create")
              ],
            )
          ],
        ),
      ),
    );
  }
}
