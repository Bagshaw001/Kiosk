import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiosk/pages/dashboard/widgets/dash_order_list.dart';
import 'package:kiosk/utils/app_state.dart';
import 'package:kiosk/utils/user.dart';
import 'package:kiosk/widgets/metrics_card.dart';
import 'package:kiosk/pages/dashboard/widgets/primary_card.dart';
import 'package:kiosk/pages/dashboard/widgets/info_card.dart';
import 'package:kiosk/utils/webpage.dart';
import 'package:kiosk/widgets/action_card.dart';
import 'package:kiosk/widgets/card_list.dart';
import 'package:kiosk/widgets/custom_button.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    super.initState();

    // user ??= Provider.of<AppState>(context).user!;
  }

  @override
  Widget build(BuildContext context) {
    String date;
    int hour = DateTime.now().hour;
    if (hour < 12){
      date = "morning";
    }else if (hour < 16){
      date = "afternoon";
    }else {
      date = "evening";
    }


    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Left columns
          _DashColumn(
            headline: Text("Good $date, ${ context.read<AppState>().user.username}",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!),
            subheadline: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dashboard",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text("Preview your account summary"),
                ),
              ],
            ),
            second: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        onPressed: (){

                        },
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
            third: SizedBox(
              width: MediaQuery.of(context).size.width * 0.51,
              child: DashOrderList(),
            ),
            fourth: MetricsCard(),
          ),

          //Right columns
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Card(
              child: Column(
                children: [
                  SizedBox(
                    child: const Text("Messages"),
                    height: MediaQuery.of(context).size.height*0.05,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context,index) => ListTile(
                        leading: const Icon(FontAwesomeIcons.whatsapp),
                        title: Text("Person name",style: const TextStyle(color: Colors.black),),
                        subtitle: Text("Person message stuff about things",style: const TextStyle(color: Colors.black),),
                        onTap: (){

                        },
                      ),
                    ),
                  )
                ],
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
  final Widget subheadline;
  final Widget headline;
  final Widget second;
  final Widget third;
  final Widget fourth;
  const _DashColumn(
      {required this.second,
      required this.subheadline,
      required this.headline,
      this.rightColumn = false,
      required this.third,
      required this.fourth,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          rightColumn ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        headline,
        subheadline,
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
