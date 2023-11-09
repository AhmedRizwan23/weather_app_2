import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_2/theme/theme.dart';

class Themeprovider with ChangeNotifier {
  ThemeData _themeData = lightmode;

  ThemeData get themedata => _themeData;

  set themedata(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightmode) {
      themedata = darkmode;
    } else {
      themedata = lightmode;
    }
  }

  // IconData changebutton() {
  //   if (_themeData == lightmode) {
  //     return Icons.toggle_off;
  //   } else {
  //     return Icons.toggle_on;
  //   }
}
