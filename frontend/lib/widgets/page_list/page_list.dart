import "package:flutter/material.dart";
import 'package:kiosk/widgets/custom_list_view.dart';
import 'package:kiosk/widgets/page_list/widgets/extended_list_tile.dart';
import 'package:kiosk/widgets/page_list/widgets/page_list_tab.dart';


class PageList extends StatefulWidget {
  final Widget actions;
  final List<PageListTab> tabs;
  const PageList({
    required this.actions,
    required this.tabs,
    Key? key}) : super(key: key);

  @override
  _PageListState createState() => _PageListState();
}

class _PageListState extends State<PageList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          //Tab section
          Row(
            children: widget.tabs,
          ),

          //Start of list table
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1
              ),
              borderRadius: BorderRadius.circular(12)
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    widget.actions,
                    Spacer(),
                    Text("Serach"),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: (){},
                    ),
                    Text("Export")
                  ],
                ),
                
                Divider(),
                CustomListView(
                  height: size.height * 0.7,
                  width: size.width * 0.8,
                  builder: (index){
                    return ExtendedListTile();
                  },
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}






