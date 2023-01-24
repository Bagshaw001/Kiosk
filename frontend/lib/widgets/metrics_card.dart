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
                style: Theme.of(context).textTheme.titleLarge!
                .copyWith(color: Colors.white),

              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                _MetricInfo(label: "Sales", value: "320k"),
                _MetricInfo(label: "Customers", value: "500"),
                _MetricInfo(label: "Products", value: "5"),
                _MetricInfo(label: "Revenue", value: "4056"),

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
                      )
                    ],
                  ),
                  Placeholder()
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
  final String value;
  const _MetricInfo({
    required this.label,
    required this.value,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Icon(Icons.account_circle_rounded,size: 40,)
          ],
        ),
        Column(
          children: [
            Text(value,
              style: Theme.of(context).textTheme.titleMedium!
              .copyWith(color: Colors.white),
            ),
            Text(label,
              style: Theme.of(context).textTheme.caption!
              .copyWith(color: Colors.white),
            )
          ],
        )
      ],
    );
  }
}

