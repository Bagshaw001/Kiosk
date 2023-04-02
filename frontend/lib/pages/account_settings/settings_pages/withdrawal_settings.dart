import "package:flutter/material.dart";
import "package:kiosk/utils/api_handler.dart";
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
            children: const [
              Flexible(
                child: Text("Transaction ID"),
              ),
              Flexible(
                child: Text("Transaction Date"),
              ),
              Flexible(
                child: Text("Amount"),
              ),
              Flexible(
                flex: 2,
                child: Text("Beneficiary Name"),
              ),
              Flexible(
                flex: 2,
                child: Text("Beneficiary Number"),
              ),
              Flexible(
                flex: 2,
                child:  Text("Collaborator Name"),
              ),
              Flexible(
                child: Text("Status"),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder(
            initialData: [
              {
                "transaction_id" : "1442455",
                "transaction_date" : DateTime.now().toIso8601String(),
                "amount" : 4,
                "beneficiary_name" : "Kingsley Collins",
                "beneficiary_number" : "055 487 8555",
                "collaborator_name" : "Mr Smith",
                "status" : "pending"
              }
            ],
            builder: (context,snapshot){
              if (snapshot.data == null){
                return const Text("No withdrawals yet");
              }
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context,index) => Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: Text(snapshot.data![index]["transaction_id"].toString()),
                        ),
                        Flexible(
                          child: Text(DateTime.parse(snapshot.data![index]["transaction_date"].toString()).toString()),
                        ),
                        Flexible(
                          child: Text("GHS ${(snapshot.data![index]["amount"] as double).toStringAsFixed(2)}"),
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(snapshot.data![index]["beneficiary_name"].toString()),
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(snapshot.data![index]["beneficiary_number"].toString()),
                        ),
                        Flexible(
                          flex: 2,
                          child:  Text(snapshot.data![index]["collaborator_name"].toString()),
                        ),
                        Flexible(
                          child: Text(snapshot.data![index]["status"].toString()),
                        ),
                      ],
                    ),
                  )
              );
            },
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

