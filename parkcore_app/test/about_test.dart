import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/screens/about.dart';

void main() {
  testWidgets('Find About Us Page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: About(),
    ));

    // Find title
    final titleFinder = find.text('About ParkCore');
    expect(titleFinder, findsOneWidget);
  });
}