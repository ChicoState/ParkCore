import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/parking/pform/add_parking3.dart';
import 'package:parkcore_app/parking/pform/add_parking1.dart';
import 'package:parkcore_app/parking/pform/add_parking_review.dart';
import 'package:parkcore_app/models/ParkingData.dart';
import 'package:parkcore_app/models/ParkingData2.dart';
import 'package:parkcore_app/models/ParkingData3.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

void main() {

  testWidgets('Check if parking space price is empty', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(),
    ));

    expect(AddParking3().createState().validatePrice('0.00'), 'Value must be greater than \$0.00');
  });

  test('ParkingData3 Days Available get and set', () {
    // parkingData3 params: days, start time, end time, price
    final parkingData = ParkingData3(null, '', '', '');
    parkingData.myDays = ['MON', 'TUE', 'WED', 'THU', 'FRI'];
    final parkingJson = parkingData.toJson();
    expect(parkingJson['days'], '[MON, TUE, WED, THU, FRI]');
  });

  test('ParkingData3 Start Time get and set', () {
    final parkingData = ParkingData3(null, '', '', '');
    parkingData.startTime = '09:00';
    final parkingJson = parkingData.toJson();
    expect(parkingJson['starttime'], '09:00');
  });

  test('ParkingData3 End Time get and set', () {
    final parkingData = ParkingData3(null, '', '', '');
    parkingData.endTime = '20:00';
    final parkingJson = parkingData.toJson();
    expect(parkingJson['endtime'], '20:00');
  });

  test('Parking Space Price getter and setter', () {
    final parkingData = ParkingData3(null, '', '', '');
    parkingData.price = '42.00';
    final parkingJson = parkingData.toJson();
    expect(parkingJson['monthprice'], '42.00');
  });

  testWidgets('Find Add Parking Form Page 3', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    // expect to find 1 form
    expect(find.byType(Form),findsOneWidget);
  });

  testWidgets('Find Add Parking Form Title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    // Find title
    final titleFinder = find.text('Post Your Parking Space');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Find Parking Form page 3 text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    expect(find.text('Part 3 of 5'), findsOneWidget);
  });

  testWidgets('Find Parking Form Buttons', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    // Finds 2 IconButton Widgets (ParkCore logo, and menu icons)
    expect(find.byType(IconButton),findsNWidgets(2));
  });

  testWidgets('Find One Menu Icon Button (Add Parking)', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    // Find 1 Menu Icon Button
    expect(find.widgetWithIcon(IconButton, Icons.menu),findsOneWidget);
  });

  testWidgets('Find Parking Form RaisedButtons for Restart and Next',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    expect(find.byType(RaisedButton),findsNWidgets(2));
  });

  testWidgets('Find Parking Form page 3 restart button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    expect(find.widgetWithText(RaisedButton, 'Restart Form'), findsOneWidget);
  });

  testWidgets('Find Parking Form page 3 submit button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    expect(find.widgetWithText(RaisedButton, 'Review'), findsOneWidget);
  });

  testWidgets('Find Parking Form MultiSelect Field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    expect(find.byType(MultiSelectFormField),findsOneWidget);
  });

  testWidgets('Find 2 Parking Form DateTime Fields', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    expect(find.byType(DateTimeField),findsNWidgets(2));
  });

  testWidgets('Find Parking Form Price Text Field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    expect(find.byType(TextFormField),findsOneWidget);
  });

  testWidgets('Find Parking Form MultiSelect for Days', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    expect(find.widgetWithText(MultiSelectFormField, 'Days Available'),findsOneWidget);
  });

  testWidgets('Find Parking Form DateTime for Start', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    final txt = 'Parking Space Available Starting at:';
    expect(find.widgetWithText(DateTimeField, txt),findsOneWidget);
  });

  testWidgets('Set Start Time', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));
    final type = 'start';
    final time = TimeOfDay.now();
    final start = AddParking3().createState().getTime(type);
    await AddParking3().createState().setTime(type, time);
    await tester.pump();
    expect(start, isNotNull);
  });

  testWidgets('Set End Time', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));
    final type = 'end';
    final time = TimeOfDay.now();
    final end = AddParking3().createState().getTime(type);
    await AddParking3().createState().setTime(type, time);
    await tester.pump();
    expect(end, isNotNull);
  });

  testWidgets('Find Parking Form DateTime for End', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    final txt = 'Parking Space Available Until:';
    expect(find.widgetWithText(DateTimeField, txt),findsOneWidget);
  });

  testWidgets('Find Parking Form TextField for Price', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    final txt = '* Price per month (\$):';
    expect(find.widgetWithText(TextFormField, txt),findsOneWidget);
  });

  testWidgets('Price for parking space not entered', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Review');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();

    expect(find.text('Value must be greater than \$0.00'), findsOneWidget);
  });

  testWidgets('Required field for parking space not entered', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    // Create the finders
    final price = find.byKey(Key('price'));
    final txt = '0.00';
    await tester.enterText(price, txt);
    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Review');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();

    expect(find.text('Make sure to fill out all required fields'), findsOneWidget);
  });

  testWidgets('Form error message, price not entered', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: null, parkingData2: null, curUser: null),
    ));

    // Create the finders
    final price = find.byKey(Key('price'));
    final txt = '0.00';
    await tester.enterText(price, txt);
    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Review');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('Make sure to fill out all required fields'), findsOneWidget);
  });

  testWidgets('Test go to page 4 from page 3', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final parkData1 = ParkingData('MyTitle', '123 Main St', 'Chico', 'CA',
        '95929', 'randomuid', '{39.7285,-121.8375}', '{39.7285,-121.8375}');
    final parkData2 = ParkingData2('Compact', 'Parking Lot', 'N/A', 'Angled',
        ['Lit', 'Covered', 'Security Camera', 'EV Charging'], 'AdditionalDetails');
    final parkData3 = ParkingData3(['MON','WED','FRI'], '08:00', '16:00', '');
    final username = 'Grace Hopper';

    final routes = <String, WidgetBuilder>{
      '/add_parking_review': (context) => AddParkingReview(
        parkingData: parkData1, parkingData2: parkData2,
        parkingData3: parkData3, curUser: username,
      ),
    };

    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: parkData1, parkingData2: parkData2, curUser: username),
      initialRoute: '/',
      routes: routes,
    ));

    final pricetext = find.byKey(Key('price'));

    // Test form price field input
    await tester.enterText(pricetext, '42.00');
    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Review');
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('Part 4 of 5'), findsOneWidget);
  });

  testWidgets('Test button to restart form', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final parkData1 = ParkingData('MyTitle', '123 Main St', 'Chico', 'CA',
        '95929', 'randomuid', '{39.7285,-121.8375}', '{39.7285,-121.8375}');
    final parkData2 = ParkingData2('Compact', 'Parking Lot', 'N/A', 'Angled',
        ['Lit', 'Covered', 'Security Camera', 'EV Charging'], 'AdditionalDetails');
    final username = 'Grace Hopper';

    final routes = <String, WidgetBuilder>{
      '/add_parking1': (context) => AddParking1(title: 'Post Your Parking Space'),
    };

    await tester.pumpWidget(MaterialApp(
      home: AddParking3(parkingData: parkData1, parkingData2: parkData2,
          curUser: username),
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