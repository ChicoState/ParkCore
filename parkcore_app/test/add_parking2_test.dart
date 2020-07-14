import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/parking/pform/add_parking1.dart';
import 'package:parkcore_app/parking/pform/add_parking2.dart';
import 'package:parkcore_app/parking/pform/pform_helpers.dart';
import 'package:parkcore_app/models/ParkingData2.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

void main() {

  test('ParkingData2 size is null', () {
    // parkingData2 params: size, type, driveway, spaceType, amenities, details
    final parkingData = ParkingData2(null, null, '', '', null, '');
    final parkingJson = parkingData.toJson();
    expect(parkingJson['size'], null);
  });

  test('ParkingData2 Size set as Compact', () {
    // parkingData2 params: size, type, driveway, spaceType, amenities, details
    final parkingData = ParkingData2(null, null, '', '', null, '');
    parkingData.size = 'Compact';
    final parkingJson = parkingData.toJson();
    expect(parkingJson['size'], 'Compact');
  });

  test('ParkingData2 Type set as Driveway', () {
    // parkingData2 params: size, type, driveway, spaceType, amenities, details
    final parkingData = ParkingData2(null, null, '', '', null, '');
    parkingData.type = 'Driveway';
    final parkingJson = parkingData.toJson();
    expect(parkingJson['type'], 'Driveway');
  });

  test('ParkingData2 Driveway set as Left', () {
    final parkingData = ParkingData2(null, null, '', '', null, '');
    parkingData.driveway = 'Left';
    final parkingJson = parkingData.toJson();
    expect(parkingJson['driveway'], 'Left');
  });

  test('ParkingData2 Type -- Space Type set as Parallel', () {
    final parkingData = ParkingData2(null, null, '', '', null, '');
    parkingData.spaceType = 'Parallel';
    final parkingJson = parkingData.toJson();
    expect(parkingJson['spacetype'], 'Parallel');
  });

  test('ParkingData2 Amenities all selected', () {
    final parkingData = ParkingData2(null, null, '', '', null, '');
    parkingData.myAmenities = ['Lit', 'Covered', 'Security Camera', 'EV Charging'];
    final parkingJson = parkingData.toJson();
    expect(parkingJson['amenities'], '[Lit, Covered, Security Camera, EV Charging]');
  });

  test('ParkingData2 Details set', () {
    final parkingData = ParkingData2(null, null, '', '', null, '');
    parkingData.details = 'down an alley';
    final parkingJson = parkingData.toJson();
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

  testWidgets('Find Parking Form page 2 restart button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    expect(find.widgetWithText(RaisedButton, 'Restart Form'), findsOneWidget);
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
    final container = tester.widget(find.byKey(Key('sizeField'))) as Container;
    final decoration = container.decoration as BoxDecoration;
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
    final container = tester.widget(find.byKey(Key('typeField'))) as Container;
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, Colors.red[50]);
  });

  testWidgets('test enter details text only, get error', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));
    final detailstext = find.byKey(Key('details'));

    // Test form search field input
    await tester.enterText(detailstext, 'near Acker Gym');
    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Next: Price & Availability');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('Make sure to fill out all required fields'), findsOneWidget);
  });

  testWidgets('test enter details text only, value not null', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));
    final detailstext = find.byKey(Key('details'));

    // Test form search field input
    await tester.enterText(detailstext, 'near Acker Gym');
    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Next: Price & Availability');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.widgetWithText(TextFormField, 'near Acker Gym'), findsOneWidget);
  });

  testWidgets('test form error incomplete is false', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));
    var parkingData = ParkingData2(null, null, '', '', null, '');
    var formError = FormError();
    final detailstext = find.byKey(Key('details'));

    // Test form search field input
    parkingData.size = 'Compact';
    parkingData.type = 'Parking Lot';
    await tester.enterText(detailstext, 'near Acker Gym');
    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Next: Price & Availability');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(formError.incomplete, isFalse);
  });

  testWidgets('expect restart button to go to page 1 of form', (
      WidgetTester tester) async {

    final routes = <String, WidgetBuilder>{
      '/add_parking1': (context) => AddParking1(title: 'Post Your Parking Space'),
    };

    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
      initialRoute: '/',
      routes: routes,
    ));

    final buttonFinder = find.byKey(Key('restartbutton'));
    await tester.tap(buttonFinder);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));

    final textFinder = find.text('Post Your Parking Space');
    expect(textFinder, findsOneWidget);
  });

  testWidgets('find error message after only choosing Driveway as Type', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));
    var parkingData2 = ParkingData2(null, '', '', '', null, '');
    parkingData2.type = 'Driveway';

    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Next: Price & Availability');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('Make sure to fill out all required fields'), findsOneWidget);
  });

  testWidgets('find Regular and Driveway field input for size & type', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));
    var parkingData2 = ParkingData2('', '', '', '', null, '');
    parkingData2.size = 'Regular';
    parkingData2.type = 'Driveway';

    expect(find.widgetWithText(DropDownFormField, 'Regular'), findsOneWidget);
    expect(find.widgetWithText(DropDownFormField, 'Driveway'), findsOneWidget);
  });

  testWidgets('enter value for spaceType', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));
    var parkingData2 = ParkingData2(null, '', '', '', null, '');
    parkingData2.type = 'Parking Lot';
    parkingData2.spaceType = 'Perpendicular';

    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Next: Price & Availability');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('Perpendicular'), findsOneWidget);
  });

  testWidgets('enter value for Amenities', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));
    var parkingData2 = ParkingData2(null, '', '', '', null, '');
    parkingData2.myAmenities = ['Lit'];

    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Next: Price & Availability');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('Make sure to fill out all required fields'), findsOneWidget);
  });

  testWidgets('check Size field onchanged', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    final txt = '* Parking Space Size';
    // // Verify the output in field onChanged.
    final sizefield = tester.widget(find.widgetWithText(DropDownFormField, txt)) as DropDownFormField;
    sizefield.onChanged('Compact');
    sizefield.onChanged('');
    expect(sizefield.value, isNull);
  });

  testWidgets('check Type field onchanged', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    final txt = '* Type of Parking Space';
    // // Verify the output in field onChanged.
    final typefield = tester.widget(find.widgetWithText(DropDownFormField, txt)) as DropDownFormField;
    typefield.onChanged('Driveway');
    typefield.onChanged('');
    expect(typefield.value, isNull);
  });

  testWidgets('check space type field onchanged', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    final txt = 'Additional Parking Space Info';
    // // Verify the output in field onChanged.
    final spacetypefield = tester.widget(find.widgetWithText(DropDownFormField, txt)) as DropDownFormField;
    spacetypefield.onChanged('Parallel');
    spacetypefield.onChanged('');
    expect(spacetypefield.value, isEmpty);
  });

  testWidgets('check space type field onsaved', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    final txt = 'Additional Parking Space Info';
    // // Verify the output in field onChanged.
    final spacetypefield = tester.widget(find.widgetWithText(DropDownFormField, txt)) as DropDownFormField;
    spacetypefield.onSaved('Parallel');
    spacetypefield.onSaved('');
    expect(spacetypefield.value, isEmpty);
  });

  testWidgets('check amenities field onsaved', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));

    final txt = 'Parking Spot Amenities';
    // // Verify the output in field onChanged.
    final amenityfield = tester.widget(find.widgetWithText(MultiSelectFormField, txt)) as MultiSelectFormField;
    amenityfield.onSaved(['Lit']);
    amenityfield.onSaved(['']);
    expect(amenityfield.initialValue, isNull);
  });

  testWidgets('set required fields', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking2(parkingData: null, curUser: null),
    ));
    var parkingData2 = ParkingData2(null, '', '', '', null, '');
    parkingData2.size = 'Compact';
    parkingData2.type = 'Driveway';

    // Create the finders
    final submit = find.widgetWithText(RaisedButton, 'Next: Price & Availability');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    final titleFinder = find.text('Post Your Parking Space');
    expect(titleFinder, findsOneWidget);
  });

    // Can't test selecting options from dropdown, so since those fields are
    // required, we can't test navigation to next page
//  testWidgets('Test go to page 3 from page 2', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//
//    final routes = <String, WidgetBuilder>{
//      '/add_parking3': (context) => AddParking3(parkingData: null, parkingData2: null, curUser: null),
//    };
//
//    await tester.pumpWidget(MaterialApp(
//      home: AddParking2(parkingData: null, curUser: null),
//      initialRoute: '/',
//      routes: routes,
//    ));
//
//    ParkingData2 parkingData = ParkingData2(null, null, '', '', null, '');
//    final detailstext = find.byKey(Key('details'));
//
//    // Test form search field input
//    parkingData.size = 'Compact';
//    parkingData.type = 'Parking Lot';
//    await tester.enterText(detailstext, 'near Acker Gym');
//    // Create the finders
//    final submit = find.widgetWithText(RaisedButton, 'Next: Price & Availability');
//    await tester.tap(submit);
//    await tester.pump();
//    await tester.pump(const Duration(milliseconds: 10));
//    expect(find.text('Part 3 of 5'), findsOneWidget);
//  });

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
//    expect(find.byKey(Key('drivewayField')), findsOneWidget);
//  });
}