import 'package:flutter/material.dart';




class ThemeProvider extends ChangeNotifier{
  ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
        surface:Colors.black,
        primary: Colors.white,
        secondary: Colors.white70,
        inversePrimary:Colors.black
    ),
    textTheme: ThemeData.dark().textTheme.apply(
        bodyColor:Colors.white,
        displayColor: Colors.black
    ),

  );

  ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
        surface: Colors.white,
        primary: Colors.black,
        secondary: Colors.black12,
        inversePrimary: Colors.black38),
    textTheme: ThemeData.light()
        .textTheme
        .apply(bodyColor: Colors.black, displayColor: Colors.white),
  );
  @override
  notifyListeners();
}