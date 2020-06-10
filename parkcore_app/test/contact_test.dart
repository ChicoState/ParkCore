import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/screens/contact.dart';
import 'package:parkcore_app/screens/home.dart';

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

  testWidgets('Find logo button on Contact Page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: ContactUs(),
    ));

    // Find title
    final buttonFinder = find.byKey(Key('logoButton'));
    expect(buttonFinder, findsOneWidget);
  });

  testWidgets('Tap logo button to navigate from Contact to Home page',
          (WidgetTester tester) async {
    // Build our app and trigger a frame.

    final routes = <String, WidgetBuilder>{
      '/home' : (BuildContext context) => MyHomePage(title: 'ParkCore'),
    };

    await tester.pumpWidget(MaterialApp(
      home: ContactUs(),
      initialRoute: '/',
      routes: routes,
    ));

    // Find logoButton
    final buttonFinder = find.byKey(Key('logoButton'));
    expect(buttonFinder, findsOneWidget);
    // Tap logoButton
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();
    // Expect to navigate home
    expect(find.byKey(Key('homeAppTitle')), findsOneWidget);
  });
}