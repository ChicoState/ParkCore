import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/parking/pform/add_parking_submit.dart';
import 'package:parkcore_app/parking/pform/add_parking1.dart';
import 'package:parkcore_app/models/ParkingData.dart';
import 'package:parkcore_app/models/ParkingData2.dart';
import 'package:parkcore_app/models/ParkingData3.dart';
import 'package:parkcore_app/screens/form_success.dart';

void main() {
  final parkData1 = ParkingData(
      'MyTitle',
      '12 Main St',
      'Chico',
      'CA',
      '95928',
      'randomuid',
      '{39.7285,-121.8375}',
      '{39.7285,-121.8375}');
  final parkData2 = ParkingData2('Compact', 'Parking Lot', 'N/A', 'Angled',
      ['Lit', 'Covered', 'Security Camera', 'EV Charging'], 'Extra info');
  final parkData3 = ParkingData3(['MON', 'TUE', 'WED', 'THU', 'FRI'], '08:00',
      '20:00', '42.00');
  final username = 'Grace Hopper';

  testWidgets('Find Add Parking Form Review Page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParkingSubmit(parkingData: parkData1, parkingData2: parkData2,
          parkingData3: parkData3, curUser: username),
    ));

    // expect to find 1 form
    expect(find.byType(Form),findsOneWidget);
  });

  testWidgets('Find Add Parking Form Title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParkingSubmit(parkingData: parkData1, parkingData2: parkData2,
          parkingData3: parkData3, curUser: username),
    ));

    // Find title
    final titleFinder = find.text('Post Your Parking Space');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Find Parking Form page text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParkingSubmit(parkingData: parkData1, parkingData2: parkData2,
          parkingData3: parkData3, curUser: username),
    ));

    expect(find.text('Part 5 of 5'), findsOneWidget);
  });

  testWidgets('Find Parking Form no image selected text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParkingSubmit(parkingData: parkData1, parkingData2: parkData2,
          parkingData3: parkData3, curUser: username),
    ));

    expect(find.text('No image selected.'), findsOneWidget);
  });

  testWidgets('Find Parking Form Buttons', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParkingSubmit(parkingData: parkData1, parkingData2: parkData2,
          parkingData3: parkData3, curUser: username),
    ));

    // Finds 2 IconButton Widgets (ParkCore logo, and menu icons)
    expect(find.byType(IconButton),findsNWidgets(2));
  });

  testWidgets('Find One Menu Icon Button (Add Parking)', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParkingSubmit(parkingData: parkData1, parkingData2: parkData2,
          parkingData3: parkData3, curUser: username),
    ));

    // Find 1 Menu Icon Button
    expect(find.widgetWithIcon(IconButton, Icons.menu),findsOneWidget);
  });

  testWidgets('Find RaisedButtons for Restart, Next, Camera Image & Gallery Image',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParkingSubmit(parkingData: parkData1, parkingData2: parkData2,
          parkingData3: parkData3, curUser: username),
    ));

    expect(find.byType(RaisedButton),findsNWidgets(4));
  });

  testWidgets('Find One Icon Button (camera)', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParkingSubmit(parkingData: parkData1, parkingData2: parkData2,
          parkingData3: parkData3, curUser: username),
    ));

    // Find 1 photo_camera Icon Button
    expect(find.widgetWithIcon(RaisedButton, Icons.photo_camera),findsOneWidget);
  });

  testWidgets('Find One Icon Button (gallery)', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParkingSubmit(parkingData: parkData1, parkingData2: parkData2,
          parkingData3: parkData3, curUser: username),
    ));

    // Find 1 photo_library Icon Button
    expect(find.widgetWithIcon(RaisedButton, Icons.photo_library),findsOneWidget);
  });

  testWidgets('Find Parking Form page 5 restart button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParkingSubmit(parkingData: parkData1, parkingData2: parkData2,
          parkingData3: parkData3, curUser: username),
    ));

    expect(find.widgetWithText(RaisedButton, 'Restart Form'), findsOneWidget);
  });

  testWidgets('Find Parking Form page 5 submit button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParkingSubmit(parkingData: parkData1, parkingData2: parkData2,
          parkingData3: parkData3, curUser: username),
    ));

    expect(find.widgetWithText(RaisedButton, 'Submit'), findsOneWidget);
  });

  testWidgets('Test go to success page from page 5', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final routes = <String, WidgetBuilder>{
      '/form_success': (context) => FormSuccess(),
    };

    await tester.pumpWidget(MaterialApp(
      home: AddParkingSubmit(parkingData: parkData1, parkingData2: parkData2,
          parkingData3: parkData3, curUser: username),
      initialRoute: '/',
      routes: routes,
    ));

    final submit = find.widgetWithText(RaisedButton, 'Submit');
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('Form Submitted. Success!'), findsOneWidget);
  });

  testWidgets('Test button to restart form', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final routes = <String, WidgetBuilder>{
      '/add_parking1': (context) => AddParking1(title: 'Post Your Parking Space'),
    };

    await tester.pumpWidget(MaterialApp(
      home: AddParkingSubmit(parkingData: parkData1, parkingData2: parkData2,
          parkingData3: parkData3, curUser: username),
      initialRoute: '/',
      routes: routes,
    ));

    final submit = find.widgetWithText(RaisedButton, 'Restart Form');
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('Part 1 of 5'), findsOneWidget);
  });
}