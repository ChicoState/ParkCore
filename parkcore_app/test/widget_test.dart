// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/screens/home.dart';
import 'package:geocoder/geocoder.dart';

void main() {
  testWidgets('Find Home Page Title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
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
      home: MyHomePage(title: 'ParkCore'),
    ));

    // Find text PARKCORE once
    expect(find.text('PARKCORE'), findsOneWidget);
  });

  testWidgets('find PARKCORE tagline text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));

    // Find tagline text once
    expect(find.text('find a spot. go nuts.'), findsOneWidget);
  });

  testWidgets('Find Search Bar Form', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));

    // Finds 1 Form Widget
    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('Find Search Bar Form Text Field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));

    // Finds 1 TextFormField Widget (for search input field in 1 Form)
    expect(find.byType(TextFormField), findsOneWidget);
  });

  testWidgets('Find Home Page Buttons', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));

    // Finds 3 IconButton Widgets (search, ParkCore logo, and menu icons)
    expect(find.byType(IconButton), findsNWidgets(3));
  });

  testWidgets(
      'Find One ParkCore Logo Icon Button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));

    // Find 1 Icon Button with Semantics Label (ParkCore logo)
    expect(find.bySemanticsLabel('ParkCore Logo'), findsOneWidget);
  });

  testWidgets('Find One Menu Icon Button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));

    // Find 1 Menu Icon Button
    expect(find.widgetWithIcon(IconButton, Icons.menu), findsOneWidget);
  });

  testWidgets('Find One Search Icon Button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));

    // Finds 1 Search IconButton
    expect(find.widgetWithIcon(IconButton, Icons.search), findsOneWidget);
  });

  testWidgets(
      'Check search result not initially visible', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));

    // Expect Text Widget message
    expect(find.text('Find parking near:'), findsNothing);
  });

  testWidgets('Check search input match', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));

    // Create the finders
    final searchinput = find.widgetWithText(
        TextFormField, 'Search by location');
    final submit = find.widgetWithIcon(IconButton, Icons.search);

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
      home: MyHomePage(title: 'ParkCore'),
    ));

    // Create the finders
    final searchinput = find.widgetWithText(
        TextFormField, 'Search by location');
    final submit = find.widgetWithIcon(IconButton, Icons.search);

    // Test form search field input
    await tester.enterText(searchinput, 'Chico, CA');
    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();

    expect(MyHomePage().createState().getLocation(), isTrue);
  });

  testWidgets('check search location city string split', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));

    final input = 'Chico, CA, USA';

    expect(MyHomePage().createState().getSplitAddress(input), ['Chico', 'CA', 'USA']);
  });

  testWidgets('check search location address string split', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));

    final input = '215 Orange St, Chico, CA 95928, USA';

    expect(MyHomePage().createState().getSplitAddress(input),
        ['215 Orange St', 'Chico', 'CA 95928', 'USA']);
  });

  test('Search input getter and setter', () {
    final input = MyInput();
    input.input = 'chico, ca';
    expect(input.input, 'chico, ca');
  });

  test('Location getter and setter', () {
    final loc = MyLoc();
    loc.location = 'Chico, CA, USA';
    expect(loc.location, 'Chico, CA, USA');
  });

  test('Failed Location getter and setter', () {
    final loc = MyLoc();
    loc.location = 'Sorry, no search results for '' + input + ''.';
    expect(loc.location, 'Sorry, no search results for '' + input + ''.');
  });

  test('City getter and setter', () {
    final city = MyCity();
    city.city = 'Chico';
    expect(city.city, 'Chico');
  });

  test('Coordinates getter and setter', () {
    final coords = MyCoordinates();
    coords.coordinates = '{39.7285,-121.8375}';
    expect(coords.coordinates, '{39.7285,-121.8375}');
  });

  test('Location Found true - getter and setter', () {
    final found = LocFound();
    found.found = true;
    expect(found.found, true);
  });

  test('Location Found false - getter and setter', () {
    final found = LocFound();
    found.found = false;
    expect(found.found, false);
  });

  testWidgets('expect searchController text is not null', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));
    final _searchController = TextEditingController();
    final searchtext = find.widgetWithText(
        TextFormField, 'Search by location');
    final submit = find.widgetWithIcon(IconButton, Icons.search);
    _searchController.text = 'Chico, CA';
    // Test form search field input
    await tester.enterText(searchtext, _searchController.text);
    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();

    expect(_searchController.text, isNotNull);
  });

  testWidgets('find getLocation is true', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));
    final _searchController = TextEditingController();
    final searchtext = find.widgetWithText(
        TextFormField, 'Search by location');
    final submit = find.widgetWithIcon(IconButton, Icons.search);
    _searchController.text = 'Chico, CA';
    // Test form search field input
    await tester.enterText(searchtext, _searchController.text);
    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();

    expect(_searchController.text, isNotNull);

    await tester.pump();
    expect(MyHomePage().createState().getLocation(), isTrue);
  });

  testWidgets('expect find searchResult widget', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));
    final _searchController = TextEditingController();
    final searchtext = find.widgetWithText(
        TextFormField, 'Search by location');
    final submit = find.widgetWithIcon(IconButton, Icons.search);
    _searchController.text = 'Chico, CA';
    // Test form search field input
    await tester.enterText(searchtext, _searchController.text);
    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();

    expect(_searchController.text, isNotNull);

    await tester.pump();
    expect(MyHomePage().createState().getLocation(), isTrue);

    await tester.pump();
    expect(find.byKey(Key('searchResult')), findsOneWidget);
  });

  testWidgets('expect \'found\' is false', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));
    final _searchController = TextEditingController();
    final searchtext = find.widgetWithText(
        TextFormField, 'Search by location');
    final submit = find.widgetWithIcon(IconButton, Icons.search);
    _searchController.text = 'notalocation';
    // Test form search field input
    await tester.enterText(searchtext, _searchController.text);
    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();

    expect(_searchController.text, isNotNull);

    await tester.pump();
    expect(MyHomePage().createState().getLocation(), isTrue);

    await tester.pump();
    expect(find.byKey(Key('searchResult')), findsOneWidget);

    final found = LocFound();
    await tester.pump();
    expect(found.found, isFalse);
  });

  testWidgets('expect to find FailedSearch widget', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));
    final _searchController = TextEditingController();
    final searchtext = find.widgetWithText(
        TextFormField, 'Search by location');
    final submit = find.widgetWithIcon(IconButton, Icons.search);
    _searchController.text = 'notalocation';
    // Test form search field input
    await tester.enterText(searchtext, _searchController.text);
    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();

    expect(_searchController.text, isNotNull);

    await tester.pump();
    expect(MyHomePage().createState().getLocation(), isTrue);

    await tester.pump();
    expect(find.byKey(Key('searchResult')), findsOneWidget);

    final found = LocFound();
    await tester.pump();
    expect(found.found, isFalse);

    await tester.pump();
    expect(find.byKey(Key('failedSearch')), findsOneWidget);
  });

  testWidgets('expect to find FailedSearch widget message', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));
    final _searchController = TextEditingController();
    final searchtext = find.widgetWithText(
        TextFormField, 'Search by location');
    final submit = find.widgetWithIcon(IconButton, Icons.search);
    _searchController.text = 'notalocation';
    // Test form search field input
    await tester.enterText(searchtext, _searchController.text);
    // Tap the search icon and trigger a frame
    await tester.tap(submit);
    await tester.pump();

    expect(_searchController.text, isNotNull);

    await tester.pump();
    expect(MyHomePage().createState().getLocation(), isTrue);

    await tester.pump();
    expect(find.byKey(Key('searchResult')), findsOneWidget);

    // expect to find validateLocation() function
    // haven't found way to test geocoder (which this function uses)
    MyHomePage().createState().validateLocation();
  });

  testWidgets('Test set location (full address)', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));
    final query = '1600 Amphiteatre Parkway, Mountain View, CA, USA';
    //final first = await Geocoder.local.findAddressesFromQuery(query) as Address;
    final first = Address();
    var addr = MyHomePage().createState().getSplitAddress(query); // String []
    MyHomePage().createState().setLoc(first, addr);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('ParkCore'), findsOneWidget);
  });

  testWidgets('Test set location (just city)', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));
    final query = 'Mountain View, CA, USA';
    //final first = await Geocoder.local.findAddressesFromQuery(query) as Address;
    final first = Address();
    var addr = MyHomePage().createState().getSplitAddress(query); // String []
    MyHomePage().createState().setLoc(first, addr);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('ParkCore'), findsOneWidget);
  });

  testWidgets('Test location not found setState', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: 'ParkCore'),
    ));
    final query = 'notarealplace';
    MyHomePage().createState().locNotFound(query);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('ParkCore'), findsOneWidget);
  });
}
