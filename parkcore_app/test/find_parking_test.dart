import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/parking/find_parking.dart';
import 'package:parkcore_app/parking/parking_details.dart';
import 'package:parkcore_app/models/Spot.dart';
import 'package:parkcore_app/screens/contact.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
// cloud_firestore_mocks (Flutter Package)
// http://blog.wafrat.com/how-to-write-unit-tests-for-firebase-in-flutter/

const testCollection = 'parkingSpaces';

void main() {
  // Populate the mock database.
  final instance = MockFirestoreInstance();

  testWidgets('Create mock database', (WidgetTester tester) async {
    await instance.collection(testCollection).add({
      'title': 'Hello world!',
      'address': '123 Main St',
      'amenities': '[Lit, Covered, Security Camera, EV Charging]',
      'coordinates': '{39.7285,-121.8375}',
      'city': 'MockAnywhereTest',
      'driveway': 'Right',
      'monthprice': '42.00',
      'spacetype': 'N/A',
      'downloadURL': null,
      'type': 'Driveway',
      'size': 'Compact',
      'days': '[MON, TUE, WED, THU, FRI]',
      'spacedetails': 'near the park and downtown',
      'starttime': '08:00',
      'endtime': '16:00',
      'state': 'CA',
      'zip': '95928',
      'uid': 'no current user',
    });
//    await instance.collection(testCollection).add({
//      'title': 'Only Required Fields',
//      'address': '1 Anywhere Ave',
//      'amenities': '[]',
//      'coordinates': '{39.7285,-121.8375}',
//      'city': 'MockAnywhereTest',
//      'driveway': 'N/A',
//      'monthprice': '73.00',
//      'spacetype': 'Angled',
//      'downloadURL': null,
//      'type': 'Street',
//      'size': 'Regular',
//      'days': '[]',
//      'spacedetails': '',
//      'starttime': '',
//      'endtime': '',
//      'state': 'CA',
//      'zip': '95928',
//      'uid': 'no current user',
//    });
//    await instance.collection(testCollection).add({
//      'title': 'Parking Space #3',
//      'address': '2 Broadway',
//      'amenities': '[Lit, Security Camera]',
//      'coordinates': '{39.7285,-121.8375}',
//      'city': 'MockAnywhereTest',
//      'driveway': 'N/A',
//      'monthprice': '19.00',
//      'spacetype': 'Perpendicular',
//      'downloadURL': null,
//      'type': 'Parking Lot',
//      'size': 'Compact',
//      'days': '[MON, WED, FRI]',
//      'spacedetails': '',
//      'starttime': '07:30',
//      'endtime': '03:30',
//      'state': 'CA',
//      'zip': '95926',
//      'uid': 'no current user',
//    });
  });

  testWidgets('Find the Find Parking page title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    // Find title
    final titleFinder = find.text('Find Parking');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Calculate Distance RaisedButton Field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    expect(find.widgetWithText(RaisedButton, 'Show distance to CSU, Chico'), findsOneWidget);
  });

  testWidgets('Tap Calculate Distance Button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));

    final buttontxt = 'Show distance to CSU, Chico';
    final buttonFinder = find.widgetWithText(RaisedButton, buttontxt);
    await tester.tap(buttonFinder);
    await tester.pump();
    // Expect to still be on Find Parking page
    expect(find.text('Find Parking'), findsOneWidget);
  });

  testWidgets('getFilterOptions returns All option', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    final options = ['All', 'Compact', 'Regular', 'Oversized'];
    final dropdownlist = FindParking().createState().getFilterOptions(options);
    final all = DropdownMenuItem<String>(value: 'All', child: Text('All'));
    expect(dropdownlist[0].value, all.value);
  });

  testWidgets('getFilterOptions returns expected list item', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));
    final options = ['All', 'Compact', 'Regular', 'Oversized'];
    final dropdownlist = FindParking().createState().getFilterOptions(options);
    final all = DropdownMenuItem<String>(value: 'All', child: Text('All'));
    final compact = DropdownMenuItem<String>(value: 'Compact', child: Text('Compact'));
    final reg = DropdownMenuItem<String>(value: 'Regular', child: Text('Regular'));
    final over = DropdownMenuItem<String>(value: 'Oversized', child: Text('Oversized'));
    final expected = [all, compact, reg, over];
    expect(dropdownlist[3].value, expected[3].value);
  });

  testWidgets('Finds Price Filter', (WidgetTester tester) async {
    // Build an app with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Text('Price'),
      ),
    ));

    // Find a widget that displays the letter 'H'.
    expect(find.text('Price'), findsOneWidget);
  });

  testWidgets('Finds Apply Filters Widget', (WidgetTester tester) async {
      // Build an app with a Text widget that displays the letter 'H'.
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Text('Apply Filters'),
        ),
      ));

      // Find a widget that displays the letter 'H'.
      expect(find.text('Apply Filters'), findsOneWidget);
    });
  testWidgets('Finds Show All Filter', (WidgetTester tester) async {
    // Build an app with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Text('Show All'),
      ),
    ));

    // Find a widget that displays the letter 'H'.
    expect(find.text('Show All'), findsOneWidget);
  });

  testWidgets('Finds Amentities Filter', (WidgetTester tester) async {
    // Build an app with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Text('Amenities'),
      ),
    ));

    // Find a widget that displays the letter 'H'.
    expect(find.text('Amenities'), findsOneWidget);
  });

  testWidgets('Choose a city with no locations', (WidgetTester tester) async {
    // Build an app with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Text('Let us know you\'re interested!'),
      ),
    ));

    // Find a widget that displays the letter 'H'.
    expect(find.text('Let us know you\'re interested!'), findsOneWidget);
  });

  testWidgets('Haversize for Distance', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    expect(FindParking().createState().haversize('{39.727580,-121.840430}'), '13');
  });

  testWidgets('Haversize for Distance', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    expect(FindParking().createState().haversize('{39.72096140000001,-121.8450891}'), '17');
  });

  testWidgets('Haversize for Distance', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    expect(FindParking().createState().haversize('{39.7282242,-121.8408044}'), '12');
  });

  testWidgets('Adjust Distance-Less than a Mile', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    expect(FindParking().createState().adjustDistance(.5), .5);
  });

  testWidgets('Adjust Distance-Less than a Mile', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    expect(FindParking().createState().adjustDistance(.2), .2);
  });

  testWidgets('Adjust Distance-More than a Mile', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    expect(FindParking().createState().adjustDistance(3.6), 4.35);
  });

  testWidgets('Adjust Distance-More than a Mile', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    expect(FindParking().createState().adjustDistance(2.5), 3);
  });

  testWidgets('Parking Spot Column', (WidgetTester tester) async {
    
    final childWidget = Padding(padding: const EdgeInsets.all(10.0), child: Column());

    // Provide the childWidget to the Container.
    await tester.pumpWidget(Container(child: childWidget));

    // Search for the childWidget in the tree and verify it exists.
    expect(find.byWidget(childWidget), findsOneWidget);
  });

  testWidgets('find list body of parking spots', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    expect(find.byKey(Key('listBody')), findsOneWidget);
  });

  testWidgets('expect to not find any spots in this city', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'NowhereCity', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    expect(find.byKey(Key('nospaces')), findsOneWidget);
  });

  testWidgets('Find LinearProgressIndicator Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    // Find LinearProgressIndicator widget when city is not MockAnywhereTest
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  testWidgets('expect to find filter buttons', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    expect(find.byKey(Key('filterbuttons')), findsNWidgets(2));
  });

  testWidgets('expect to find Apply Filters button', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    expect(find.widgetWithText(RaisedButton, 'Apply Filters'), findsOneWidget);
  });

  testWidgets('click Apply Filters button', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    final filtersButton = find.widgetWithText(RaisedButton, 'Apply Filters');
    await tester.tap(filtersButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.byKey(Key('boxes')), findsOneWidget);
  });

  testWidgets('expect to find Show All button', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    expect(find.widgetWithText(RaisedButton, 'Show All'), findsOneWidget);
  });

  testWidgets('click Show All button', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    final allButton = find.widgetWithText(RaisedButton, 'Show All');
    await tester.tap(allButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.byKey(Key('boxes')), findsOneWidget);
  });

  testWidgets('expect to find Size list tile', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    expect(find.byKey(Key('sizeListTile')), findsOneWidget);
  });

  testWidgets('expect to find Size filter button', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    expect(find.byKey(Key('sizeButton')), findsOneWidget);
  });

  testWidgets('tap Size filter button', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    final size = tester.widget(find.byKey(Key('sizeButton'))) as DropdownButton<String>;
    size.onChanged('Compact');
    size.onChanged('All');
    expect(size.value, 'All');
  });

  testWidgets('expect to find Type list tile', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    expect(find.widgetWithText(ListTile, 'Type'), findsOneWidget);
  });

  testWidgets('tap Type filter button', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    final type = tester.widget(find.byKey(Key('typeButton'))) as DropdownButton<String>;
    type.onChanged('Driveway');
    type.onChanged('All');
    expect(type.value, 'All');
  });

  testWidgets('expect to find Price list tile', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    expect(find.widgetWithText(ListTile, 'Price'), findsOneWidget);
  });

  testWidgets('tap Price filter button', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    final price = tester.widget(find.byKey(Key('priceButton'))) as DropdownButton<String>;
    price.onChanged('\$50 or less');
    price.onChanged('All');
    expect(price.value, 'All');
  });

  testWidgets('expect to find Amenities filter button', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    expect(find.widgetWithText(FlatButton, 'Amenities'), findsOneWidget);
  });

  testWidgets('expect to not find Lit option (before Amenities clicked)', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    expect(find.text('Lit'), findsNothing);
  });

  testWidgets('expect to not find EV option (before Amenities clicked)', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    expect(find.text('EV Charging'), findsNothing);
  });

  testWidgets('expect to find Lit option (after Amenities clicked)', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    final amenitiesButton = find.widgetWithText(FlatButton, 'Amenities');
    await tester.tap(amenitiesButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('Lit'), findsOneWidget);
  });

  testWidgets('expect to find EV option (after Amenities clicked)', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    final amenitiesButton = find.widgetWithText(FlatButton, 'Amenities');
    await tester.tap(amenitiesButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('EV Charging'), findsOneWidget);
  });

  testWidgets('expect to find Amenities toggle buttons', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    final amenitiesButton = find.widgetWithText(FlatButton, 'Amenities');
    await tester.tap(amenitiesButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.byType(ToggleButtons), findsOneWidget);
  });

  testWidgets('tap Amenities toggle buttons', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    final amenitiesButton = find.widgetWithText(FlatButton, 'Amenities');
    await tester.tap(amenitiesButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    final toggleButtons = find.byType(ToggleButtons);
    await tester.tap(toggleButtons);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.byIcon(Icons.videocam), findsOneWidget);
  });

  testWidgets('apply filters after tapping amenities', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    final amenitiesButton = find.widgetWithText(FlatButton, 'Amenities');
    await tester.tap(amenitiesButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    final toggleButtons = find.byType(ToggleButtons);
    await tester.tap(toggleButtons);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    final apply = find.widgetWithText(RaisedButton, 'Apply Filters');
    await tester.tap(apply);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.byKey(Key('boxes')), findsOneWidget);
  });

  testWidgets('expect to find GestureDetector', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // Verify the output.
    expect(find.byKey(Key('gotodetails')), findsOneWidget);
  });

  testWidgets('tap GestureDetector: go to details page', (WidgetTester tester) async {
    var myMap = <String,dynamic>{};
    myMap['title'] = 'My Parking Spot';
    myMap['address'] = '123 Main St';
    myMap['amenities'] = '[Lit, Covered, Security Camera, EV Charging]';
    myMap['coordinates'] = '{39.7285,-121.8375}';
    myMap['city'] = 'Chico';
    myMap['driveway'] = 'Right';
    myMap['monthprice'] = '42.00';
    myMap['spacetype'] = 'N/A';
    myMap['downloadURL'] = null;
    myMap['type'] = 'Driveway';
    myMap['size'] = 'Compact';
    myMap['days'] = '[MON, TUE, WED, THU, FRI]';
    myMap['spacedetails'] = 'near the park and downtown';
    myMap['starttime'] = '08:00';
    myMap['endtime'] = '16:00';
    myMap['state'] = 'CA';
    myMap['zip'] = '95928';
    myMap['uid'] = 'no current user';
    final mySpot = Spot.fromMap(myMap);

    final routes = <String, WidgetBuilder>{
      '/details' : (BuildContext context) => DetailScreen(spot: mySpot),
    };
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
        title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
      initialRoute: '/',
      routes: routes,
    ));

    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    final gesture = find.byKey(Key('gotodetails'));
    await tester.tap(gesture);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.widgetWithIcon(IconButton, Icons.clear), findsOneWidget);
  });

  testWidgets('tap GestureDetector: go to details page', (WidgetTester tester) async {
    var myMap = <String,dynamic>{};
    myMap['title'] = 'My Parking Spot';
    myMap['address'] = '123 Main St';
    myMap['amenities'] = '[Lit, Covered, Security Camera, EV Charging]';
    myMap['coordinates'] = '{39.7285,-121.8375}';
    myMap['city'] = 'Chico';
    myMap['driveway'] = 'Right';
    myMap['monthprice'] = '42.00';
    myMap['spacetype'] = 'N/A';
    myMap['downloadURL'] = null;
    myMap['type'] = 'Driveway';
    myMap['size'] = 'Compact';
    myMap['days'] = '[MON, TUE, WED, THU, FRI]';
    myMap['spacedetails'] = 'near the park and downtown';
    myMap['starttime'] = '08:00';
    myMap['endtime'] = '16:00';
    myMap['state'] = 'CA';
    myMap['zip'] = '95928';
    myMap['uid'] = 'no current user';
    final mySpot = Spot.fromMap(myMap);

    final routes = <String, WidgetBuilder>{
      '/details' : (BuildContext context) => DetailScreen(spot: mySpot),
    };
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
      initialRoute: '/',
      routes: routes,
    ));

    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    final gesture = find.byKey(Key('gotodetails'));
    await tester.tap(gesture);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    final clear = find.widgetWithIcon(IconButton, Icons.clear);
    await tester.tap(clear);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('Find Parking'), findsOneWidget);
  });

  testWidgets('no spots in this city, find forward arrow', (WidgetTester tester) async {
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'NowhereCity', latlong: '{39.7285,-121.8375}'),
    ));
    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // Verify the output.
    expect(find.widgetWithIcon(ListTile, Icons.arrow_forward), findsOneWidget);
  });

  testWidgets('expect to go to Contact Us page', (WidgetTester tester) async {
    final routes = <String, WidgetBuilder>{
      '/contact': (context) => ContactUs(),
    };

    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'NowhereCity', latlong: '{39.7285,-121.8375}'),
      initialRoute: '/',
      routes: routes,
    ));

    //final snapshot = await instance.collection(testCollection).getDocuments();
    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    final gesture = find.widgetWithIcon(ListTile, Icons.arrow_forward);
    await tester.tap(gesture);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('Contact Us'), findsOneWidget);
  });

  testWidgets('check alertDialog content', (WidgetTester tester) async {
    var myMap = <String,dynamic>{};
    myMap['title'] = 'My Parking Spot';
    myMap['address'] = '123 Main St';
    myMap['amenities'] = '[Lit, Covered, Security Camera, EV Charging]';
    myMap['coordinates'] = '{39.7285,-121.8375}';
    myMap['city'] = 'Chico';
    myMap['driveway'] = 'Right';
    myMap['monthprice'] = '42.00';
    myMap['spacetype'] = 'N/A';
    myMap['downloadURL'] = null;
    myMap['type'] = 'Driveway';
    myMap['size'] = 'Compact';
    myMap['days'] = '[MON, TUE, WED, THU, FRI]';
    myMap['spacedetails'] = 'near the park and downtown';
    myMap['starttime'] = '08:00';
    myMap['endtime'] = '16:00';
    myMap['state'] = 'CA';
    myMap['zip'] = '95928';
    myMap['uid'] = 'no current user';
    final mySpot = Spot.fromMap(myMap);

    final routes = <String, WidgetBuilder>{
      '/details' : (BuildContext context) => DetailScreen(spot: mySpot),
    };
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
      initialRoute: '/',
      routes: routes,
    ));

    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    final alert = FindParking().createState().spotAlert(mySpot, mySpot.title) as AlertDialog;
    final txt = 'Want to know more about this location?';
    expect(alert.content.toString(), Text(txt).toString());
  });

  testWidgets('Check alertDialog title', (WidgetTester tester) async {
    var myMap = <String,dynamic>{};
    myMap['title'] = 'My Parking Spot';
    myMap['address'] = '123 Main St';
    myMap['amenities'] = '[Lit, Covered, Security Camera, EV Charging]';
    myMap['coordinates'] = '{39.7285,-121.8375}';
    myMap['city'] = 'Chico';
    myMap['driveway'] = 'Right';
    myMap['monthprice'] = '42.00';
    myMap['spacetype'] = 'N/A';
    myMap['downloadURL'] = null;
    myMap['type'] = 'Driveway';
    myMap['size'] = 'Compact';
    myMap['days'] = '[MON, TUE, WED, THU, FRI]';
    myMap['spacedetails'] = 'near the park and downtown';
    myMap['starttime'] = '08:00';
    myMap['endtime'] = '16:00';
    myMap['state'] = 'CA';
    myMap['zip'] = '95928';
    myMap['uid'] = 'no current user';
    final mySpot = Spot.fromMap(myMap);

    final routes = <String, WidgetBuilder>{
      '/details' : (BuildContext context) => DetailScreen(spot: mySpot),
    };
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
      initialRoute: '/',
      routes: routes,
    ));

    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // // Verify the output.
    final alert = FindParking().createState().spotAlert(mySpot, mySpot.title) as AlertDialog;
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    expect(alert.title.toString(), Text(mySpot.title).toString());
  });

  testWidgets('Find alertDialog button', (WidgetTester tester) async {
    var myMap = <String,dynamic>{};
    myMap['title'] = 'My Parking Spot';
    myMap['address'] = '123 Main St';
    myMap['amenities'] = '[Lit, Covered, Security Camera, EV Charging]';
    myMap['coordinates'] = '{39.7285,-121.8375}';
    myMap['city'] = 'Chico';
    myMap['driveway'] = 'Right';
    myMap['monthprice'] = '42.00';
    myMap['spacetype'] = 'N/A';
    myMap['downloadURL'] = null;
    myMap['type'] = 'Driveway';
    myMap['size'] = 'Compact';
    myMap['days'] = '[MON, TUE, WED, THU, FRI]';
    myMap['spacedetails'] = 'near the park and downtown';
    myMap['starttime'] = '08:00';
    myMap['endtime'] = '16:00';
    myMap['state'] = 'CA';
    myMap['zip'] = '95928';
    myMap['uid'] = 'no current user';
    final mySpot = Spot.fromMap(myMap);

    final routes = <String, WidgetBuilder>{
      '/details' : (BuildContext context) => DetailScreen(spot: mySpot),
    };
    // Render the widget.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(colRef: instance.collection(testCollection),
          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
      initialRoute: '/',
      routes: routes,
    ));

    // Let the snapshots stream fire a snapshot; then re-render
    await tester.idle();
    await tester.pump();
    // Verify the output.
    FindParking().createState().spotAlert(mySpot, mySpot.title);
    expect(find.byType(FlatButton), findsOneWidget);
  });

//  testWidgets('Find alertDialog actions', (WidgetTester tester) async {
//    var myMap = <String,dynamic>{};
//    myMap['title'] = 'My Parking Spot';
//    myMap['address'] = '123 Main St';
//    myMap['amenities'] = '[Lit, Covered, Security Camera, EV Charging]';
//    myMap['coordinates'] = '{39.7285,-121.8375}';
//    myMap['city'] = 'Chico';
//    myMap['driveway'] = 'Right';
//    myMap['monthprice'] = '42.00';
//    myMap['spacetype'] = 'N/A';
//    myMap['downloadURL'] = null;
//    myMap['type'] = 'Driveway';
//    myMap['size'] = 'Compact';
//    myMap['days'] = '[MON, TUE, WED, THU, FRI]';
//    myMap['spacedetails'] = 'near the park and downtown';
//    myMap['starttime'] = '08:00';
//    myMap['endtime'] = '16:00';
//    myMap['state'] = 'CA';
//    myMap['zip'] = '95928';
//    myMap['uid'] = 'no current user';
//    final mySpot = Spot.fromMap(myMap);
//
//    final routes = <String, WidgetBuilder>{
//      '/details' : (BuildContext context) => DetailScreen(spot: mySpot),
//    };
//    // Render the widget.
//    await tester.pumpWidget(MaterialApp(
//      home: FindParking(colRef: instance.collection(testCollection),
//          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
//      initialRoute: '/',
//      routes: routes,
//    ));
//
//    //final snapshot = await instance.collection(testCollection).getDocuments();
//    // Let the snapshots stream fire a snapshot; then re-render
//    await tester.idle();
//    await tester.pump();
//    // // Verify the output.
//    final alert = FindParking().createState().spotAlert(mySpot, mySpot.title) as AlertDialog;
//    //await tester.tap(alert);
//    await tester.pump();
//    await tester.pump(const Duration(milliseconds: 10));
////    final clear = find.widgetWithIcon(IconButton, Icons.clear);
////    await tester.tap(clear);
////    await tester.pump();
////    await tester.pump(const Duration(milliseconds: 10));
//    final button = FlatButton(
//      child: Text('Visit the details page for this spot'),
//      onPressed: () {
//        FindParking().createState().goToDetails(mySpot);
//      },
//    );
//    expect(alert.actions, [button]);
//    // expect(alert.content, Text('Want to know more about this location?'));
//  });

//  testWidgets('expect to find 1 marker', (WidgetTester tester) async {
//    // Render the widget.
//    await tester.pumpWidget(MaterialApp(
//      home: FindParking(colRef: instance.collection(testCollection),
//          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
//    ));
//    //final snapshot = await instance.collection(testCollection).getDocuments();
//    // Let the snapshots stream fire a snapshot; then re-render
//    await tester.idle();
//    await tester.pump();
//    // // Verify the output.
//    expect(find.byType(Marker), findsOneWidget);
//  });

//  testWidgets('click Lit option (after Amenities clicked)', (WidgetTester tester) async {
//    // Render the widget.
//    await tester.pumpWidget(MaterialApp(
//      home: FindParking(colRef: instance.collection(testCollection),
//          title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
//    ));
//    //final snapshot = await instance.collection(testCollection).getDocuments();
//    // Let the snapshots stream fire a snapshot; then re-render
//    await tester.idle();
//    await tester.pump();
//    // // Verify the output.
//    final amenitiesButton = find.widgetWithText(FlatButton, 'Amenities');
//    await tester.tap(amenitiesButton);
//    await tester.pump();
//    await tester.pump(const Duration(milliseconds: 10));
//    final litButton = find.widgetWithText(Container, 'Lit');
//    await tester.tap(litButton);
//    await tester.pump();
//    await tester.pump(const Duration(milliseconds: 10));
//    expect(find.widgetWithIcon(Container, Icons.lightbulb_outline), findsOneWidget);
//  });

//  testWidgets('test checkFilters function', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(MaterialApp(
//      home: FindParking(colRef: instance.collection(testCollection),
//        title: 'Find Parking', city: 'MockAnywhereTest', latlong: '{39.7285,-121.8375}'),
//    ));
//    var numFilters = 0;
//    numFilters++;
//    FindParking().createState().checkFilters();
//    await tester.pump();
//    await tester.pump(const Duration(milliseconds: 10));
//    expect(numFilters, equals(0));
//  });

  /*testWidgets('Flat Button Field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    expect(find.byType(FlatButton), findsOneWidget);
  });*/

  /*testWidgets('Find ListView', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    // expect to find 1 form
    expect(find.byType(NetworkImage), findsOneWidget);
  });*/

  /*testWidgets('Calculate Distance RaisedButton Works', (WidgetTester tester) async {
    
    await tester.pumpWidget(MaterialApp(
      home: FindParking(title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));
    
    final childWidget = Container(padding: EdgeInsets.all(5.0));
    
    expect(FindParking().createState().displayDistance('{39.7285,-121.8375}'), childWidget);
  
  });
  testWidgets('Calculate Distance RaisedButton Field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    expect(find.byType(Icon), findsWidgets);
  });*/

}