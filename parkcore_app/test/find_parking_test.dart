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
}