



import 'dart:convert';

import 'package:kiosk/models/product.dart';
import 'package:kiosk/utils/api_handler.dart';
import 'package:kiosk/utils/app_state.dart';
import 'package:kiosk/utils/constants.dart';
import 'package:kiosk/utils/webpage.dart';
import 'package:flutter/material.dart';
import 'package:kiosk/widgets/action_card.dart';
import 'package:kiosk/widgets/custom_button.dart';
import 'package:kiosk/widgets/custom_list_view.dart';
import 'package:kiosk/widgets/custom_textfield.dart';
import 'package:kiosk/widgets/page_list/page_list.dart';
import 'package:kiosk/widgets/page_list/widgets/extended_list_tile.dart';
import 'package:kiosk/widgets/page_list/widgets/page_list_tab.dart';
import 'package:provider/provider.dart';

class Inventory extends Webpage{

  Inventory(): super(large: _LargeInventory());

}





class _LargeInventory extends StatefulWidget {
   _LargeInventory({Key? key}) : super(key: key);

  @override
  __LargeInventoryState createState() => __LargeInventoryState();
}

class __LargeInventoryState extends State<_LargeInventory> {
  int selectedTab = 0;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Positioned(
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
          const Text("All inventory available in your stores"),

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
              onPressed: ()async{
              bool? update = await showDialog(context: context, builder: (context)=> _AddProductDialog());
              if(update ?? false){
                (context as Element).reassemble();
              }
              },
          ),
            child: FutureBuilder(
              future: ApiHandler.getProducts(context.read<AppState>().user.storeId),
              builder: (context,snapshot){
                if (snapshot.connectionState == ConnectionState.done){
                  List<Product> products = snapshot.data ?? [];
                  return CustomListView(
                      height: size.height * 0.6,
                      width: size.width * 0.8,
                      itemCount: products.length,
                      builder: (index){
                        Product prod= products.elementAt(index);
                        return ExtendedListTile(
                          content: [
                            Checkbox(value: false, onChanged: (value){}),
                            Text(prod.name),
                            Text(prod.id),
                            Text("${prod.currency.name.toUpperCase()} ${prod.price}"),
                            Text("${prod.quantity}"),
                            // Text(prod.),

                            ListTag(
                              label: "Active",
                              color: Colors.blue,
                            ),

                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.black,),
                              onPressed: ()async{
                                bool? update = await showDialog(context: context, builder: (context)=> _AddProductDialog(product: prod));
                                if(update ?? false){
                                  (context as Element).reassemble();
                                }
                              },
                            )
                          ],
                        );
                      }
                  );
                }
                return const CircularProgressIndicator();
              },
            ),)
        ],
      ),
    );
  }
}





class _AddProductDialog extends StatefulWidget {
  final Product? product;

   _AddProductDialog({this.product,Key? key}) : super(key: key);

  @override
  State<_AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<_AddProductDialog> {
  TextEditingController productName = TextEditingController();

  TextEditingController productDesc = TextEditingController();

  TextEditingController price = TextEditingController();

  TextEditingController quantity = TextEditingController();

  Currency currency = Currency.ghs;

  @override
  void initState() {
    super.initState();
    if(widget.product != null){
      price.text = widget.product!.price.toString();
      quantity.text = widget.product!.quantity.toString();
      currency = widget.product!.currency;
      productDesc.text = widget.product!.description;
      productName.text = widget.product!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Upload Product",
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          CustomTextField(
            controller: productName,
            label: "Product Name",
          ),

          CustomTextField(
            controller: productDesc,
            label: "Description",

          ),


          DropdownButton(
              value: currency,
              items: List.generate(Currency.values.length, (index) =>
                  DropdownMenuItem(
                      value: Currency.values[index],
                      child: Text(Currency.values.elementAt(index).name)
                  )
              ),
              onChanged: (option){
                setState(() {
                  currency = option!;
                });
              }),
          CustomTextField(
            label: "Price",
            controller: price,

          ),
          CustomTextField(
            label: "Quantity",
            controller: quantity,

          ),


          CustomButton(
            label: widget.product == null ? "Submit" : "Edit",
            filled: true,
            onPressed: ()async{
              Product product = Product(
                  id :widget.product?.id ?? "",
                  name: productName.text,
                  description: productDesc.text,
                  storeId: context.read<AppState>().user.storeId,
                  currency: currency,
                  price : double.parse(price.text),
                  quantity: int.parse(quantity.text)
              );
              (widget.product == null ?
              ApiHandler.uploadProduct(product: product) :ApiHandler.editProduct(product: product) ).then((response){
                Map<String,dynamic> json = jsonDecode(response.body);
                //if product upload was successful, get product id and
                // upload product variations
                if(json["statusCode"] == 200){
                  Navigator.pop(context, true);
                }else {
                  print("something went wrong");
                }
              });

            },
          )

        ],
      ),
    );
  }
}
