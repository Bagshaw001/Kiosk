import 'package:flutter/material.dart';
import 'package:kiosk/widgets/custom_scaffold/widgets/large_nav.dart';


class LargeScaffold extends StatefulWidget {
  final Widget page;
  int selectedIndex;
  final Function(int)? onNavClick;
   LargeScaffold({
     required this.selectedIndex,
    super.key,
    this.onNavClick,
    required this.page,
    });


  @override
  State<LargeScaffold> createState() => _LargeScaffoldState();
}

class _LargeScaffoldState extends State<LargeScaffold> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(children: [
          SizedBox(
            width: size.width * 0.2,
            child: LargeNav(
              onNavClick: widget.onNavClick,
              current: widget.selectedIndex,
            ),
          ),

          Expanded(
            child: widget.page,
          )
        ],);
  }
}
