import 'package:flutter/material.dart';
import 'package:kiosk/utils/constants.dart';
import 'package:kiosk/widgets/custom_button.dart';


class MetricsCard extends StatelessWidget {
  final bool showActions;
  const MetricsCard({
    this.showActions = true,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: blue,
      child: Container(
        width: size.width *0.5,
        height:  size.height *0.2,
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom:8.0),
              child: Text("Metrics",
                style: Theme.of(context).textTheme.titleMedium!
                .copyWith(color: Colors.white),

              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:const [

                _MetricInfo(
                    label: "Sales",
                    value: "320k",
                  image: "metrics_sales",
                  color: Colors.purpleAccent,
                ),
                _MetricInfo(
                  label: "Customers",
                  value: "500",
                  image: "metrics_customers",
                  color: Colors.lightBlue,
                ),
                _MetricInfo(
                  label: "Products",
                  value: "5",
                  image: "metrics_products",
                  color: Colors.redAccent,
                ),
                _MetricInfo(
                  label: "Revenue",
                  value: "4056",
                  image: "metrics_revenue",
                  color: Colors.greenAccent,
                ),

              ],
            ),
            showActions ? Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Summary of your financial report",
                      style: Theme.of(context).textTheme.bodyMedium!
                          .copyWith(color: Colors.white),
                      ),
                      CustomButton(
                          label: "Download",
                        outlineBorderColor: Colors.white,
                        outlineTextColor: Colors.white,
                        onPressed: (){

                        },
                      )
                    ],
                  ),
                  Image.asset("assets/images/metrics_image.png")
                ],
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }
}




class _MetricInfo extends StatelessWidget {
  final String label;
  final String image;
  final Color color;
  final String value;
  const _MetricInfo({
    required this.label,
    required this.value,
    required this.image,
    required this.color,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.all(4),
              decoration:  BoxDecoration(
                  color: color,
                shape: BoxShape.circle
              ),
              child: Image.asset("assets/images/$image.png",width: 40,height: 40,),
            ),
            // Icon(Icons.account_circle_rounded,size: 40,)
          ],
        ),
        Column(
          children: [
            Text(value,
              style: Theme.of(context).textTheme.titleSmall!
              .copyWith(color: Colors.white),
            ),
            Text(label,
              style: Theme.of(context).textTheme.bodySmall!
              .copyWith(color: Colors.white),
            )
          ],
        )
      ],
    );
  }
}

