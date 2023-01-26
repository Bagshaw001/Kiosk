import 'package:kiosk/utils/constants.dart';
import 'package:kiosk/utils/webpage.dart';
import 'package:flutter/material.dart';
import 'package:kiosk/widgets/action_card.dart';
import 'package:kiosk/widgets/custom_button.dart';
import 'package:kiosk/widgets/page_list/page_list.dart';
import 'package:kiosk/widgets/page_list/widgets/page_list_tab.dart';

class Transactions extends Webpage {
  Transactions() : super(large: _LargeTransactions());
}

class _LargeTransactions extends StatefulWidget {
  const _LargeTransactions({Key? key}) : super(key: key);

  @override
  __LargeTransactionsState createState() => __LargeTransactionsState();
}

class __LargeTransactionsState extends State<_LargeTransactions> {
  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Spacer(),

              ActionCard(
                filled: false,
                icon: Icons.help_outline,
                label: "Help and Feedback",
              )
            ]
          ),
          Text("Transactions",
          style: Theme.of(context).textTheme.headlineMedium!
            .copyWith(fontWeight: FontWeight.bold)

          ),

          Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text("All transactions",
          style: Theme.of(context).textTheme.titleLarge),
            ),
          PageList(
            selectedTab: _selectedTab,
            tabs: [
              PageListTab(
                label: "All Sales",
                count: 20,
                  selected:  0 == _selectedTab
              ),
              PageListTab(
                label: "Delivered",
                count: 15,
                  selected:  1 == _selectedTab,
                color: Colors.green
              ),
              PageListTab(
                label: "Confirmed",
                color: Colors.blue,
                count: 5,
                  selected:  2 == _selectedTab
              ),
              PageListTab(
                label: "Approved",
                count: 3,
                color: Colors.orange,
                  selected:  3 == _selectedTab
              ),
            ],
            actions: Row(
              children: [
                _DateDropdown(label: "From"),
                _DateDropdown(label: "To"),
                CustomButton(
                  label: "Order",
                  filled: true,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _DateDropdown extends StatefulWidget {
  final String label;

  const _DateDropdown({required this.label, Key? key}) : super(key: key);

  @override
  __DateDropdownState createState() => __DateDropdownState();
}

class __DateDropdownState extends State<_DateDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: blue.withOpacity(0.5)),
      child: Column(
        children: [Text(widget.label), Text("11/08/2023")],
      ),
    );
  }
}
