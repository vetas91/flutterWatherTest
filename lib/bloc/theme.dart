import 'package:first_flutter_app/styles/styles_weather.dart';
import 'package:flutter/material.dart';

class ThemeObservable with ChangeNotifier {
  ThemeData _themeData;

  ThemeObservable(this._themeData);

  ThemeData get themeData => _themeData;

  void setThemeData(ThemeData themeData) {
    if (_themeData != themeData) {
      _themeData = themeData;
      notifyListeners();
    }
  }

  void toggle() {
    setThemeData(isLight() ? darkTheme : lightTheme);
  }

  bool isLight() => _themeData == lightTheme;
}
