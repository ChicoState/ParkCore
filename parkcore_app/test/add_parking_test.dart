// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/parking/add_parking.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';


void main() {

  testWidgets('Find Add Parking Form', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    // expect to find 1 form
    expect(find.byType(Form),findsOneWidget);
  });

  testWidgets('Find Add Parking Form Title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    // Find title
    final titleFinder = find.text('Post Your Parking Space');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Find Parking Form page text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(find.text("Part 1 of 5"), findsOneWidget);
  });

  testWidgets('Find Parking Form Buttons', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    // Finds 2 IconButton Widgets (ParkCore logo, and menu icons)
    expect(find.byType(IconButton),findsNWidgets(2));
  });

  testWidgets('Find One Menu Icon Button (Add Parking)', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    // Find 1 Menu Icon Button
    expect(find.widgetWithIcon(IconButton, Icons.menu),findsOneWidget);
  });

  testWidgets('Find Parking Form RaisedButton Field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(find.byType(RaisedButton),findsOneWidget);
  });

  testWidgets('Find Parking Form page 1 submit button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(find.widgetWithText(RaisedButton, 'Next: Parking Space Info'), findsOneWidget);
  });

  testWidgets('Find Parking Form Text Fields', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(find.byType(TextFormField),findsNWidgets(4));
  });

  testWidgets('Find Parking Form DropDown Field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(find.byType(DropDownFormField),findsOneWidget);
  });

  testWidgets('Find Parking Form DropDown for State', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(find.widgetWithText(DropDownFormField, 'State'),findsOneWidget);
  });

  testWidgets('Enter title for parking space', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    // Create the finders
    final Finder title = find.byKey(Key('title'));

    // Test text field form input
    await tester.enterText(title, 'Parking Space Title');

    // Expect Text Widget message
    expect(find.text("Parking Space Title"), findsOneWidget);
  });

  testWidgets('Validate title for parking space', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().validateTitle('Parking Space Title'), isNull);
  });

  testWidgets('Check parking space title is empty', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().validateTitle(''), "Field can\'t be empty");
  });

  testWidgets('Check parking space title length', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    String longstr = "too long parkin spot title"; //26 chars

    expect(AddParking().createState().validateTitle(longstr),
        'Title cannot be more than 25 characters');
  });

  testWidgets('Enter address for parking space', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    // Create the finders
    final Finder address = find.byKey(Key('address'));

    // Test text field form input
    await tester.enterText(address, 'My Address');

    // Expect Text Widget message
    expect(find.text("My Address"), findsOneWidget);
  });

  testWidgets('Validate address for parking space', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().validateAddress('My Address'), isNull);
  });

  testWidgets('Check address for parking space is empty', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().validateAddress(''), "Field can\'t be empty");
  });

  testWidgets('Validate address length', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    String longstr = "abcdefghijklmnopqrstuvwxyz1234abcdefghijklmnopqrstuvwxyz12345";

    expect(AddParking().createState().validateAddress(longstr),
        "Address cannot be more than 60 characters");
  });

  testWidgets('Enter city for parking space', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    // Create the finders
    final Finder city = find.byKey(Key('city'));

    // Test text field form input
    await tester.enterText(city, 'Chico');

    // Expect Text Widget message
    expect(find.text("Chico"), findsOneWidget);
  });

  testWidgets('Validate city for parking space', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().validateCity('Chico'), isNull);
  });

  testWidgets('Check city for parking space is empty', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().validateCity(''), "Field can\'t be empty");
  });

  testWidgets('Validate state for parking space', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().validateState('CA'), isNull);
  });

  testWidgets('Check state for parking space is empty', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().validateState(''), "Field can\'t be empty");
  });

  testWidgets('Enter zip for parking space', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    // Create the finders
    final Finder zip = find.byKey(Key('zip'));

    // Test text field form input
    await tester.enterText(zip, '95928');

    // Expect Text Widget message
    expect(find.text("95928"), findsOneWidget);
  });

  testWidgets('Validate zip for parking space', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().validateZip('95928'), isNull);
  });

  testWidgets('Check zip for parking space is empty', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().validateZip(''), "Field can\'t be empty");
  });

  testWidgets('Check zip for parking space too short', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().validateZip('1234'), 'Enter your 5 digit zip code');
  });

  testWidgets('Check zip for parking space too long', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().validateZip('123456'), 'Enter your 5 digit zip code');
  });

  testWidgets('Check if zip has spaces', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().validateZip('12 45'), "Field can\'t contain spaces");
  });

  testWidgets('Check if zip has non-numeric', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().validateZip('12a45'), "Enter a valid 5 digit US zip code");
  });

  testWidgets('Check if zip has special', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().validateZip('12-45'), "Enter a valid 5 digit US zip code");
  });

  testWidgets('Check if parking space price is empty', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().validatePrice(''), "Field can\'t be empty");
  });

  testWidgets('Check if parking space price has spaces', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().validatePrice('1 2'), "Field can\'t contain spaces");
  });

  testWidgets('Check no username', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().getUserName(), "no current user");
  });

  testWidgets('Check no user id', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));

    expect(AddParking().createState().getUserID(), "no current user");
  });

//  testWidgets('callback', (WidgetTester tester) async {
//    var pressed = false;
//    final onPressed = () => pressed = true;
//
//    await tester.pumpWidget(
//      MaterialApp(
//        home: RaisedButton(
//          child: Text('Next: Parking Space Info'),
//          onPressed: onPressed,
//        ),
//      ),
//    );
//
//    await tester.tap(find.byType(RaisedButton));
//
//    expect(pressed, isTrue);
//  });
}
