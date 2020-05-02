// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/screens/home.dart';

void main() {
  testWidgets('Find Home Page Title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: "ParkCore"),
    ));

    // Create the finder
    final titleFinder = find.text('ParkCore');

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify this Text widget appears exactly 1 time in the widget tree.
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('find PARKCORE text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: "ParkCore"),
    ));

    // Find text PARKCORE once
    expect(find.text('PARKCORE'), findsOneWidget);
  });

  testWidgets('find PARKCORE tagline text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: "ParkCore"),
    ));

    // Find tagline text once
    expect(find.text('find a spot. go nuts.'), findsOneWidget);
  });

  testWidgets('Find Search Bar Form', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: "ParkCore"),
    ));

    // Finds 1 Form Widget
    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('Find Search Bar Form Text Field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: "ParkCore"),
    ));

    // Finds 1 TextFormField Widget (for search input field in 1 Form)
    expect(find.byType(TextFormField), findsOneWidget);
  });

  testWidgets('Find Home Page Buttons', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: "ParkCore"),
    ));

    // Finds 3 IconButton Widgets (search, ParkCore logo, and menu icons)
    expect(find.byType(IconButton), findsNWidgets(3));
  });

  testWidgets(
      'Find One ParkCore Logo Icon Button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: "ParkCore"),
    ));

    // Find 1 Icon Button with Semantics Label (ParkCore logo)
    expect(find.bySemanticsLabel('ParkCore Logo'), findsOneWidget);
  });

  testWidgets('Find One Menu Icon Button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: "ParkCore"),
    ));

    // Find 1 Menu Icon Button
    expect(find.widgetWithIcon(IconButton, Icons.menu), findsOneWidget);
  });

  testWidgets('Find One Search Icon Button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: "ParkCore"),
    ));

    // Finds 1 Search IconButton
    expect(find.widgetWithIcon(IconButton, Icons.search), findsOneWidget);
  });

  testWidgets(
      'Check search result not initially visible', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: "ParkCore"),
    ));

    // Expect Text Widget message
    expect(find.text('Find parking near:'), findsNothing);
  });

  testWidgets('Check search input match', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: "ParkCore"),
    ));

    // Create the finders
    final Finder searchinput = find.widgetWithText(
        TextFormField, 'Search by location');
    final Finder submit = find.widgetWithIcon(IconButton, Icons.search);

    // Test form search field input
    await tester.enterText(searchinput, 'Chico, CA');
    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();

    // Expect Text Widget message
    expect(find.text('Find parking near: Chico, CA'), findsOneWidget);
  });

  testWidgets('check search successfully finds a location', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: "ParkCore"),
    ));

    // Create the finders
    final completer = Completer<String>();
    final Finder searchinput = find.widgetWithText(
        TextFormField, 'Search by location');
    final Finder submit = find.widgetWithIcon(IconButton, Icons.search);

    // Test form search field input
    await tester.enterText(searchinput, 'Chico, CA');
    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();

    expect(MyHomePage().createState().getLocation(), isTrue);
  });
}
