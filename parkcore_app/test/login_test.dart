import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/authenticate/login_fireship.dart';
import 'package:parkcore_app/screens/home.dart';

void main() {
  testWidgets('Find Login Page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    // Find title
    final titleFinder = find.text('PARKCORE');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Find home button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    // Find home button
    final homeFinder = find.widgetWithIcon(FloatingActionButton, Icons.home);
    expect(homeFinder, findsOneWidget);
  });

  testWidgets('Tap button to go to home page', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    final routes = <String, WidgetBuilder>{
      '/home' : (BuildContext context) => MyHomePage(title: 'ParkCore'),
    };

    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
      initialRoute: '/',
      routes: routes,
    ));

    // Find home Button
    final buttonFinder = find.widgetWithIcon(FloatingActionButton, Icons.home);
    await tester.tap(buttonFinder);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    final titleFinder = find.text('ParkCore');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Find material buttons', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    // Find material buttons (for login & logout)
    expect(find.byType(MaterialButton), findsNWidgets(2));
  });
}