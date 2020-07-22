import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:parkcore_app/screens/home.dart';
import 'package:parkcore_app/screens/contact.dart';
import 'package:parkcore_app/screens/about.dart';
import 'package:parkcore_app/parking/find_parking.dart';
import 'package:parkcore_app/parking/pform/add_parking1.dart';

void main() {
  testWidgets('Find Menu Drawer Logo', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MenuDrawer(),
    ));

    expect(find.bySemanticsLabel('ParkCore Logo'), findsOneWidget);
  });

  testWidgets('Find Menu Drawer List Tiles', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MenuDrawer(),
    ));

    expect(find.byType(ListTile), findsNWidgets(5));
  });

  testWidgets('Find home menu item key', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    final routes = <String, WidgetBuilder>{
      '/home' : (BuildContext context) => MyHomePage(title: 'ParkCore'),
    };

    await tester.pumpWidget(MaterialApp(
      home: MenuDrawer(),
      initialRoute: '/',
      routes: routes,
    ));

    // Find logoButton
    expect(find.byKey(Key('homeKey')), findsOneWidget);
  });

  testWidgets('tap map item to go to Find Parking page', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    final routes = <String, WidgetBuilder>{
      '/find_parking': (context) => FindParking(
        title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}',
      ),
    };

    await tester.pumpWidget(MaterialApp(
      home: MenuDrawer(),
      initialRoute: '/',
      routes: routes,
    ));

    // Find logoButton
    final buttonFinder = find.byKey(Key('menuMap'));
    await tester.tap(buttonFinder);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    final titleFinder = find.text('Find Parking');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Tap Home button in menu', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    final routes = <String, WidgetBuilder>{
      '/home' : (BuildContext context) => MyHomePage(title: 'ParkCore'),
    };

    await tester.pumpWidget(MaterialApp(
      home: MenuDrawer(),
      initialRoute: '/',
      routes: routes,
    ));

    // Find logoButton
    final buttonFinder = find.byKey(Key('homeKey'));
    await tester.tap(buttonFinder);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    final titleFinder = find.text('ParkCore');
    expect(titleFinder, findsOneWidget);
  });

//  testWidgets('Tap Add Parking button in menu', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//
//    final routes = <String, WidgetBuilder>{
//      '/add_parking': (context) => AddParking(title: 'Post Your Parking Space'),
//    };
//
//    await tester.pumpWidget(MaterialApp(
//      home: MenuDrawer(),
//      initialRoute: '/',
//      routes: routes,
//    ));
//
//    // Find logoButton
//    final buttonFinder = find.byKey(Key('addParkingKey'));
//    await tester.tap(buttonFinder);
//    await tester.pump();
//    await tester.pump(const Duration(milliseconds: 10));
//    final titleFinder = find.text('Post Your Parking Space');
//    expect(titleFinder, findsOneWidget);
//  });
  testWidgets('Tap New Add Parking button in menu', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    final routes = <String, WidgetBuilder>{
      '/add_parking1': (context) => AddParking1(title: 'Post Your Parking Space'),
    };

    await tester.pumpWidget(MaterialApp(
      home: MenuDrawer(),
      initialRoute: '/',
      routes: routes,
    ));

    // Find logoButton
    final buttonFinder = find.byKey(Key('addParking1Key'));
    await tester.tap(buttonFinder);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    final titleFinder = find.text('Post Your Parking Space');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Tap Contact Us button in menu', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    final routes = <String, WidgetBuilder>{
      '/contact': (context) => ContactUs(),
    };

    await tester.pumpWidget(MaterialApp(
      home: MenuDrawer(),
      initialRoute: '/',
      routes: routes,
    ));

    // Find logoButton
    final buttonFinder = find.byKey(Key('contactKey'));
    await tester.tap(buttonFinder);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    final titleFinder = find.text('Contact Us');
    expect(titleFinder, findsNWidgets(2));
  });

  testWidgets('Tap About Us button in menu', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    final routes = <String, WidgetBuilder>{
      '/about': (context) => About(),
    };

    await tester.pumpWidget(MaterialApp(
      home: MenuDrawer(),
      initialRoute: '/',
      routes: routes,
    ));

    // Find logoButton
    final buttonFinder = find.byKey(Key('aboutKey'));
    await tester.tap(buttonFinder);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    final titleFinder = find.text('About ParkCore');
    expect(titleFinder, findsNWidgets(2));
  });
}