


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
  String selectedCurrency = "GHS";
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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

          Text("Inventory",
          style: Theme.of(context).textTheme.headlineMedium!
            .copyWith(fontWeight: FontWeight.bold),),
          Text("All inventory available in your stores"),
          PageList(
            selectedTab: selectedTab,
            tabs: [
              PageListTab(label: "All Items", count: 20, selected:  0 == selectedTab,),
              PageListTab(label: "Active", count: 15, selected:  1 == selectedTab ),
              PageListTab(label: "Inactive", count: 5, selected:  2 == selectedTab),
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
                      value: selectedCurrency,
                        items: const [
                          DropdownMenuItem(
                              value: "GHS",
                              child: Text("GHS"),
                          ),
                          DropdownMenuItem(
                              value: "USD",
                              child: Text("USD"),
                          ),
                        ],
                        onChanged: (option){
                        setState(() {
                          selectedCurrency = option!;
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
