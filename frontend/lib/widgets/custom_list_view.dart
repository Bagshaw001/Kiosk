import 'package:flutter/material.dart';


class CustomListView extends StatelessWidget {
  final double height;
  final double width;
  final int? itemCount;
  final Widget Function(int) builder;
  const CustomListView({
    required this.height,
    required this.width,
    this.itemCount,
    required this.builder,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (context,index)=> builder(index)
      ),
    );
  }
}
