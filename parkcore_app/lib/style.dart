import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primarySwatch: Colors.green,
    backgroundColor: Colors.green[900],
    textTheme: TextTheme(
      headline2: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.white70,
      ),
      headline3: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
        color: Colors.grey[600],
      ),
      headline5: TextStyle(
        fontSize: 20.0,
        fontFamily: 'Georgia',
      ),
    ),
  );
}