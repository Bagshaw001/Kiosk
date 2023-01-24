import 'package:flutter/material.dart';
import 'package:kiosk/utils/constants.dart';

ThemeData mainTheme = ThemeData(
    primarySwatch: blueMaterial,
    iconTheme: const IconThemeData(color: Colors.white),
    listTileTheme: const ListTileThemeData(
      selectedColor: Colors.black,
      selectedTileColor: Colors.white,
      textColor: Colors.white,
      iconColor: Colors.white,
    ),
    cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            width: 0.5,
            color: Colors.black
          )

        ),
        elevation: 6,

    ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(blue),
      minimumSize: MaterialStateProperty.all(const Size(130,45)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide.none
        ))
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(130,45)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide.none
        ))

    )
  )
);
