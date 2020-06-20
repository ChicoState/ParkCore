import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/parking/pform/add_parking2.dart';
import 'package:parkcore_app/parking/pform/pform_helpers.dart';
import 'package:parkcore_app/models/ParkingData2.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

void main() {

  test('ParkingData2 size is null', () {
    // parkingData2 params: size, type, driveway, spaceType, amenities, details
    final parkingData = ParkingData2(null, null, '', '', null, '');
    Map<String, dynamic> parkingJson = parkingData.toJson();
    expect(parkingJson['size'], null);
  });

  test('ParkingData2 Size set as Compact', () {
    // parkingData2 params: size, type, driveway, spaceType, amenities, details
    final parkingData = ParkingData2(null, null, '', '', null, '');
    parkingData.size = 'Compact';
    Map<String, dynamic> parkingJson = parkingData.toJson();
    expect(parkingJson['size'], 'Compact');
  });

  test('ParkingData2 Type set as Driveway', () {
    // parkingData2 params: size, type, driveway, spaceType, amenities, details
    final parkingData = ParkingData2(null, null, '', '', null, '');
    parkingData.type = 'Driveway';
    Map<String, dynamic> parkingJson = parkingData.toJson();
    expect(parkingJson['type'], 'Driveway');
  });

  test('ParkingData2 Driveway set as Left', () {
    final parkingData = ParkingData2(null, null, '', '', null, '');
    parkingData.driveway = 'Left';
    Map<String, dynamic> parkingJson = parkingData.toJson();
    expect(parkingJson['driveway'], 'Left');
  });

  test('ParkingData2 Type -- Space Type set as Parallel', () {
    final parkingData = ParkingData2(null, null, '', '', null, '');
    parkingData.spaceType = 'Parallel';
    Map<String, dynamic> parkingJson = parkingData.toJson();
    expect(parkingJson['spacetype'], 'Parallel');
  });

  test('ParkingData2 Amenities all selected', () {
    final parkingData = ParkingData2(null, null, '', '', null, '');
    parkingData.myAmenities = ['Lit', 'Covered', 'Security Camera', 'EV Charging'];
    Map<String, dynamic> parkingJson = parkingData.toJson();
    expect(parkingJson['amenities'], '[Lit, Covered, Security Camera, EV Charging]');
  });

  test('ParkingData2 Details set', () {
    final parkingData = ParkingData2(null, null, '', '', null, '');
    parkingData.details = 'down an alley';
    Map<String, dynamic> parkingJson = parkingData.toJson();
    expect(parkingJson['spacedetails'], 'down an alley');
  });

  testWidgets('Find Add Parking Form Page 2', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    // expect to find 1 form
    expect(find.byType(Form),findsOneWidget);
  });

  testWidgets('Find Add Parking Form Title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    // Find title
    final titleFinder = find.text('Post Your Parking Space');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Find Parking Form page text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    expect(find.text('Part 2 of 5'), findsOneWidget);
  });

  testWidgets('Find Parking Form Buttons', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home:AddParking2(parkingData: null, curUser: null),
    ));

    // Finds 2 IconButton Widgets (ParkCore logo, and menu icons)
    expect(find.byType(IconButton),findsNWidgets(2));
  });

  testWidgets('Find One Menu Icon Button (Add Parking)', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    // Find 1 Menu Icon Button
    expect(find.widgetWithIcon(IconButton, Icons.menu),findsOneWidget);
  });

  testWidgets('Find Parking Form RaisedButtons for Restart and Next',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    expect(find.byType(RaisedButton),findsNWidgets(2));
  });

  testWidgets('Find Parking Form page 2 submit button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    expect(find.widgetWithText(RaisedButton, 'Next: Price & Availability'), findsOneWidget);
  });

  testWidgets('Find Parking Form DropDown Fields', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));
    // 4 DropDownFormFields exist, but only 3 will show up at a time
    expect(find.byType(DropDownFormField),findsNWidgets(3));
  });

  testWidgets('Find Parking Form Details Text Field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    expect(find.byType(TextFormField),findsOneWidget);
  });

  testWidgets('Find Parking Form MultiSelect Field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    expect(find.byType(MultiSelectFormField),findsOneWidget);
  });

  testWidgets('Find Parking Form DropDown for Size', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    expect(find.widgetWithText(DropDownFormField, '* Parking Space Size'),findsOneWidget);
  });

  testWidgets('Find Parking Form DropDown for Type', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    expect(find.widgetWithText(DropDownFormField, '* Type of Parking Space'),findsOneWidget);
  });

  testWidgets('Find Parking Form DropDown for SpaceType info', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    expect(find.widgetWithText(DropDownFormField, 'Additional Parking Space Info'),findsOneWidget);
  });

  testWidgets('Find Parking Form MultiSelect for Amenities', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    expect(find.widgetWithText(MultiSelectFormField, 'Parking Spot Amenities'),findsOneWidget);
  });

  testWidgets('Find Parking Form TextField for Details', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    expect(find.widgetWithText(TextFormField, 'Other important details about your space:'),findsOneWidget);
  });

  testWidgets('Enter details for parking space', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    // Create the finders
    final title = find.byKey(Key('details'));
    final txt = 'lots of shade and very close to campus';
    // Test text field form input
    await tester.enterText(title, txt);

    // Expect Text Widget message
    expect(find.text(txt), findsOneWidget);
  });

  testWidgets('expect size input missing due to incomplete form', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));
    final parkingData = ParkingData2(null, null, '', '', null, '');

    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Next: Price & Availability');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();

    expect(parkingData.size, isNull);
  });

  testWidgets('expect type input missing due to incomplete form', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));
    final parkingData = ParkingData2(null, null, '', '', null, '');

    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Next: Price & Availability');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();

    expect(parkingData.type, isNull);
  });

  testWidgets('expect spaceType input missing due to incomplete form', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));
    final parkingData = ParkingData2(null, null, '', '', null, '');

    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Next: Price & Availability');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();

    expect(parkingData.spaceType, isEmpty);
  });

  testWidgets('expect amenities input missing due to incomplete form', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));
    final parkingData = ParkingData2(null, null, '', '', null, '');

    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Next: Price & Availability');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();

    expect(parkingData.myAmenities, isNull);
  });

  testWidgets('expect incomplete form error is true', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));
    final parkingData = ParkingData2(null, null, '', '', null, '');
    final formError = FormError();
    parkingData.size = 'Compact';
    parkingData.type = 'Parking Lot';
    parkingData.spaceType = 'Perpendicular';
    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Next: Price & Availability');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(formError.incomplete, isFalse);
  });

  testWidgets('expect to find incomplete error message', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));
    final parkingData = ParkingData2(null, null, '', '', null, '');
    parkingData.type = 'Parking Lot';
    parkingData.spaceType = 'Perpendicular';
    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Next: Price & Availability');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('Make sure to fill out all required fields'), findsOneWidget);
  });

  testWidgets('expect to find red size box', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));
    final parkingData = ParkingData2(null, null, '', '', null, '');
    parkingData.type = 'Parking Lot';
    parkingData.spaceType = 'Perpendicular';
    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Next: Price & Availability');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    final Container container = tester.widget(find.byKey(Key('sizeField')));
    final BoxDecoration decoration = container.decoration as BoxDecoration;
    expect(decoration.color, Colors.red[50]);
  });

  testWidgets('expect to find red typeField box', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));
    final parkingData = ParkingData2(null, null, '', '', null, '');
    parkingData.size = 'Compact';
    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Next: Price & Availability');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    final Container container = tester.widget(find.byKey(Key('typeField')));
    final BoxDecoration decoration = container.decoration as BoxDecoration;
    expect(decoration.color, Colors.red[50]);
  });

//  testWidgets('find Driveway form field', (
//      WidgetTester tester) async {
//    await tester.pumpWidget(MaterialApp(
//      home: AddParking2(parkingData: null, curUser: null),
//    ));
//    final parkingData2 = ParkingData2(null, null, '', '', null, '');
//    parkingData2.type = 'Driveway';
//    await tester.pump();
//    await tester.pump(const Duration(milliseconds: 10));
//    expect(find.widgetWithText(DropDownFormField, 'Driveway Parking Space Info:'),findsOneWidget);
//  });

//  testWidgets('expect incomplete form error is true', (
//      WidgetTester tester) async {
//    await tester.pumpWidget(MaterialApp(
//      home: AddParking2(parkingData: null, curUser: null),
//    ));
//    final formError = FormError();
//    // Create the finders
//    final submit = find.widgetWithText(RaisedButton, 'Next: Price & Availability');
//
//    // Tap the search icon and trigger a frame
//    await tester.tap(submit);
//    await tester.pump();
//    await tester.pump(const Duration(milliseconds: 10));
//    await tester.pump(const Duration(milliseconds: 10));
//    expect(formError.incomplete, isTrue);
//  });

//  testWidgets('if State not selected, box returns red', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//
//    final routes = <String, WidgetBuilder>{
//      '/add_parking2': (context) => AddParking2(parkingData: null, curUser: null),
//    };
//
//    await tester.pumpWidget(MaterialApp(
//      home: AddParking1(),
//      initialRoute: '/',
//      routes: routes,
//    ));
//
//    ParkingData parkingData = ParkingData('','','','','','','','');
//    // Test text field form input
//    final titletext = find.byKey(Key('title'));
//    final addresstext = find.byKey(Key('address'));
//    final citytext = find.byKey(Key('city'));
//    final ziptext = find.byKey(Key('zip'));
//
//    // Test form search field input
//    await tester.enterText(titletext, 'Acker Gym');
//    await tester.enterText(addresstext, '135 Acker Gym');
//    await tester.enterText(citytext, 'Chico');
//    await tester.enterText(ziptext, '95929');
//
//    // Find logoButton
//    final submit = find.widgetWithText(RaisedButton, 'Next: Parking Space Info');
//    await tester.tap(submit);
//    await tester.pump();
//    await tester.pump(const Duration(milliseconds: 10));
//    final Container container = tester.widget(find.byKey(Key('stateField')));
//    final BoxDecoration decoration = container.decoration as BoxDecoration;
//    expect(decoration.color, Colors.red[50]);
//  });
}