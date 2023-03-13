import "package:flutter/material.dart";
import "package:kiosk/widgets/custom_button.dart";
import "package:kiosk/widgets/custom_textfield.dart";


class WithdrawalSettings extends StatefulWidget {
  const WithdrawalSettings({Key? key}) : super(key: key);

  @override
  _WithdrawalSettingsState createState() => _WithdrawalSettingsState();
}

class _WithdrawalSettingsState extends State<WithdrawalSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _StatCard(
                label: "Total Sales Quantity",
                value: "500",
                color: Colors.purpleAccent
            ),
            _StatCard(
                label: "Total Sales Quantity",
                value: "500",
                color: Colors.purpleAccent
            ),
            _StatCard(
                label: "Total Sales Volume",
                value: "GHC 500",
                color: Colors.blue
            ),
            _StatCard(
                label: "Total Available Balance",
                value: "GHC 20",
                color: Colors.green
            ),
          ],
        ),

        Row(
          children: [
            const Spacer(),
            Text("Withdrawal History",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomButton(
                filled: true,
                label: "Withdraw Bank",
                onPressed: (){
                  showDialog(context: context, builder: (context)=> AlertDialog(
                    content: Column(
                      children: [
                        CustomTextField(
                          label: "Beneficiary Name",
                        ),
                        CustomTextField(
                          label: "Beneficiary Number (05xxxxx)",
                        ),

                        CustomButton(
                            label: "Submit Request",
                          onPressed: (){

                          },
                        )
                      ],
                    ),
                  ));
                },
              ),
            ),


            CustomButton(
              filled: true,
              label: "Withdraw momo",
              onPressed: (){
                showDialog(context: context, builder: (context)=> AlertDialog(
                  content: Column(
                    children: [
                      CustomTextField(
                        label: "Beneficiary Name",
                      ),
                      CustomTextField(
                        label: "Beneficiary Number (05xxxxx)",
                      ),

                      CustomButton(
                          label: "Submit Request",
                        onPressed: (){

                        },
                      )
                    ],
                  ),
                ));
              },
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Transaction ID"),
              Text("Transaction Date"),
              Text("Amount Withdrawn"),
              Text("Beneficiary Name"),
              Text("Beneficiary Number"),
              Text("Collaborator Name"),
              Text("Status"),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemBuilder: (context,index) => Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("adjtfdsdf4564"),
                    Text("22 Dec 2022"),
                    Text("GHC 120"),
                    Text("Kingsley Collins"),
                    Text("055 455 9858"),
                    Text("Veron Omeibi"),
                    Text("Pending"),
                  ],
                ),
              )
          ),
        )
      ],
    );
  }
}




class _StatCard extends StatelessWidget {
  final String label;
  final Color color;
  final String value;
  const _StatCard({
    Key? key,
    required this.label,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        children: [
          Text(value, style: Theme.of(context).textTheme.headlineSmall,),
          Text(label, style: Theme.of(context).textTheme.labelLarge,)
        ],
      ),
    );
  }
}

