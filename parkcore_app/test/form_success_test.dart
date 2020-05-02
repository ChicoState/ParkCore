import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/screens/form_success.dart';

void main() {
  testWidgets('Find Form Success Page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FormSuccess(),
    ));

    // Find title
    final titleFinder = find.text('Form Submitted. Success!');
    expect(titleFinder, findsOneWidget);
  });
}