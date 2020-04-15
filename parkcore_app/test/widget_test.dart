// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:parkcore_app/screens/home.dart';
import 'package:parkcore_app/parking/add_parking.dart';

//void main() {
//  testWidgets('MyHomePage has a title', (WidgetTester tester) async {
//    // Create the widget by telling the tester to build it.
//    await tester.pumpWidget(MyHomePage());
//    // Use the `findsOneWidget` matcher provided by flutter_test to verify
//    // that the Text widgets appear exactly once in the widget tree.
//    final titleFinder = find.text('ParkCore');
//    expect(titleFinder, findsOneWidget);
//  });
//}

void main() {
  testWidgets('My Home Page Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: "ParkCore"),
    ));

    // Create the finders
    final titleFinder = find.text('ParkCore');
    final Finder searchinput = find.widgetWithText(TextFormField, 'Search by location');
    final Finder submit = find.widgetWithIcon(IconButton, Icons.search);

    // Use the `findsNWidgets` matcher provided by flutter_test to
    // verify this Text widget appears exactly 2 times in the widget tree.
    expect(titleFinder, findsNWidgets(2));

    // Finds 1 TextFormField Widget (for search input field in 1 Form)
    expect(find.byType(TextFormField),findsOneWidget);
    expect(find.byType(Form),findsOneWidget);

    // Finds 3 IconButton Widgets (search, ParkCore logo, and menu icons)
    expect(find.byType(IconButton),findsNWidgets(3));

    // Test form search field input
    await tester.enterText(searchinput, 'Chico, CA');
    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();
    // Expect Text Widget message
    expect(find.text('Find parking near: Chico, CA'), findsOneWidget);

  });

  testWidgets('My Add Parking Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    // Create the finders
    final titleFinder = find.text('Post Your Parking Space');
    // Use the `findsNWidgets` matcher provided by flutter_test to
    // verify this Text widget appears exactly 2 times in the widget tree.
    expect(titleFinder, findsOneWidget);
  });

//  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(MaterialApp(
//      home: MyHomePage(title: "ParkCore"),
//    ));
//
//    // Verify that our counter starts at 0.
//    expect(find.text('0'), findsOneWidget);
//    expect(find.text('1'), findsNothing);
//
//    // Tap the '+' icon and trigger a frame.
//    await tester.tap(find.byIcon(Icons.add));
//    await tester.pump();
//
//    // Verify that our counter has incremented.
//    expect(find.text('0'), findsNothing);
//    expect(find.text('1'), findsOneWidget);
//  });
}
