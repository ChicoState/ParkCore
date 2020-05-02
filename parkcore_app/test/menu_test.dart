import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';

void main() {
  testWidgets('Find Menu Drawer Logo', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MenuDrawer(),
    ));

    expect(find.bySemanticsLabel('ParkCore Logo'), findsOneWidget);
  });
}