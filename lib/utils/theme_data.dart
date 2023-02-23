import 'package:flutter/material.dart';

import 'colors.dart';

var themeData = ThemeData(
  cardColor: lightPurple,
  scaffoldBackgroundColor: darkPurple,
  shadowColor: orange,
  textTheme: const TextTheme(
    titleSmall: TextStyle(color: white),
    displayLarge: TextStyle(color: white),
    displayMedium: TextStyle(color: white),
    displaySmall: TextStyle(color: white),
    titleLarge: TextStyle(color: white),
    titleMedium: TextStyle(color: white),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStatePropertyAll(orange),
      iconSize: MaterialStatePropertyAll(30),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: lightPurple,
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
      padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
      backgroundColor: MaterialStatePropertyAll(orange),
    ),
  ),
);

InputDecoration simpleInputDecoration({String? hint}) {
  return InputDecoration(
    hintText: hint,
    labelStyle: const TextStyle(color: orange),
    errorStyle: const TextStyle(color: red),
    suffixIconColor: orange,
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(width: 3, color: orange),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(width: 3, color: orange),
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(width: 3, color: red),
    ),
    focusedErrorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(width: 3, color: red),
    ),
  );
}
