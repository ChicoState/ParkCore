import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/parking/parking_details.dart';
import 'package:parkcore_app/screens/home.dart';
import 'package:parkcore_app/models/Spot.dart';

void main() {
  final myMap = Map<String,dynamic>();
  myMap['title'] = 'My Parking Spot';
  myMap['address'] = '123 Main St';
  myMap['amenities'] = '[Lit, Covered, Security Camera, EV Charging]';
  myMap['coordinates'] = '{39.7285,-121.8375}';
  myMap['city'] = 'Chico';
  myMap['driveway'] = 'Whole Driveway';
  myMap['monthprice'] = '42.00';
  myMap['spacetype'] = 'N/A';
  myMap['downloadURL'] = null;
  myMap['type'] = 'Driveway';
  myMap['size'] = 'Compact';
  myMap['days'] = '[MON, TUE, WED, THU, FRI]';
  myMap['spacedetails'] = 'near the park and downtown';
  myMap['starttime'] = '08:00';
  myMap['endtime'] = '16:00';
  myMap['state'] = 'CA';
  myMap['zip'] = '95928';
  myMap['uid'] = 'randomuid';
  final mySpot = Spot.fromMap(myMap);

  testWidgets(
      'Find One Clear Icon Button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));

    // Find 1 Icon Button with Semantics Label (x out of page)
    expect(find.widgetWithIcon(IconButton, Icons.clear), findsOneWidget);
  });

  testWidgets('Find SingleChildScrollView Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));

    // Find Widget for SingleChildScrollView
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });

  testWidgets(
      'Find One Logo Button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));

    // Find 1 Icon Button (ParkCore logo => returns to home page)
    expect(find.byKey(Key('logoButton')), findsOneWidget);
  });

  testWidgets('Tap logo button to navigate from ParkingDetails to Home page',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.

    final routes = <String, WidgetBuilder>{
      '/home' : (BuildContext context) => MyHomePage(title: 'ParkCore'),
    };

    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
      initialRoute: '/',
      routes: routes,
    ));

    // Find logoButton
    final buttonFinder = find.byKey(Key('logoButton'));
    // Tap logoButton
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();
    // Expect to navigate home
    expect(find.byKey(Key('homeAppTitle')), findsOneWidget);
  });

  testWidgets(
      'Find Reserve Button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));

    // Find Reserve Button
    expect(find.text('Reserve'), findsOneWidget);
  });

  testWidgets('Click Reserve Button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));

    // Find Reserve Button
    final buttonFinder = find.widgetWithText(RaisedButton, 'Reserve');
    // Tap Reserve Button
    await tester.tap(buttonFinder);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    // Expect to stay on same page (for now)
    expect(find.text('Reserve'), findsOneWidget);
  });

  testWidgets('Find LinearProgressIndicator Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));

    // Find Widget for LinearProgressIndicator widget
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

//  testWidgets('Tap clear button in AppBar', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//
//    final routes = <String, WidgetBuilder>{
//      '/find_parking' : (BuildContext context) => FindParking(
//          title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
//    };
//
//    await tester.pumpWidget(MaterialApp(
//      home: DetailScreen(spot: mySpot),
//      initialRoute: '/',
//      routes: routes,
//    ));
//
//    // Find 'clear' Button
//    final buttonFinder = find.widgetWithIcon(IconButton, Icons.clear);
//    await tester.tap(buttonFinder);
//    await tester.pump();
//    await tester.pump(const Duration(milliseconds: 10));
//    final titleFinder = find.text('Find Parking');
//    expect(titleFinder, findsOneWidget);
//  });
}