import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/parking/parking_details.dart';
import 'package:parkcore_app/parking/find_parking.dart';
import 'package:parkcore_app/screens/home.dart';
import 'package:parkcore_app/models/Spot.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  var myMap = <String,dynamic>{};
  myMap['title'] = 'My Parking Spot';
  myMap['address'] = '123 Main St';
  myMap['amenities'] = '[Lit, Covered, Security Camera, EV Charging]';
  myMap['coordinates'] = '{39.7285,-121.8375}';
  myMap['city'] = 'Chico';
  myMap['driveway'] = 'Right';
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
  myMap['uid'] = 'no current user';
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

  testWidgets('Find Reserve Button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));

    // Find Reserve Button
    expect(find.text('Reserve'), findsOneWidget);
  });

  testWidgets('Find Spot month cost', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.text('\$42/month'), findsOneWidget);
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

  testWidgets('Find widget for parking space image', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));

    // Find Parking Space Image widget
    expect(find.byKey(Key('spotimage')), findsOneWidget);
  });

  testWidgets('Find owner text -- Name Withheld', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.text('Name Withheld'), findsOneWidget);
  });

  testWidgets('Find owner rating bar', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.byType(RatingBar), findsOneWidget);
  });

  testWidgets('Find star icons', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.byIcon(Icons.star), findsNWidgets(5));
  });

  testWidgets('Find parking spot title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.text('My Parking Spot'), findsOneWidget);
  });

  testWidgets('No parking spot address shown', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.text(myMap['address']), findsNothing);
  });

  testWidgets('Find city icon', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.byIcon(Icons.location_city), findsOneWidget);
  });

  testWidgets('Find location text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.text('Chico CA, 95928'), findsOneWidget);
  });

  testWidgets('Find directions_car icon', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.byIcon(Icons.directions_car), findsOneWidget);
  });

  testWidgets('Find spot type text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.text('Spot type: Driveway'), findsOneWidget);
  });

  testWidgets('Find driveway info', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.text('Right driveway'), findsOneWidget);
  });

  testWidgets('Find spot size text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.text('Size: Compact'), findsOneWidget);
  });

  testWidgets('Find security icon', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.byIcon(Icons.security), findsOneWidget);
  });

  testWidgets('Find list of amenities', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.text('Lit, Covered, Security Camera, EV Charging'), findsOneWidget);
  });

  testWidgets('Find timelapse icon', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.byIcon(Icons.timelapse), findsOneWidget);
  });

  testWidgets('Find time availability', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.text('Availability: 08:00 - 16:00'), findsOneWidget);
  });

  testWidgets('Find calendar_today icon', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.byIcon(Icons.calendar_today), findsOneWidget);
  });

  testWidgets('Find days availability', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.text('MON, TUE, WED, THU, FRI'), findsOneWidget);
  });

  testWidgets('Find Space Details headline', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.text('Space Details'), findsOneWidget);
  });

  testWidgets('Find space details info', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.text('near the park and downtown'), findsOneWidget);
  });

  testWidgets('Find Amenities Sized Box', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    mySpot.amenities = '';
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.byKey(Key('amenitiesSizedBox')), findsOneWidget);
  });

  testWidgets('Find Time Sized Box', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    mySpot.starttime = '';
    mySpot.endtime = '';
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.byKey(Key('timeSizedBox')), findsOneWidget);
  });

  testWidgets('Find Days Sized Box', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    mySpot.days = '';
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.byKey(Key('daysSizedBox')), findsOneWidget);
  });

  testWidgets('Find Details Title Sized Box', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    mySpot.spacedetails = '';
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.byKey(Key('detailsTitleBox')), findsOneWidget);
  });

  testWidgets('Find Space Details Sized Box', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    mySpot.spacedetails = '';
    await tester.pumpWidget(MaterialApp(
      home: DetailScreen(spot: mySpot),
    ));
    expect(find.byKey(Key('spaceDetailsBox')), findsOneWidget);
  });

//  testWidgets('Find LinearProgressIndicator Widget', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(MaterialApp(
//      home: DetailScreen(spot: mySpot),
//    ));
//
//    // Find Widget for LinearProgressIndicator widget
//    expect(find.byType(LinearProgressIndicator), findsOneWidget);
//  });

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
//    final iconFinder = find.byIcon(Icons.menu);
//    expect(iconFinder, findsOneWidget);
//  });
}