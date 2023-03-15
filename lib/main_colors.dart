import 'package:flutter/material.dart';

class MainColors {
  static Color mainColor = const Color.fromRGBO(0, 0, 0, 1);
  static Color mainColorInertedOpacity100 = Color.fromRGBO(
      255 - mainColor.red, 255 - mainColor.green, 255 - mainColor.blue, 0.4);
  static Color mainColorShade900 = mainColor.withOpacity(0.9);
  static Color boxColor = Colors.white;
  static Color red = Color.fromRGBO(227, 25, 55, 1);
  static Color burgundy = Color.fromRGBO(153, 31, 61, 1);
  static Color purple = Color.fromRGBO(82, 64, 171, 1);
  static Color purpleDark = Color.fromRGBO(32, 10, 88, 1);

  static Color lightGray = Color.fromRGBO(225, 225, 225, 1);
  static Color orange = Color.fromRGBO(255, 106, 0, 1);
  static Color orangeLight = Color.fromRGBO(255, 195, 153, 1);

  static Color textColor = Color.fromRGBO(255, 255, 255, 1);

  static Color debugColor = Color.fromARGB(255, 247, 8, 215);

  static Color teal = Colors.teal;
}
