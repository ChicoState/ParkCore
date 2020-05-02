import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/authenticate/login_fireship.dart';

void main() {
  testWidgets('Find Login Page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    // Find title
    final titleFinder = find.text('Parkcore');
    expect(titleFinder, findsOneWidget);
  });
}