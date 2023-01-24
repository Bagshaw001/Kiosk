import 'package:flutter/material.dart';
import 'package:kiosk/widgets/metrics_card.dart';
import 'package:kiosk/pages/dashboard/widgets/primary_card.dart';
import 'package:kiosk/pages/dashboard/widgets/info_card.dart';
import 'package:kiosk/pages/dashboard/widgets/todo_card.dart';
import 'package:kiosk/utils/constants.dart';
import 'package:kiosk/utils/webpage.dart';
import 'package:kiosk/widgets/action_card.dart';
import 'package:kiosk/widgets/card_list.dart';
import 'package:kiosk/widgets/custom_button.dart';

class Dashboard extends Webpage {
  Dashboard() : super(large: _DashboardLarge());
}

class _DashboardLarge extends StatefulWidget {
  const _DashboardLarge({super.key});

  @override
  State<_DashboardLarge> createState() => __DashboardLargeState();
}

class __DashboardLargeState extends State<_DashboardLarge> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [

          //Left columns
          _DashColumn(
            first: Text("Good morning, Omeibi Bagshaw"),
            second: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dashboard"),
                Text("Preview your account summary"),
                Row(
                  children: [
                    InfoCard(
                      label: "Revenue",
                      content: "1,000",
                      currency: "GHS",
                      rightButton: CustomButton(
                        label: "Link Account",
                      ),
                      leftButton: CustomButton(
                        label: "Withdraw",
                        filled: true,
                      ),
                    ),
                    PrimaryCard(
                      number: "78796-89765-7889-65464",
                      name: "Bright Augustt",
                      expiry: "12/22",
                    )
                  ],
                )
              ],
            ),
            third: Row(
              children: [],
            ),
            fourth: MetricsCard(),
          ),


          //Right columns
          SizedBox(
            width: MediaQuery.of(context).size.width *0.2,
            child: _DashColumn(
              rightColumn: true,
              first: Column(
                children: [
                  ActionCard(
                    icon: Icons.access_time_outlined,
                    label: "20 Sep 2022 - 20 Sep 2022",
                    filled: false
                  ),
                  ActionCard(
                    icon: Icons.help_outline,
                    label: "Help and Feedback"
                  )
                ],
              ),
              second: InfoCard(
                label: "Taxes",
                content: "10",
                currency: "GHS",
                leftButton: CustomButton(
                  label: "Calculate",
                  filled: true,
                ),
                rightButton: CustomButton(
                  label: "Pay",
                ),
              ),
              third: TodoCard(),
              fourth: CardList(
                label: "Messages",
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _DashColumn extends StatelessWidget {
  final bool rightColumn;
  final Widget first;
  final Widget second;
  final Widget third;
  final Widget fourth;
  const _DashColumn(
      {required this.first,
      required this.second,
        this.rightColumn = false,
      required this.third,
      required this.fourth,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: rightColumn ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.11,
          width: size.width * ( rightColumn ? 0.1 : 0.55),
          child: first,
        ),
        Expanded(
          child: second,
        ),
        Expanded(
          child: third,
        ),
        Expanded(
          child: fourth,
        ),
      ],
    );
  }
}
