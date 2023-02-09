import 'package:flutter/material.dart';
import 'package:kiosk/pages/dashboard/widgets/dash_order_list.dart';
import 'package:kiosk/utils/app_state.dart';
import 'package:kiosk/utils/user.dart';
import 'package:kiosk/widgets/metrics_card.dart';
import 'package:kiosk/pages/dashboard/widgets/primary_card.dart';
import 'package:kiosk/pages/dashboard/widgets/info_card.dart';
import 'package:kiosk/pages/dashboard/widgets/todo_card.dart';
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
  // late User user;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // user = Provider.of<AppState>(context).user!;
  }

  @override
  void initState() {
    super.initState();

    // user ??= Provider.of<AppState>(context).user!;
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Left columns
          _DashColumn(
            headline: Text("Good morning, ${Provider.of<AppState>(context).user!.username}",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w400)),
            subheadline: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dashboard",
                  style: Theme.of(context).textTheme.headlineSmall,
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
            child: _DashColumn(
              rightColumn: true,
              headline: ActionCard(
                  icon: Icons.help_outline,
                  label: "Help and Feedback ",
                  filled: false),
              subheadline: ActionCard(
                icon: Icons.access_time_outlined,
                label: "20 Sep 2022 - 20 Nov 2022",
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
                  listBuilder: (context, index) => Row(
                        children: [
                          Text("Aaron Andon"),
                          const Spacer(),
                          Text("12/14/22"),
                          const Spacer(),
                          Icon(
                            Icons.chat,
                            color: Colors.black,
                          ),
                          Icon(
                            Icons.chat,
                            color: Colors.black,
                          ),
                        ],
                      )),
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
