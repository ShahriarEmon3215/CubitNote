import 'package:flutter/material.dart';

class ThemeController with ChangeNotifier {
  bool? isDarkTheme;

  ThemeController({this.isDarkTheme});

  ThemeData get getThemeData => isDarkTheme! ? darkTheme : lightTheme;

  set setThemeData(bool val) {
    if (val) {
      isDarkTheme = false;
    } else {
      isDarkTheme = true;
    }
    notifyListeners();
  }
}

final darkTheme = ThemeData(
    primaryColor: Color.fromARGB(255, 36, 36, 54),
    dividerColor: Colors.black54,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
        .copyWith(
          background: Color.fromARGB(255, 36, 36, 54),
        )
        .copyWith(secondary: Colors.white)
        .copyWith(brightness: Brightness.dark));

final lightTheme = ThemeData(
    primaryColor: Colors.white,
    dividerColor: Colors.white54,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
        .copyWith(background: Color(0xFFE5E5E5))
        .copyWith(secondary: Colors.black)
        .copyWith(brightness: Brightness.light));
