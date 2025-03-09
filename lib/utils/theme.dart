import 'package:flutter/material.dart';
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colors.blue,
      secondary: Colors.lightBlueAccent,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16.0),
    ),
  );
  
}