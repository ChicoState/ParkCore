import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('ParkCore Button', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final logoButtonFinder = find.byValueKey('logoButton');
    final homeAppTitleFinder = find.byValueKey('homeAppTitle');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('starts at main page', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(homeAppTitleFinder), "ParkCore");
    });

    test('click the logo button', () async {
      // First, tap the button.
      await driver.tap(logoButtonFinder);

      // Then, verify the counter text is incremented by 1.
      expect(await driver.getText(homeAppTitleFinder), "ParkCore");
    });
  });


//  test('test logo button tap in AppBar', () async {
//    FlutterDriver driver;
//    setUpAll(() async {
//      // Connects to the app
//      driver = await FlutterDriver.connect();
//    });
//    tearDownAll(() async {
//      if (driver != null) {
//        // Closes the connection
//        await driver.close();
//      }
//    });
//
//    final SerializableFinder drawerOpenButton = find.byTooltip('Open navigation menu');
//    final SerializableFinder btn = find.byValueKey('firstButton');
//
//    await driver.waitFor(drawerOpenButton);
//    await driver.tap(drawerOpenButton);
//    await driver.waitFor(btn);
//    await driver.tap(btn);
//    print('tapped');
//  });
}