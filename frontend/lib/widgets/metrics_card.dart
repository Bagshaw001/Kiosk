import 'package:flutter/material.dart';
import 'package:kiosk/utils/api_handler.dart';
import 'package:kiosk/utils/app_state.dart';
import 'package:kiosk/utils/constants.dart';
import 'package:kiosk/widgets/custom_button.dart';
import 'package:provider/provider.dart';


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
        padding: const EdgeInsets.all(12),
        child: FutureBuilder<Map<String,dynamic>>(
          future: ApiHandler.getMetrics(context.read<AppState>().user.storeId),
          initialData: const {
            "order_count": 0,
            "customer_count" : 0,
            "product_count" : 0,
            "revenue" : 0
          },
          builder: (context, snapshot){
            return Column(
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
                  children: [

                    _MetricInfo(
                      label: "Orders",
                      value: snapshot.data!["order_count"].toString(),
                      image: "metrics_sales",
                      color: Colors.purpleAccent,
                    ),
                    _MetricInfo(
                      label: "Customers",
                      value: snapshot.data!["customer_count"].toString(),
                      image: "metrics_customers",
                      color: Colors.lightBlue,
                    ),
                    _MetricInfo(
                      label: "Products",
                      value: snapshot.data!["product_count"].toString(),
                      image: "metrics_products",
                      color: Colors.redAccent,
                    ),
                    _MetricInfo(
                      label: "Revenue",
                      value: snapshot.data!["revenue"].toString(),
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
            );
          },
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

