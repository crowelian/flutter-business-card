import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_business_card/main_colors.dart';
import 'package:flutter_business_card/preferences.dart';

class ColorProvider with ChangeNotifier {
  Color _backgroundColor = MainColors.defaultBackgroundColor;

  ColorProvider() {
    initState();
  }

  Color get backgroundColor => _backgroundColor;

  void initState() {
    loadBackgroundColor().then((value) => {changeBackgroundColor(value)});
  }

  void changeBackgroundColor(Color newColor) {
    _backgroundColor = newColor;
    notifyListeners();
  }
}
