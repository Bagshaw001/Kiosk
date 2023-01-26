import "package:flutter/material.dart";
import 'package:kiosk/utils/constants.dart';
import 'package:kiosk/widgets/card_list.dart';


class DashOrderList extends StatefulWidget {
  const DashOrderList({Key? key}) : super(key: key);

  @override
  _DashOrderListState createState() => _DashOrderListState();
}

class _DashOrderListState extends State<DashOrderList> {
  @override
  Widget build(BuildContext context) {
    return CardList(
        label: "Orders",
        listBuilder: (context,index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration:const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 0.5,
                      color: Colors.black
                  )
              )
          ),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Edusei"),
                  Text("ID: PT2135",
                    style: Theme.of(context).textTheme.caption,)
                ],
              ),
              const Spacer(),
              Text("Jewelry"),
              const Spacer(),
              Text("200",
                  style: Theme.of(context).textTheme.bodyText1!
                      .copyWith(fontWeight: FontWeight.bold)
              ),
              const Spacer(),
              _StatusCard(status: OrderStatus.cancelled),
              const Spacer(),
              const Icon(Icons.info_outline, color: Colors.black,)
            ],
          ),
        )
    );
  }
}




class _StatusCard extends StatelessWidget {
  final List<Color> statusColors = [Colors.green,blue,Colors.orange];
  final List<String> statusText = ["Completed", "In Progress", "Cancelled"];
  final OrderStatus status;
   _StatusCard({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: statusColors[status.index].withOpacity(0.5),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Text(statusText[status.index]),
    );
  }
}
