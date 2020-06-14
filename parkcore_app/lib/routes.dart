import 'package:flutter/widgets.dart';
import 'package:parkcore_app/screens/home.dart';
import 'package:parkcore_app/authenticate/login_fireship.dart';
import 'package:parkcore_app/parking/add_parking.dart';
import 'package:parkcore_app/parking/find_parking.dart';
import 'package:parkcore_app/screens/form_success.dart';
import 'package:parkcore_app/screens/contact.dart';
import 'package:parkcore_app/screens/about.dart';
import 'package:parkcore_app/parking/pform/add_parking1.dart';
import 'package:parkcore_app/parking/pform/add_parking2.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/': (context) => LoginPage(),
  '/home': (context) => MyHomePage(title: 'ParkCore'),
  '/add_parking': (context) => AddParking(title: 'Post Your Parking Space'),
  '/find_parking': (context) => FindParking(
    title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}',
  ),
  '/form_success': (context) => FormSuccess(),
  '/contact': (context) => ContactUs(),
  '/about': (context) => About(),
  '/add_parking1': (context) => AddParking1(title: 'Post New Parking Space'),
  '/add_parking2': (context) => AddParking2(
    title: 'Post New Parking Space', parkingData: null, curUser: null),
};
