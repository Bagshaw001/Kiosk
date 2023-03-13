import "package:flutter/material.dart";
import 'package:kiosk/models/linked_accounts.dart';
import 'package:kiosk/utils/api_handler.dart';
import 'package:kiosk/utils/app_state.dart';
import 'package:kiosk/utils/webpage.dart';
import 'package:kiosk/widgets/custom_button.dart';
import 'package:provider/provider.dart';


class Accounts extends Webpage{
  Accounts() : super(large: const _AccountsLarge());

}





class _AccountsLarge extends StatefulWidget {
  const _AccountsLarge({Key? key}) : super(key: key);

  @override
  __AccountsLargeState createState() => __AccountsLargeState();
}

class __AccountsLargeState extends State<_AccountsLarge> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Text("Accounts", style: Theme.of(context).textTheme.headlineMedium,),
        Text("Manage Social media accounts", style: Theme.of(context).textTheme.titleSmall,),
        Expanded(
          child: Row(
            children: [

              //Left Column
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16) + const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width * 0.37,
                      height: size.height * 0.4,
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black38, width: 0.55)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Connect Accounts", style: Theme.of(context).textTheme.titleLarge,),
                          ),
                          CustomButton(
                            label: "Link Account",
                            filled: true,
                            padding: const EdgeInsets.only(top:4, left: 8),
                            width: size.width * 0.07,
                            onPressed: (){

                            },
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                              child: Row(
                                children: [
                                  Text("Name", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                  const Spacer(),
                                  Text("Date", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                  const Spacer(),
                                  Text("Platform", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                          const Divider(thickness: 1,),
                          Expanded(
                            flex: 3,
                            child: FutureBuilder<List<LinkedAccount>>(
                              initialData: [],
                              future: ApiHandler.getLinkedAccounts(context.read<AppState>().user.storeId),
                              builder: (context,snapshot){
                                if (snapshot.data!.isEmpty){
                                  return const Center(child: Text("No accounts have been linked yet"));
                                }
                                return ListView.builder(
                                  itemBuilder: (context,index) => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Business name"),
                                      const Spacer(),
                                      Text("06/12/2023"),
                                      const Spacer(),
                                      IconButton(
                                        icon: Icon(Icons.whatshot,color: Colors.black),
                                        onPressed: (){

                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,color: Colors.black,),
                                        onPressed: (){

                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),




                    Container(
                      width: size.width * 0.37,
                      height: size.height * 0.4,
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black38, width: 0.55)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Create Post", style: Theme.of(context).textTheme.titleLarge,),
                          ),
                          CustomButton(
                            label: "Link Account",
                            filled: true,
                            padding: const EdgeInsets.only(top:4, left: 8),
                            width: size.width * 0.07,
                            onPressed: (){

                            },
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                              child: Row(
                                children: [
                                  Text("Name", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                  const Spacer(),
                                  Text("Name", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                  const Spacer(),
                                  Text("Name", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                          // const Divider(thickness: 1,),
                        ],
                      ),
                    ),


                  ],
                ),
              ),

              //Right Column
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16) + const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width * 0.37,
                      height: size.height * 0.4,
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black38, width: 0.55)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Connect Accounts", style: Theme.of(context).textTheme.titleLarge,),
                          ),
                          CustomButton(
                            label: "Link Account",
                            filled: true,
                            padding: const EdgeInsets.only(top:4, left: 8),
                            width: size.width * 0.07,
                            onPressed: (){

                            },
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                              child: Row(
                                children: [
                                  Text("Name", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                  const Spacer(),
                                  Text("Name", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                  const Spacer(),
                                  Text("Name", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                          const Divider(thickness: 1,),
                          Expanded(
                            flex: 3,
                            child: ListView.builder(
                              itemBuilder: (context,index) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Business name"),
                                  const Spacer(),
                                  Text("06/12/2023"),
                                  const Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.whatshot,color: Colors.black),
                                    onPressed: (){

                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,color: Colors.black,),
                                    onPressed: (){

                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),




                    Container(
                      width: size.width * 0.37,
                      height: size.height * 0.4,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black38, width: 0.55)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Create Post", style: Theme.of(context).textTheme.titleLarge,),
                          ),
                          CustomButton(
                            label: "Link Account",
                            filled: true,
                            padding: const EdgeInsets.only(top:4, left: 8),
                            width: size.width * 0.07,
                            onPressed: (){

                            },
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                              child: Row(
                                children: [
                                  Text("Name", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                  const Spacer(),
                                  Text("Name", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                  const Spacer(),
                                  Text("Name", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                          // const Divider(thickness: 1,),
                        ],
                      ),
                    ),


                  ],
                ),
              ),






              //Right Column







            ],
          ),
        ),
      ],
    );
  }
}
