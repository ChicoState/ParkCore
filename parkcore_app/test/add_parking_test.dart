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
import 'package:parkcore_app/parking/random_coordinates.dart';

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

  testWidgets('Check user loaded', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));
    final curUser = CurrentUser();

    AddParking().createState().loadCurrentUser();
    expect(curUser.currentUser, null);
  });

  test('Page number getter and setter', () {
    final pageNum = PageNumber();
    pageNum.page = 1;
    expect(pageNum.page, 1);
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
    formError.errorMessage = "We can't find you!\nPlease enter a valid location.";
    expect(formError.errorMessage, "We can't find you!\nPlease enter a valid location.");
  });

  test('Parking Space Title getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.title = "My Parking Space";
    expect(parkingSpace.title, "My Parking Space");
  });

  test('Parking Space Address getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.address = "123 Main St";
    expect(parkingSpace.address, "123 Main St");
  });

  test('Parking Space City getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.city = "Chico";
    expect(parkingSpace.city, "Chico");
  });

  test('Parking Space State getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.state = "CA";
    expect(parkingSpace.state, "CA");
  });

  test('Parking Space Zip getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.zip = "95928";
    expect(parkingSpace.zip, "95928");
  });

  test('Parking Space City (formatted) getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.city_format = "Chico";
    expect(parkingSpace.city_format, "Chico");
  });

  testWidgets('check address formatted after string split', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: "Post Your Parking Space"),
    ));

    final parkingSpace = ParkingSpace();
    final String input = '215 Orange St, Chico, CA 95928, USA';
    List<String> splitAddress = AddParking().createState().getSplitAddress(input);
    parkingSpace.city_format = splitAddress[1];
    expect(parkingSpace.city_format, "Chico");
  });

  test('Parking Space Size getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.size = "Compact";
    expect(parkingSpace.size, "Compact");
  });

  test('Parking Space Type getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.type = "Driveway";
    expect(parkingSpace.type, "Driveway");
  });

  test('Parking Space Driveway getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.driveway = "Left";
    expect(parkingSpace.driveway, "Left");
  });

  test('Parking Space Type -- Space Type getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.spaceType = "Parallel";
    expect(parkingSpace.spaceType, "Parallel");
  });

  test('Parking Space Amenities getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.myAmenities = ["Lit", "Covered", "Security Camera", "EV Charging"];
    expect(parkingSpace.myAmenities, ["Lit", "Covered", "Security Camera", "EV Charging"]);
  });

  test('Parking Space Details getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.details = "down an alley";
    expect(parkingSpace.details, "down an alley");
  });

  test('Parking Space Days Available getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.myDays = ["MON", "TUE", "WED", "THU", "FRI"];
    expect(parkingSpace.myDays, ["MON", "TUE", "WED", "THU", "FRI"]);
  });

  test('Parking Space Start Time getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.startTime = "09:00";
    expect(parkingSpace.startTime, "09:00");
  });

  test('Parking Space End Time getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.endTime = "20:00";
    expect(parkingSpace.endTime, "20:00");
  });

  test('Parking Space Price getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.price = "42.00";
    expect(parkingSpace.price, "42.00");
  });

  test('Parking Space image download url getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.downloadURL = "https://firebasestorage.googleapis.com/v0/b/parkcore-7e1db.appspot.com/o/ec6dfa50-73a5-11ea-ff1e-8963043440f0.jpg?alt=media&token=2125fdf0-1f32-4ab3-a27a-86b286862e1f";
    expect(parkingSpace.downloadURL, "https://firebasestorage.googleapis.com/v0/b/parkcore-7e1db.appspot.com/o/ec6dfa50-73a5-11ea-ff1e-8963043440f0.jpg?alt=media&token=2125fdf0-1f32-4ab3-a27a-86b286862e1f");
  });

  test('Parking Space Coordinates getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.coordinates = "{39.7285,-121.8375}";
    expect(parkingSpace.coordinates, "{39.7285,-121.8375}");
  });

  test('Parking Space Random Coordinates Latitude getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.coordinates = "{39.7285,-121.8375}";
    parkingSpace.coord_rand = getRandomCoordinates(parkingSpace.coordinates);
    expect(parkingSpace.coord_rand.contains("39"), isTrue);
  });

  test('Parking Space Random Coordinates Longitude getter and setter', () {
    final parkingSpace = ParkingSpace();
    parkingSpace.coordinates = "{39.7285,-121.8375}";
    parkingSpace.coord_rand = getRandomCoordinates(parkingSpace.coordinates);
    expect(parkingSpace.coord_rand.contains("-121"), isTrue);
  });

  testWidgets('Parking Form Check that page number increases', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));
    final pageNum = PageNumber();
    pageNum.page++;
    expect(pageNum.page, 2);
  });

  testWidgets('Check load user', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking(title: 'Post Your Parking Space'),
    ));
    final curUser = CurrentUser();

    AddParking().createState().loadCurrentUser();
    expect(curUser.currentUser, null);
  });

//  testWidgets('Check user-entered title set as parkingForm.title', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(MaterialApp(
//      home: AddParking(title: 'Post Your Parking Space'),
//    ));
//
//    // Create the finders
//    final Finder title = find.byKey(Key('title'));
//    final parkingSpace = ParkingSpace();
//    final Finder submit = find.widgetWithText(RaisedButton, "Next: Parking Space Info");
//
//    // Test text field form input
//    await tester.enterText(title, 'My Parking Space!');
//    await tester.tap(submit);
//    await tester.pump();
//    // Expect Text Widget message
//    expect(parkingSpace.title, "My Parking Space!");
//  });

//  testWidgets('check form page 2 returns Containers', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(MaterialApp(
//      home: AddParking(title: 'Post Your Parking Space'),
//    ));
//    final pageNum = PageNumber();
//    final parkingSpace = ParkingSpace();
//    final formError = FormError();
//    expect(find.text("Part 1 of 5"), findsOneWidget);
//    parkingSpace.title = "My Title!";
//    parkingSpace.address = "My address";
//    parkingSpace.city = "notalocation";
//    parkingSpace.state = "CA";
//    parkingSpace.zip = "12345";
//    parkingSpace.city_format = "";
//    formError.invalidLoc = true;
//    formError.errorMessage = "We can't find you!\nPlease enter a valid location.";
////    await tester.pump(Duration(seconds: 3));
////    await tester.pump(Duration(seconds: 3));
//    var formPages = AddParking().createState().formPages();
//    AddParking().createState().pageButton('Next: Parking Space Info');
//    await tester.pump(Duration(seconds: 3));
//    //await tester.pump(Duration(seconds: 3));
//
//   // expect(parkingSpace.coordinates, isNotNull);
//    //expect(find.text("Part 2 of 5"), findsOneWidget);
//  });

}
