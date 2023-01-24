import 'package:flutter/material.dart';
import 'package:kiosk/utils/constants.dart';
import 'package:kiosk/utils/webpage.dart';
import 'package:kiosk/widgets/custom_scaffold/large_scaffold.dart';

class DynamicScaffold extends StatefulWidget {
  bool showNavBar;
  Function(int)? onNavClick;
  final selectedIndex;
  final Webpage  mainPage;
   DynamicScaffold({
    super.key,
    required this.mainPage,
     this.onNavClick,
     required this.selectedIndex,
    this.showNavBar = true
    });

  @override
  State<DynamicScaffold> createState() => _DynamicScaffoldState();
}

class _DynamicScaffoldState extends State<DynamicScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  LayoutBuilder(
      builder: (context,constraints){
        double screenSize = constraints.maxWidth;
        if (screenSize >= largeScreen){
          return LargeScaffold(
            onNavClick: widget.onNavClick,
            selectedIndex: widget.selectedIndex,
            page: widget.mainPage.large,);
        }
          return Text(screenSize.toString());
      },
    )
    );
  }
}

