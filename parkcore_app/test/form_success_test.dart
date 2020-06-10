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

  testWidgets(
      'Form success find 3 Image Icon Buttons', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FormSuccess(),
    ));

    expect(find.byType(IconButton), findsNWidgets(3));
  });

  testWidgets(
      'Form success gets icon button on click', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FormSuccess(),
    ));

    final showThanks = find.byKey(Key('acornButton'));

    // Tap the acorn icon and trigger a snackbar with a message
    await tester.tap(showThanks);
    await tester.pump();

    expect(find.text('Thank you!'), findsOneWidget);
  });
}
