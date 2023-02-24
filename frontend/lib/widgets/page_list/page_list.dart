import "package:flutter/material.dart";
import 'package:kiosk/widgets/custom_list_view.dart';
import 'package:kiosk/widgets/page_list/widgets/extended_list_tile.dart';
import 'package:kiosk/widgets/page_list/widgets/page_list_tab.dart';


class PageList extends StatefulWidget {
  final Widget actions;
  final int selectedTab;
  final List<PageListTab> tabs;
  final Widget child;
  const PageList({
    required this.actions,
    required this.tabs,
    required this.child,
    required this.selectedTab,
    Key? key}) : super(key: key);

  @override
  _PageListState createState() => _PageListState();
}

class _PageListState extends State<PageList> {
  late List<PageListTab> tabs = [];


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
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
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(12)
            )
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  widget.actions,
                  const Spacer(),
                  Text("Search"),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black,),
                    onPressed: (){},
                  ),
                  Text("Export")
                ],
              ),

              const Divider(),
              widget.child
            ],
          ),
        )
      ]
    );
  }
}





