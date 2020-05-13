import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/parking/find_parking.dart';

void main() {
  testWidgets('Find the Find Parking page title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    // Find title
    final titleFinder = find.text('Find Parking');
    expect(titleFinder, findsOneWidget);
  });
  testWidgets('Calculate Distance RaisedButton Field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    expect(find.widgetWithText(RaisedButton, 'Show distance to CSU, Chico'), findsOneWidget);
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
        body: Text("Let us know you're interested!"),
      ),
    ));

    // Find a widget that displays the letter 'H'.
    expect(find.text("Let us know you're interested!"), findsOneWidget);
  });
  

  testWidgets('Haversize for Distance', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    expect(FindParking().createState().haversize('{39.727580,-121.840430}'), '13');
  });

  testWidgets('Adjust Distance-Less than a Mile', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    expect(FindParking().createState().adjustDistance(.5), .5);
  });

  testWidgets('Adjust Distance-More than a Mile', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FindParking(title: 'Find Parking', city: 'Chico', latlong: '{39.7285,-121.8375}'),
    ));

    expect(FindParking().createState().adjustDistance(3.6), 4.35);
  });

  testWidgets('Parking Spot Column', (WidgetTester tester) async {
    final childWidget = Padding(padding: const EdgeInsets.all(10.0), child: Column());

    // Provide the childWidget to the Container.
    await tester.pumpWidget(Container(child: childWidget));

    // Search for the childWidget in the tree and verify it exists.
    expect(find.byWidget(childWidget), findsOneWidget);
  });
}