import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  Color themeData;
  Color BackgroundColors;
  Color IconColors;
  Color placeHolderColor;
  ThemeNotifier(this.themeData,this.BackgroundColors,this.IconColors,this.placeHolderColor);
  Color getTheme() => themeData;
  Color getbackground() => BackgroundColors;
  Color getIcon() => IconColors;
  Color getplaceHolderColor() => placeHolderColor;

  setTheme(Color color) async {
    themeData = color;
    notifyListeners();
  }
  setbackground(Color color) async {
    BackgroundColors = color;
    notifyListeners();
  }
  setIcon(Color color) async {
    IconColors = color;
    notifyListeners();
  }
  setPlaceHolderColor(Color color) async {
    placeHolderColor = color;
    notifyListeners();
  }
}