import 'package:flutter/material.dart';

import 'colors.dart';

var themeData = ThemeData(
  cardColor: lightPurple,
  scaffoldBackgroundColor: darkPurple,
  shadowColor: orange,
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      color: white,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(color: orange),
    errorStyle: const TextStyle(color: red),
    suffixIconColor: orange,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(width: 3, color: orange),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(width: 3, color: orange),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(width: 3, color: red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(width: 3, color: red),
    ),
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStatePropertyAll(
        TextStyle(fontSize: 25),
      ),
      backgroundColor: MaterialStatePropertyAll(orange),
    ),
  ),
);
