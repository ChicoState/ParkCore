// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:parkcore_app/screens/home.dart';

//void main() {
//  testWidgets('MyHomePage has a title', (WidgetTester tester) async {
//    // Create the widget by telling the tester to build it.
//    await tester.pumpWidget(MyHomePage());
//    // Use the `findsOneWidget` matcher provided by flutter_test to verify
//    // that the Text widgets appear exactly once in the widget tree.
//    final titleFinder = find.text('ParkCore');
//    expect(titleFinder, findsOneWidget);
//  });
//}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(title: "title"),
    ));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
