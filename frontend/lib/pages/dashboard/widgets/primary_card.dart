import 'package:flutter/material.dart';
import 'package:kiosk/utils/constants.dart';
import 'package:kiosk/widgets/hyper_link.dart';


class PrimaryCard extends StatelessWidget {
  final String name;
  final String number;
  final String expiry;
  const PrimaryCard({
    Key? key,
    required this.name,
    required this.number,
    required this.expiry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

      Size size = MediaQuery.of(context).size;

    return  Theme(
      data: ThemeData(
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: Theme.of(context).textTheme.copyWith(
          bodyMedium: const TextStyle(color: Colors.white),
        )
      ),
      child: Card(
        color: blue,
        elevation: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
        child: Container(
            padding: const EdgeInsets.all(12),
            width: size.width *0.25,
            height:  size.height *0.2,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Primary Card",
                        style: Theme.of(context).textTheme.titleMedium!
                        .copyWith(color: Colors.white),),
                      Hyperlink(text: "See all Cards", onPressed: (){}),
                      const Spacer(),
                      Text(number),
                      const Spacer(),
                      Text(name),


                    ]
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.credit_card_outlined),
                    const Spacer(),
                    Text(expiry)
                  ],
                )
              ],
            )

        ),
      ),
    );
  }
}
