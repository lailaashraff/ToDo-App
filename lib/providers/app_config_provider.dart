import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../my_theme.dart';

class AppConfigProvider extends ChangeNotifier{
  String appLanguage = 'en';
  ThemeData appTheme = MyTheme.lightTheme;

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }

  void changeTheme(ThemeData newTheme) {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    notifyListeners();
  }

  bool isDarkMode() {
    return appTheme == MyTheme.darkTheme;
  }

}