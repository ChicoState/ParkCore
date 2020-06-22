import 'package:firebase_auth/firebase_auth.dart';

class CurrentUser {
  CurrentUser(
      this.currentUser,
      this.name,
      this.id,
  );

  FirebaseUser currentUser;
  String name;
  String id;

  Map<String, dynamic> toJson() => {
    'currentUser' : currentUser,
  };

  String getUserName() {
    if (currentUser != null) {
      return name;
    } else {
      return 'no current user';
    }
  }

  String getUserID() {
    if (currentUser != null) {
      return id;
    } else {
      return 'no current user';
    }
  }
}