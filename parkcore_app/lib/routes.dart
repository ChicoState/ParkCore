import 'package:flutter/widgets.dart';
import 'package:parkcore_app/home.dart';
import 'package:parkcore_app/onboard.dart';
import 'package:parkcore_app/add_parking.dart';
import 'package:parkcore_app/find_parking.dart';


final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/': (context) => OnBoard(title: 'Welcome'),
  '/home': (context) => MyHomePage(title: 'ParkCore'),
  '/add_parking': (context) => AddParking(title: 'Add Parking'),
  '/find_parking': (context) => FindParking(title: 'Find Parking'),
};