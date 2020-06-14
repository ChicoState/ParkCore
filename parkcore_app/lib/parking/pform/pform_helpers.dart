import 'package:flutter/material.dart';
import 'package:parkcore_app/theme/style.dart';
import 'package:firebase_auth/firebase_auth.dart';

ThemeData themeData = appTheme();

InputDecoration textFormFieldDeco(String label) {
  return InputDecoration(
    labelText: label,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: themeData.backgroundColor,
        //color: Theme.of(context).backgroundColor,
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

//List<Widget> pageButton(String buttonText) {
//  return [
//    Row(
//      children: <Widget>[
//        Expanded(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: [
//              RaisedButton(
//                onPressed: () {
//                  validateAndSubmit;
//                },
//                child: Text(
//                  buttonText,
//                  style: themeData.textTheme.headline4,
//                ),
//                color: themeData.accentColor,
//              ),
//            ],
//          ),
//        ),
//      ],
//    ),
//  ];
//}

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


//class ParkingFormHelpers extends StatelessWidget {
//  ParkingFormHelpers({Key key}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: appTheme(),
//    );
//  }
//
//  InputDecoration textFormFieldDeco(String label) {
//    return InputDecoration(
//      labelText: label,
//      focusedBorder: OutlineInputBorder(
//        borderSide: BorderSide(
//          color: Theme.of(context).backgroundColor,
//        ),
//      ),
//    );
//  }
//}
