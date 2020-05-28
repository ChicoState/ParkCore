import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  //constructor 
  AuthService() {
    user = _auth.onAuthStateChanged;
    //user = Observable(_auth.onAuthStateChanged);

    profile = user.switchMap((FirebaseUser u) {
      if (u != null) {
        return _db
            .collection('users')
            .document(u.uid)
            .snapshots()
            .map((snap) => snap.data);
      } else {
        return Stream.value({});
        //return Observable.just({});
      }
    });
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Stream<FirebaseUser> user; //firebase user
  Stream<Map<String, dynamic>> profile;
  //Observable<FirebaseUser> user; //firebase user
  //Observable<Map<String, dynamic>> profile;
  PublishSubject loading = PublishSubject();

  Future<FirebaseUser> googleSignIn() async {
    loading.add(true);
    //GoogleSignInAccount
    var googleUser = await _googleSignIn.signIn();
    //GoogleSignInAuthentication
    var googleAuth = await googleUser.authentication;
    // AuthCredential
    final credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.idToken,
    );
    //FirebaseUser
    var user = (await _auth.signInWithCredential(credential)).user;

    updateUserData(user);
    print('signed in ' + user.displayName);
    loading.add(false);
    return user;
  }

  void updateUserData(FirebaseUser user) async {
    //DocumentReference
    var ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  void signOut() {
    _auth.signOut();
  }
}

final AuthService authService = AuthService();
