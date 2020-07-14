// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/parking/pform/add_parking1.dart';
import 'package:parkcore_app/parking/pform/pform_helpers.dart';
import 'package:parkcore_app/models/CurrentUser.dart';
import 'package:parkcore_app/models/ParkingData.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:parkcore_app/parking/random_coordinates.dart';

void main() {
  testWidgets('Find Add Parking Form Page 1', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    // expect to find 1 form
    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('Find Add Parking Form Title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    // Find title
    final titleFinder = find.text('Post Your Parking Space');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Find Parking Form page text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(find.text('Part 1 of 5'), findsOneWidget);
  });

  testWidgets('Find Parking Form Buttons', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    // Finds 2 IconButton Widgets (ParkCore logo, and menu icons)
    expect(find.byType(IconButton), findsNWidgets(2));
  });

  testWidgets('Find One Menu Icon Button (Add Parking)',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    // Find 1 Menu Icon Button
    expect(find.widgetWithIcon(IconButton, Icons.menu), findsOneWidget);
  });

  testWidgets('Find Parking Form RaisedButton Field',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(find.byType(RaisedButton), findsOneWidget);
  });

  testWidgets('Find Parking Form page 1 submit button',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(find.widgetWithText(RaisedButton, 'Next: Parking Space Info'),
        findsOneWidget);
  });

  testWidgets('Find Parking Form Text Fields', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(find.byType(TextFormField), findsNWidgets(4));
  });

  testWidgets('Find Parking Form DropDown Field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(find.byType(DropDownFormField), findsOneWidget);
  });

  testWidgets('Find Parking Form DropDown for State',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(find.widgetWithText(DropDownFormField, '* State:'), findsOneWidget);
  });

  testWidgets('Enter title for parking space', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    // Create the finders
    final title = find.byKey(Key('title'));

    // Test text field form input
    await tester.enterText(title, 'Parking Space Title');

    // Expect Text Widget message
    expect(find.text('Parking Space Title'), findsOneWidget);
  });

  testWidgets('Validate title for parking space', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(AddParking1().createState().validateTitle('Parking Space Title'),
        isNull);
  });

  testWidgets('Check parking space title is empty',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(
        AddParking1().createState().validateTitle(''), 'Field can\'t be empty');
  });

  testWidgets('Check parking space title length', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    var longstr = 'too long parkin spot title'; //26 chars

    expect(AddParking1().createState().validateTitle(longstr),
        'Title cannot be more than 25 characters');
  });

  testWidgets('Enter address for parking space', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    // Create the finders
    final address = find.byKey(Key('address'));

    // Test text field form input
    await tester.enterText(address, 'My Address');

    // Expect Text Widget message
    expect(find.text('My Address'), findsOneWidget);
  });

  testWidgets('Validate address for parking space',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(AddParking1().createState().validateAddress('My Address'), isNull);
  });

  testWidgets('Check address for parking space is empty',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(AddParking1().createState().validateAddress(''),
        'Field can\'t be empty');
  });

  testWidgets('Validate address length', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    var longstr =
        'abcdefghijklmnopqrstuvwxyz1234abcdefghijklmnopqrstuvwxyz12345';

    expect(AddParking1().createState().validateAddress(longstr),
        'Address cannot be more than 60 characters');
  });

  testWidgets('Enter city for parking space', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    // Create the finders
    final city = find.byKey(Key('city'));

    // Test text field form input
    await tester.enterText(city, 'Chico');

    // Expect Text Widget message
    expect(find.text('Chico'), findsOneWidget);
  });

  testWidgets('Validate city for parking space', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(AddParking1().createState().validateCity('Chico'), isNull);
  });

  testWidgets('Check city for parking space is empty',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(
        AddParking1().createState().validateCity(''), 'Field can\'t be empty');
  });

  testWidgets('Enter zip for parking space', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    // Create the finders
    final zip = find.byKey(Key('zip'));

    // Test text field form input
    await tester.enterText(zip, '95928');

    // Expect Text Widget message
    expect(find.text('95928'), findsOneWidget);
  });

  testWidgets('Validate zip for parking space', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(AddParking1().createState().validateZip('95928'), isNull);
  });

  testWidgets('Check zip for parking space is empty',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(
        AddParking1().createState().validateZip(''), 'Field can\'t be empty');
  });

  testWidgets('Check zip for parking space too short',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(AddParking1().createState().validateZip('1234'),
        'Enter your 5 digit zip code');
  });

  testWidgets('Check zip for parking space too long',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(AddParking1().createState().validateZip('123456'),
        'Enter your 5 digit zip code');
  });

  testWidgets('Check if zip has spaces', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(AddParking1().createState().validateZip('12 45'),
        'Field can\'t contain spaces');
  });

  testWidgets('Check if zip has non-numeric', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(AddParking1().createState().validateZip('12a45'),
        'Enter a valid 5 digit US zip code');
  });

  testWidgets('Check if zip has special', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    expect(AddParking1().createState().validateZip('12-45'),
        'Enter a valid 5 digit US zip code');
  });

  testWidgets('Check no username', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));
    final curUser = CurrentUser(null, '', '');
    expect(curUser.getUserName(), 'no current user');
  });

  testWidgets('Check no user id', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));
    final curUser = CurrentUser(null, '', '');
    expect(curUser.getUserID(), 'no current user');
  });

  testWidgets('Check user loaded (null)', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));
    final curUser = CurrentUser(null, '', '');

    AddParking1().createState().loadCurrentUser();
    expect(curUser.currentUser, null);
  });

  testWidgets('Check CurrentUser toJson()', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));
    final curUser = CurrentUser(null,'','');

    AddParking1().createState().loadCurrentUser();
    final curUserJson = curUser.toJson();
    expect(curUserJson['currentUser'], null);
  });

  test('Incomplete Form getter and setter', () {
    final formError = FormError();
    formError.incomplete = true;
    expect(formError.incomplete, isTrue);
  });

  test('Complete Form (incomplete == false) getter and setter', () {
    final formError = FormError();
    formError.incomplete = false;
    expect(formError.incomplete, isFalse);
  });

  test('Invalid Location - Form getter and setter', () {
    final formError = FormError();
    formError.invalidLoc = true;
    expect(formError.invalidLoc, isTrue);
  });

  test('Valid Location (invalid == false) Form getter and setter', () {
    final formError = FormError();
    formError.invalidLoc = false;
    expect(formError.invalidLoc, isFalse);
  });

  test('Form Error message getter and setter', () {
    final formError = FormError();
    formError.errorMessage =
        'We can\'t find you!\nPlease enter a valid location.';
    expect(formError.errorMessage,
        'We can\'t find you!\nPlease enter a valid location.');
  });

  test('Parking Space Title Json', () {
    // title, address, city, state, zip, uid, coordinates, random coordinates
    final parkingData =
        ParkingData('My Parking Space', '', '', '', '', '', '', '');
    final parkingJson = parkingData.toJson();
    expect(parkingJson['title'], 'My Parking Space');
  });

  test('Parking Space Address Json', () {
    // title, address, city, state, zip, uid, coordinates, random coordinates
    final parkingData = ParkingData('', '123 Main St', '', '', '', '', '', '');
    final parkingJson = parkingData.toJson();
    expect(parkingJson['address'], '123 Main St');
  });

  test('Parking Space City Json', () {
    // title, address, city, state, zip, uid, coordinates, random coordinates
    final parkingData = ParkingData('', '', 'Chico', '', '', '', '', '');
    parkingData.city_format = parkingData.city;
    final parkingJson = parkingData.toJson();
    expect(parkingJson['city'], 'Chico');
  });

  test('Parking Space State Json', () {
    // title, address, city, state, zip, uid, coordinates, random coordinates
    final parkingData = ParkingData('', '', '', 'CA', '', '', '', '');
    final parkingJson = parkingData.toJson();
    expect(parkingJson['state'], 'CA');
  });

  test('Parking Space Zip Json', () {
    // title, address, city, state, zip, uid, coordinates, random coordinates
    final parkingData = ParkingData('', '', '', '', '95928', '', '', '');
    final parkingJson = parkingData.toJson();
    expect(parkingJson['zip'], '95928');
  });

  test('ParkingData Coordinates get and set', () {
    final parkingData = ParkingData('', '', '', '', '', '', '', '');
    parkingData.coordinates = '{39.7285,-121.8375}';
    final parkingJson = parkingData.toJson();
    expect(parkingJson['coordinates'], '{39.7285,-121.8375}');
  });

  test('ParkingData Random Coordinates Latitude get and set', () {
    final parkingData = ParkingData('', '', '', '', '', '', '', '');
    parkingData.coordinates = '{39.7285,-121.8375}';
    parkingData.coord_rand = getRandomCoordinates(parkingData.coordinates);
    final parkingJson = parkingData.toJson();
    expect(parkingJson['coordinates_r'].contains('39'), isTrue);
  });

  test('Parking Space Random Coordinates Longitude getter and setter', () {
    final parkingData = ParkingData('', '', '', '', '', '', '', '');
    parkingData.coordinates = '{39.7285,-121.8375}';
    parkingData.coord_rand = getRandomCoordinates(parkingData.coordinates);
    final parkingJson = parkingData.toJson();
    expect(parkingJson['coordinates_r'].contains('-121'), isTrue);
  });

  testWidgets('expect state input missing due to incomplete form',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));
    final parkingData = ParkingData('', '', '', '', '', '', '', '');

    // Create the finders
    final submit =
        find.widgetWithText(RaisedButton, 'Next: Parking Space Info');

    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();

    expect(parkingData.state.isEmpty, isTrue);
  });

  testWidgets('expect form page 1 complete (incomplete == false)',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    final parkingData = ParkingData('', '', '', '', '', '', '', '');
    final formError = FormError();
    // Create the finders

    // Find text fields for form input
    final titletext = find.byKey(Key('title'));
    final addresstext = find.byKey(Key('address'));
    final citytext = find.byKey(Key('city'));
    final ziptext = find.byKey(Key('zip'));

    // Test form text field input
    await tester.enterText(titletext, 'MySpace Title');
    await tester.enterText(addresstext, '123 Main St');
    await tester.enterText(citytext, 'Chico');
    parkingData.state = 'CA';
    await tester.enterText(ziptext, '95928');

    // Tap the 'next' button to submit form page 1 and trigger a frame
    final submit =
        find.widgetWithText(RaisedButton, 'Next: Parking Space Info');
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));

    expect(formError.incomplete, isFalse);
  });

  testWidgets('expect validateAndSave() returns true',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    final parkingData = ParkingData('', '', '', '', '', '', '', '');
    // Create the finders

    // Test text field form input
    final titletext = find.byKey(Key('title'));
    final addresstext = find.byKey(Key('address'));
    final citytext = find.byKey(Key('city'));
    final ziptext = find.byKey(Key('zip'));

    // Test form search field input
    await tester.enterText(titletext, 'Acker Gym');
    await tester.enterText(addresstext, '135 Acker Gym');
    await tester.enterText(citytext, 'Chico');
    parkingData.state = 'CA';
    await tester.enterText(ziptext, '95929');

    // Tap the 'next' button to submit form page 1 and trigger a frame
    final submit =
        find.widgetWithText(RaisedButton, 'Next: Parking Space Info');
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));

    final validateForm = AddParking1().createState().validateAndSave();
    expect(validateForm, isTrue);
  });

  testWidgets('Check page 1 error message after click',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    // Find submit Button
    final submit =
        find.widgetWithText(RaisedButton, 'Next: Parking Space Info');
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(
        find.text('Make sure to fill out all required fields'), findsOneWidget);
  });

  testWidgets('if State not selected, box returns red',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    // Find text fields for form input
    final titletext = find.byKey(Key('title'));
    final addresstext = find.byKey(Key('address'));
    final citytext = find.byKey(Key('city'));
    final ziptext = find.byKey(Key('zip'));

    // Test form text field input
    await tester.enterText(titletext, 'Acker Gym');
    await tester.enterText(addresstext, '135 Acker Gym');
    await tester.enterText(citytext, 'Chico');
    await tester.enterText(ziptext, '95929');

    // Find submit Button
    final submit =
        find.widgetWithText(RaisedButton, 'Next: Parking Space Info');
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    final container = tester.widget(find.byKey(Key('stateField'))) as Container;
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, Colors.red[50]);
  });

  // Note: Haven't figured out how to test dropdownformfield, so here the
  // object is being assigned a state, but the field is not being selected
  testWidgets('if state is not selected, correct error message after submit',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    var parkingData = ParkingData('', '', '', '', '', '', '', '');
    // Find text fields for form input
    final titletext = find.byKey(Key('title'));
    final addresstext = find.byKey(Key('address'));
    final citytext = find.byKey(Key('city'));
    parkingData.state = 'CA';
    final ziptext = find.byKey(Key('zip'));

    // Test form text field input
    await tester.enterText(titletext, 'Acker Gym');
    await tester.enterText(addresstext, '135 Acker Gym');
    await tester.enterText(citytext, 'Chico');
    await tester.enterText(ziptext, '95929');

    // Find submit Button
    final submit =
        find.widgetWithText(RaisedButton, 'Next: Parking Space Info');
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('Make sure to select a state'), findsOneWidget);
  });

  testWidgets('if state is selected, California text is found',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    var parkingData = ParkingData('', '', '', '', '', '', '', '');
    parkingData.state = 'CA';

    // Find submit Button
    final submit =
    find.widgetWithText(RaisedButton, 'Next: Parking Space Info');
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.widgetWithText(DropDownFormField, 'California'), findsOneWidget);
  });

  testWidgets('find text if state is not selected',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    // Find submit Button
    final submit =
    find.widgetWithText(RaisedButton, 'Next: Parking Space Info');
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    final txt = '* Currently only available in California:';
    expect(find.widgetWithText(DropDownFormField, txt), findsOneWidget);
  });

  testWidgets('if zip code is not valid, correct error message after submit',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    // Find text fields for form input
    final titletext = find.byKey(Key('title'));
    final addresstext = find.byKey(Key('address'));
    final citytext = find.byKey(Key('city'));
    final ziptext = find.byKey(Key('zip'));

    // Test form text field input
    await tester.enterText(titletext, 'Acker Gym');
    await tester.enterText(addresstext, '135 Acker Gym');
    await tester.enterText(citytext, 'Chico');
    await tester.enterText(ziptext, '9592*');

    // Find submit Button
    final submit =
        find.widgetWithText(RaisedButton, 'Next: Parking Space Info');
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('Enter a valid 5 digit US zip code'), findsOneWidget);
  });

  testWidgets('check State field onchanged', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: AddParking1(title: 'Post Your Parking Space'),
    ));

    final txt = '* State:';
    // // Verify the output in field onChanged.
    final statefield = tester.widget(find.widgetWithText(DropDownFormField, txt)) as DropDownFormField;
    statefield.onChanged('CA');
    statefield.onChanged('');
    expect(statefield.value, isEmpty);
  });

  // After button is pressed to go to next page, the geocoder is used to
  // create a set of coordinates to go with the provided address. Geocoder
  // works in practice, but doesn't seem to work with flutter_test. Also,
  // can't test selecting options from dropdown, so since those fields are
  // required, we can't test navigation to next page (same issue on page 2).
}
