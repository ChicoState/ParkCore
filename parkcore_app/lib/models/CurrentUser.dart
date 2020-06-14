import 'package:firebase_auth/firebase_auth.dart';

class CurrentUser {
  CurrentUser(
      this.currentUser,
  );

  FirebaseUser currentUser;

  Map<String, dynamic> toJson() => {
    'currentUser' : currentUser,
  };
}