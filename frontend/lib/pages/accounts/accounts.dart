import "package:flutter/material.dart";
import 'package:kiosk/utils/webpage.dart';
import 'package:kiosk/widgets/custom_button.dart';
import 'package:kiosk/widgets/metrics_card.dart';


class Accounts extends Webpage{
  Accounts() : super(large:_AccountsLarge());

}





class _AccountsLarge extends StatefulWidget {
  const _AccountsLarge({Key? key}) : super(key: key);

  @override
  __AccountsLargeState createState() => __AccountsLargeState();
}

class __AccountsLargeState extends State<_AccountsLarge> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        //First Row
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Card(
                child: Container(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text("Hello Bagshaw"),
                          Text("Set your year's goal"),
                          CustomButton(
                            label: "Set Goals",
                            filled: true,
                          )
                        ],
                      ),
                      Placeholder(
                        fallbackWidth: 180,
                      )
                    ],
                  ),
                ),
              ),
              MetricsCard( showActions: false,)
            ],
          ),
        ),




        // Second Row
        Expanded(
          flex: 2,
          child: Row(
            children: [

              Column(
                children: [
                  Row(
                    children: [
                      Card(
                        child: Container(
                          child: Column(
                            children: [
                              Text("Orders"),
                              Text("4,79k"),
                              Placeholder(
                                fallbackWidth: 120,
                                fallbackHeight: 120,
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          child: Column(
                            children: [
                              Text("Profit"),
                              Text("4,79k"),
                              Placeholder(
                                fallbackWidth: 120,
                                fallbackHeight: 120,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  //Earning card
                  Card(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text("Earning"),
                            Text("This Month"),
                            Text("\$4277.19"),
                            Text("56.2% more earnings than last month"),
                          ],
                        ),
                        Placeholder(
                          fallbackWidth: 110,
                          fallbackHeight:90,
                        )
                      ],
                    ),
                  )
                ],
              ),

              Card(
                child: Row(
                  children: [

                    //Report graph
                    Container(
                      width: 700,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text("Revenue Report"),
                                Spacer(),
                                Text("Earning"),
                                Text("Expense")
                              ],
                            ),
                          ),
                          Placeholder(
                            fallbackWidth: 120,
                            fallbackHeight: 180,
                          )
                        ],
                      ),
                    ),
                    VerticalDivider(),

                    //Budget graph
                    Container(
                      child: Column(
                        children: [
                          Text("2022"),
                          Text("c 30,489"),
                          Text("Budget: 63,000"),
                          Placeholder(fallbackHeight: 80,
                            fallbackWidth: 150,
                          ),
                          CustomButton(label: "Update Budget", filled: true,)
                        ],
                      ),
                    )
                  ],
                ),
              )

            ],
          ),
        ),

        //Third Row
        Expanded(
          flex: 2,
          child: Row(
            children: [

            ],
          ),
        ),
      ],
    );
  }
}
