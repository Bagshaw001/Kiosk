


import 'package:kiosk/utils/webpage.dart';
import 'package:flutter/material.dart';
import 'package:kiosk/widgets/action_card.dart';
import 'package:kiosk/widgets/custom_button.dart';
import 'package:kiosk/widgets/page_list/page_list.dart';
import 'package:kiosk/widgets/page_list/widgets/page_list_tab.dart';

class Inventory extends Webpage{

  Inventory(): super(large: _LargeInventory());

}





class _LargeInventory extends StatefulWidget {
  const _LargeInventory({Key? key}) : super(key: key);

  @override
  __LargeInventoryState createState() => __LargeInventoryState();
}

class __LargeInventoryState extends State<_LargeInventory> {
  String selected = "GHS";
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Positioned(
            right: 0,
              child: ActionCard(
                filled: false,
                icon: Icons.help_outline,
                label: "Help and Feedback",
              )
          ),

          Text("Inventory"),
          Text("All inventory available in your stores"),
          PageList(
            tabs: [
              PageListTab(label: "All Items", count: 20),
              PageListTab(label: "Active", count: 15, color: Colors.blue,),
              PageListTab(label: "Inactive", count: 5, color: Colors.blue,),
            ],
            actions: CustomButton(
            label: "Add Item",
              filled: true,
              onPressed: (){
              showDialog(context: context, builder: (context)=> Dialog(
                child: Column(
                  children: [
                    Text("Upload Product",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),

                    TextFormField(),

                    Text("Product Media"),

                    DropdownButton(
                      value: selected,
                        items: [
                          DropdownMenuItem(
                              child: Text("GHS"),
                            value: "GHS",
                          ),
                          DropdownMenuItem(
                              child: Text("USD"),
                            value: "USD",
                          ),
                        ],
                        onChanged: (option){
                        setState(() {
                          selected = option!;
                        });
                    }),

                    TextFormField(),
                    
                    CustomButton(label: "Submit")

                  ],
                ),
              ));
              },
          ),)
        ],
      ),
    );
  }
}
