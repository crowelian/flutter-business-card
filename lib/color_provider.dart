import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ColorProvider with ChangeNotifier {
  Color _backgroundColor = Color.fromRGBO(255, 106, 0, 1);

  Color get backgroundColor => _backgroundColor;

  void changeBackgroundColor(Color newColor) {
    _backgroundColor = newColor;
    notifyListeners();
  }
}
