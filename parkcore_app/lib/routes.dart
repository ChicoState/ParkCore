import 'package:flutter/widgets.dart';
import 'package:parkcore_app/home.dart';
import 'package:parkcore_app/onboard.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/': (context) => OnBoard(title: 'Welcome'),
  '/home': (context) => MyHomePage(title: 'ParkCore'),
};