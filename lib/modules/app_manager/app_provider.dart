import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String currentLanguage = 'en';
  String currentTheme = 'light';

  void changeLanguage(String newLanguage) {
    if (newLanguage == currentLanguage) {
      return;
    }
    currentLanguage = newLanguage;
    notifyListeners();
  }

  void changeTheme(String newTheme) {
    if (newTheme == currentTheme) {
      return;
    }
    currentTheme = newTheme;
    notifyListeners();
  }
}
