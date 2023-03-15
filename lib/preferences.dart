import 'package:flutter/material.dart';
import 'package:flutter_business_card/main_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveBackgroundColor(Color color) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setInt('background_color', color.value);
}

Future<Color> loadBackgroundColor() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  int colorAsValue = sharedPreferences.getInt('background_color') ??
      MainColors.defaultBackgroundColor.value;
  return Color(colorAsValue);
}
