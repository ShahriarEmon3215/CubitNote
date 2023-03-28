import 'package:cubit_note/core/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextStyle appBarTextStyle(bool isDarkMode) {
  if (isDarkMode) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 255, 255, 255),
    );
  } else {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 0, 0, 0),
    );
  }
}

TextStyle titleTextStyle(bool isDarkMode) {
  if (isDarkMode) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 218, 218, 218),
    );
  } else {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 58, 58, 58),
    );
  }
}

TextStyle bodyTextStyle(bool isDarkMode) {
  if (isDarkMode) {
    return TextStyle(
      fontSize: 16,
      color: Color.fromARGB(255, 230, 230, 230),
    );
  } else {
    return TextStyle(
      fontSize: 16,
      color: Color.fromARGB(255, 104, 104, 104),
    );
  }
}
