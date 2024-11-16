import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier{
  ThemeMode currentTheme=ThemeMode.light;
  String currentLang='en';
  void changeAppTheme(ThemeMode newTheme){
    if(newTheme==currentTheme)
      return;
    currentTheme=newTheme;
    notifyListeners();
  }
  void changeAppLang(String lang){
    if(lang==currentLang)
      return;
    currentLang=lang;
    notifyListeners();
  }

  void dataUpdated(){
    notifyListeners();
  }
}