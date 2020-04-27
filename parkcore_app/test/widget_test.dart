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
import 'package:dropdown_formfield/dropdown_formfield.dart';
//import 'package:geocoder/geocoder.dart';


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

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify this Text widget appears exactly 1 time in the widget tree.
    expect(titleFinder, findsOneWidget);

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
    final Finder title = find.byKey(Key('title'));
    final Finder address = find.byKey(Key('address'));
    final Finder city = find.byKey(Key('city'));
    final Finder zip = find.byKey(Key('zip'));

    final Finder submit = find.widgetWithText(RaisedButton, 'Next: Parking Space Info');

    // Use the `findsNWidgets` matcher provided by flutter_test to
    // verify this Text widget appears exactly 2 times in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(find.text("Part 1 of 5"), findsOneWidget);

    // expect to find 1 form
    expect(find.byType(Form),findsOneWidget);
    // On 1st page of form, find 4 TextFormField Widgets, 1 DropDownFormField
    // Widget, and 1 Raised Button
    expect(find.byType(TextFormField),findsNWidgets(4));
    expect(find.byType(DropDownFormField),findsOneWidget);
    expect(find.byType(RaisedButton),findsOneWidget);

    // Test text field form input
    await tester.enterText(title, '');
    await tester.enterText(address, '');
    await tester.enterText(city, '');
    await tester.enterText(zip, '');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();
    // Expect Text Widget message
    //expect(find.text("We can't find you!\nPlease enter a valid location."), findsOneWidget);
  });
}
