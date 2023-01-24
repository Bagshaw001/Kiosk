import 'package:flutter/material.dart';
import 'package:kiosk/widgets/custom_button.dart';


class InfoCard extends StatelessWidget {
  final String label;
  final String currency;
  final String content;
  final CustomButton rightButton;
  final CustomButton leftButton;
  const InfoCard({
    required this.label,
    required this.currency,
    required this.content,
    required this.rightButton,
    required this.leftButton,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      Size size = MediaQuery.of(context).size;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: size.width *0.25,
        height:  size.height *0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
            style: Theme.of(context).textTheme.titleLarge,),
            RichText(text: TextSpan(
                text: "c $content ",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
                children: [
                  TextSpan(
                      text: "($currency)",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey)
                  ),


                ]
            )),

            Theme(
              data: Theme.of(context).copyWith(

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  leftButton,
                  rightButton,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
