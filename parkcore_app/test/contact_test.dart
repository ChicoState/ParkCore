import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/screens/contact.dart';

void main() {
  testWidgets('Find Contact Us Page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: ContactUs(),
    ));

    // Find title
    final titleFinder = find.text('Contact Us');
    expect(titleFinder, findsOneWidget);
  });
}