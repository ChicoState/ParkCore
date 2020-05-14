import 'package:flutter/material.dart';
import 'package:parkcore_app/routes.dart';
import 'package:parkcore_app/theme/style.dart';

// This application can be run with 'flutter run'.
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ParkCore',
      theme: appTheme(),
      initialRoute: '/',
      routes: routes,
    );
  }
}
