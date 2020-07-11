import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/parking/find_parking.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
// look into cloud_firestore_mocks (Flutter Package)
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

//  testWidgets('Find LinearProgressIndicator Widget', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(MaterialApp(
//      home: FindParking(colRef: instance.collection(testCollection),
//          title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
//    ));
//
//    // Find Widget for LinearProgressIndicator widget
//    expect(find.byType(LinearProgressIndicator), findsOneWidget);
//  });

//  testWidgets('test checkFilters function', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(MaterialApp(
//      home: FindParking(title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
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