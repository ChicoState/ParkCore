import 'package:flutter/material.dart';
import 'package:parkcore_app/theme/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parkcore_app/navigate/parkcore_button.dart';

ThemeData themeData = appTheme();

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
