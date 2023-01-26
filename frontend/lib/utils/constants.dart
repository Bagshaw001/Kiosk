
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

const int largeScreen = 1080;
const int smallScreen = 900;

const  blue = Color(0xFF004D73);
final MaterialColor blueMaterial = createMaterialColor(blue);


//Function code taken from medium article :https://medium.com/@nickysong/creating-a-custom-color-swatch-in-flutter-554bcdcb27f3
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
// End of code reference

 enum OrderStatus{
  completed,
  inProgress,
  cancelled
}


