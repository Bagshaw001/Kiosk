import 'package:flutter/material.dart';
import 'package:kiosk/utils/constants.dart';

class LargeNav extends StatelessWidget {
  final Function(int)? onNavClick;
  int current;
   LargeNav({
    super.key,
    this.onNavClick,
    required this.current
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: blue,
      child: Column(
        children: [

          Row(
            children: [
              Placeholder(
                fallbackHeight: 50,
                  fallbackWidth: 50,
              ),
              Spacer(),
              Icon(Icons.account_circle_rounded),
              Icon(Icons.notifications),
            ],
          ),

          Text("omeibibagshaw@gmail.com"),

          _NavTile(
            label: "Dashboard",
            selected: current == 0,
            onPressed: (){
              if(onNavClick!= null){
                onNavClick!(0);
              }
            },

          ),

          _NavTile(
            label: "Inventory",
            selected: current == 1,
            onPressed: (){
              if(onNavClick!= null){
                onNavClick!(1);
              }
            },
          ),

          _NavTile(
            label: "Transaction",
            selected: current == 2,
            onPressed: (){
              if(onNavClick!= null){
                onNavClick!(2);
              }
            },
          ),

          _NavTile(
            label: "Accounts",
            selected: current == 3,
            onPressed: (){
              if(onNavClick!= null){
                onNavClick!(3);
              }
            },
          ),

          _NavTile(
            label: "Statistics",
            selected: current == 4,
            onPressed: (){
              if(onNavClick!= null){
                onNavClick!(4);
              }
            },
          )

        ],
      ),
    );
  }
}


class _NavTile extends StatefulWidget {
  final String label;
  final Function()? onPressed;
  final bool selected;
  const _NavTile({
    required this.label,
     this.onPressed,
    this.selected = false,
    super.key
  });

  @override
  State<_NavTile> createState() => _NavTileState();
}

class _NavTileState extends State<_NavTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(

      leading: Icon(Icons.dashboard_outlined),
      title: Text(widget.label),
      onTap: widget.onPressed,

      // style: ListTileStyle,
      selected: widget.selected,
      tileColor: widget.selected ? Colors.white : blue,
      // selectedTileColor: Colors.red,
      // selectedColor: Colors.green,

    );
  }
}



ThemeData selectedTheme = ThemeData(
  iconTheme: IconThemeData(
    color: Colors.red
  )
);