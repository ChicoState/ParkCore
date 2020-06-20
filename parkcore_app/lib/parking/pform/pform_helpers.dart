import 'package:flutter/material.dart';
import 'package:parkcore_app/theme/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parkcore_app/navigate/parkcore_button.dart';

// Methods and class that are used by parking form pages
ThemeData themeData = appTheme();

// Consistent AppBar for all pages of parking form
AppBar parkingFormAppBar(){
  return AppBar(
    title: Text('Post Your Parking Space'),
    centerTitle: true,
    backgroundColor: themeData.backgroundColor,
    actions: <Widget>[
      LogoButton(),
    ],
  );
}

// Consistent decoration for text form field input
InputDecoration textFormFieldDeco(String label) {
  return InputDecoration(
    labelText: label,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: themeData.backgroundColor,
      ),
    ),
  );
}

String getUserName(FirebaseUser user) {
  if (user != null) {
    return user.displayName;
  } else {
    return 'no current user';
  }
}

String getUserID(FirebaseUser user) {
  if (user != null) {
    return user.uid;
  } else {
    return 'no current user';
  }
}

// Button to restart form
Widget restart(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      RaisedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/add_parking1');
        },
        child: Text(
          'Restart Form',
          style: Theme.of(context).textTheme.headline4,
        ),
        color: Theme.of(context).backgroundColor,
      ),
    ],
  );
}

// Errors in the form may be marked incomplete or invalid; if so, an error
// message is set and shown to the user when they click the 'Next' button
class FormError {
  bool _incomplete = false;
  bool _invalidLoc = false;
  String _errorMessage = '';

  bool get incomplete => _incomplete;
  set incomplete(bool incomplete) => _incomplete = incomplete;

  bool get invalidLoc => _invalidLoc;
  set invalidLoc(bool invalidLoc) => _invalidLoc = invalidLoc;

  String get errorMessage => _errorMessage;
  set errorMessage(String errorMessage) => _errorMessage = errorMessage;
}
