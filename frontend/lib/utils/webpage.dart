

import 'package:flutter/cupertino.dart';

class Webpage{
  final Widget large;
  late final Widget small;

  Webpage({required this.large,Widget? small}){
    this.small = small ?? Container(child:Text("Small"));
  }
}