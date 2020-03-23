import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primarySwatch: Colors.green,
    backgroundColor: Colors.green[300],
    accentColor: Colors.orange[300],
    textTheme: TextTheme(
      headline: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.grey[850],
      ),
      display1: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
        color: Colors.grey[600],
      ),
      display2: TextStyle(
        fontSize: 20.0,
        fontFamily: 'Montserrat',
        color: Colors.grey[800],
      ),
    ),
  );
}
