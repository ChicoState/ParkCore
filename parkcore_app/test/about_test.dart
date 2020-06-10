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

//  testWidgets('Find About Us Page', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(MaterialApp(
//      home: About(),
//    ));
//    String about_us_short = '';
//
//    Future<String> short_text;
//    await tester.pumpWidget(Builder(
//      builder: (BuildContext context) {
//        return StatefulBuilder(
//          builder: (BuildContext context, StateSetter setState) {
//            return GestureDetector(
//              onTap: () {
//                short_text = About().createState().loadAboutUsShort();
//                setState(() {
//                  about_us_short = short_text as String;
//                });
//              },
//            );
//          }
//        );
//      }
//    ));
//
//    // Find title
//    expect(about_us_short, short_text);
//  });
}
