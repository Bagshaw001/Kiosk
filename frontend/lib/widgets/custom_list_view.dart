import 'package:flutter/material.dart';


class CustomListView extends StatelessWidget {
  final double height;
  final double width;
  final Widget Function(int) builder;
  const CustomListView({
    required this.height,
    required this.width,
    required this.builder,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
          itemBuilder: (context,index)=> builder(index)
      ),
    );
  }
}
