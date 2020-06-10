import 'package:flutter/material.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:parkcore_app/navigate/parkcore_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormSuccess extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget showSnackBar(){
    return IconButton(
      key: Key('acornButton'),
      icon: SvgPicture.asset(
        'assets/Acorns.svg',
        fit: BoxFit.fitWidth,
        semanticsLabel: 'Acorns image',
      ),
      iconSize: 100.0,
      onPressed: () {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            'Thank you!',
            style: TextStyle(
              color: Color(0xFFB085F5),
              fontSize: 20,
            ),
          ),
          duration: Duration(seconds: 5),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Form Submitted. Success!'),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        actions: <Widget>[
          LogoButton(),
        ],
      ),
      drawer: MenuDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.asset(
                  'assets/parkcore_logo_green2.jpg',
                  height: 120,
                  fit:BoxFit.fill,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                'PARKCORE',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                'find a spot. go nuts.',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: showSnackBar(),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                'thank you for joining the scurry!',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.asset(
                  'assets/parkcore_logo_green2.jpg',
                  height: 120,
                  fit:BoxFit.fill,
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}