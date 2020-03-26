import 'package:flutter/widgets.dart';
import 'package:parkcore_app/screens/home.dart';
import 'package:parkcore_app/authenticate/login_fireship.dart';
import 'package:parkcore_app/parking/add_parking.dart';
import 'package:parkcore_app/parking/find_parking.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/': (context) => LoginPage(),
  '/home': (context) => MyHomePage(title: 'ParkCore'),
  '/add_parking': (context) => AddParking(title: 'Post Your Parking Space'),
  '/find_parking': (context) => FindParking(title: 'Find Parking'),
};
