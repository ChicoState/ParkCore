import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/authenticate/login_fireship.dart';
import 'package:parkcore_app/authenticate/auth_fireship.dart';
import 'package:parkcore_app/screens/home.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  testWidgets('check update user database', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    // Mock sign in with Google.
    final googleSignIn = MockGoogleSignIn();
    final signinAccount = await googleSignIn.signIn();
    final googleAuth = await signinAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Sign in.
    final auth = MockFirebaseAuth();
    final result = await auth.signInWithCredential(credential);
    final user = await result.user;
    AuthService().updateUserData(user);
    // Find title
    final titleFinder = find.text('PARKCORE');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('check update user database', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    // Mock sign in with Google.
    final googleSignIn = MockGoogleSignIn();
    final signinAccount = await googleSignIn.signIn();
    final googleAuth = await signinAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Sign in.
    final auth = MockFirebaseAuth();
    final result = await auth.signInWithCredential(credential);
    final user = await result.user;
    expect(user.displayName, equals('Bob'));
    AuthService().signOut();
    // Find title
    expect(find.text('PARKCORE'), findsOneWidget);
  });

  testWidgets('Find login button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    // Find material buttons (for login & logout)
//    final login = find.widgetWithText(MaterialButton, 'Login with Google');
//    await tester.tap(login);
//    await tester.pump();
   // await tester.pump(const Duration(milliseconds: 10));

    expect(find.widgetWithText(MaterialButton, 'Login with Google'), findsOneWidget);
  });

  testWidgets('Find sign out button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    expect(find.widgetWithText(MaterialButton, 'Sign out'), findsOneWidget);
  });

  testWidgets('Tap sign out button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    // Find material buttons (for login & logout)
    final signout = find.widgetWithText(MaterialButton, 'Sign out');
    await tester.tap(signout);
    await tester.pump();

    expect(find.widgetWithText(MaterialButton, 'Login with Google'), findsOneWidget);
  });

//  testWidgets('Tap login button', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(MaterialApp(
//      home: LoginPage(),
//    ));
//
//    // Find material buttons (for login & logout)
//    final signout = find.widgetWithText(MaterialButton, 'Sign out');
//    await tester.tap(signout);
//    await tester.pump();
//    await tester.pump(const Duration(milliseconds: 10));
//    final login = find.widgetWithText(MaterialButton, 'Login with Google');
//    await tester.tap(login);
//    await tester.pump();
//    expect(find.widgetWithText(MaterialButton, 'Sign out'), findsOneWidget);
//  });
}