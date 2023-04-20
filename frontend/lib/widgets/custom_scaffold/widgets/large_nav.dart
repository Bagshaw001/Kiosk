import 'package:flutter/material.dart';
import 'package:kiosk/pages/account_settings/account_settings.dart';
import 'package:kiosk/utils/app_state.dart';
import 'package:kiosk/utils/constants.dart';
import 'package:provider/provider.dart';

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
      padding: const EdgeInsets.all(8),
      color: blue,
      child: Column(
        children: [

          Row(
            children: [
              Image.asset(
                "assets/images/logo.png",
                width: 70,
                height: 70,
              ),

              const Spacer(),
              IconButton(
                icon:const Icon(Icons.account_circle_rounded),
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> AccountSettings().large
                      )
                  );

                },
              ),


              IconButton(
                icon:const Icon(Icons.notifications),
                onPressed: (){

                },
              ),
            ],
          ),

          Text(Provider.of<AppState>(context).user.email,
          style: Theme.of(context).textTheme.bodyMedium!
            .copyWith(color: Colors.white),),

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
            label: "Social Media",
            selected: current == 3,
            onPressed: (){
              if(onNavClick!= null){
                onNavClick!(3);
              }
            },
          ),


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

      leading: const Icon(Icons.dashboard_outlined),
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
  iconTheme: const IconThemeData(
    color: Colors.red
  )
);