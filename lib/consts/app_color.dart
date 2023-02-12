import 'package:flutter/material.dart';

class AppColor {
  static const appBarBackgroundColor = Colors.white;
  static const primaryColor = Color.fromRGBO(29, 155, 240, 1);
  static const black = Colors.black;
  static const Color grey = Color(0xff403F3D);

  static final appPrimarySwatch = MaterialColor(
    primaryColor.value,
    const <int, Color>{
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    },
  );
}
