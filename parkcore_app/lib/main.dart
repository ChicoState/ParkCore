import 'package:flutter/material.dart';
import 'package:parkcore_app/home.dart';
import 'package:parkcore_app/onboard.dart';

// This application can be run with "flutter run".
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ParkCore',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => OnBoard(title: 'Welcome'),
        '/home': (context) => MyHomePage(title: 'ParkCore'),
      },
    );
  }
}