import 'package:flutter/material.dart';
import 'auth_fireship.dart';
import 'package:parkcore_app/navigate/parkcore_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ParkCore Login',
        home: Scaffold(
            appBar: AppBar(
              title: Text('PARKCORE'),
              centerTitle: true,
              backgroundColor: Theme.of(context).backgroundColor,
              actions: <Widget>[
                LogoButton(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Icon(Icons.home),
              backgroundColor: Theme.of(context).backgroundColor,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () => authService.googleSignIn(),
//                    color: Colors.white,
//                    textColor: Colors.black,
                      color: Color(0xFF358D5B),
                      child: Text(
                        'Login with Google',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () => authService.signOut(),
//                    color: Colors.red,
//                    textColor: Colors.black,
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Sign out',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    UserProfile(),
                  ],
                ),
              ),
            ),
        ),
    );
  }
}

class UserProfile extends StatefulWidget {
  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  Map<String, dynamic> _profile;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    authService.profile.listen((state) => setState(() => _profile = state));
    authService.loading.listen((state) => setState(() => _loading = state));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          //child: Text(_profile.toString()),
          child: _profile != null && _profile.isNotEmpty ? showProfile(_profile)
            : _loading ? LinearProgressIndicator() : showImage(),
        ),
        //Text(_loading.toString()),
      ],
    );
  }
}

Widget showProfile(Map<String, dynamic> _profile){
  return Column(
    key: Key('showprofile'),
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text(
        'Welcome, ' + _profile['displayName'] + '!',
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      SizedBox(height: 10.0),
      Text('uid: ' + _profile['uid']),
      Text('email: ' + _profile['email']),
      Text('last seen: ' +
        DateTime.fromMillisecondsSinceEpoch(
          _profile['lastSeen'].seconds * 1000,
        ).toString(),
      ),
      Text('rating: ' + _profile['rating'].toString()),
      SizedBox(height: 10.0),
      showImage(),
    ],
  );
}

Widget showImage(){
  return ClipRRect(
    key: Key('acornImage'),
    borderRadius: BorderRadius.circular(50.0),
    child: Opacity(
      opacity: 0.4,
      child: SvgPicture.asset(
        'assets/Acorns.svg',
        height: 80,
        fit: BoxFit.cover,
        semanticsLabel: 'Acorns image',
      ),
    ),
  );
}

//class LoginButton extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return StreamBuilder(
//        stream: authService.user,
//        builder: (context, snapshot) {
//          if (snapshot.hasData) {
//            return MaterialButton(
//              onPressed: () => authService.signOut(),
//              color: Colors.red,
//              textColor: Colors.white,
//              child: Text('Sign out'),
//            );
//          } else {
//            return MaterialButton(
//              onPressed: () => authService.googleSignIn(),
//              color: Colors.white,
//              textColor: Colors.black,
//              child: Text('Login with Google'),
//            );
//          }
//        });
//  }
//}
