import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primarySwatch: Colors.green,
    backgroundColor: Color(0xFF67BE88),
    accentColor: Color(0xFF7E57C2),
    textTheme: TextTheme(
      headline: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        letterSpacing: 6.0,
        color: Colors.grey[850],
      ),
      display1: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
        color: Colors.grey[600],
      ),
      display2: TextStyle(
        fontSize: 20.0,
        fontFamily: 'Roboto',
        color: Colors.grey[800],
      ),
      display3: TextStyle(
        fontSize: 18.0,
        fontFamily: 'Roboto',
        color: Colors.white,
      ),
      display4: TextStyle(
        fontSize: 16.0,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
        color: Color(0xFF358D5B),
      ),
    ),
  );
}
