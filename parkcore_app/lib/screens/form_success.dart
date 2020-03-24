import 'package:flutter/material.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';

class FormSuccess extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget showSnackBar(){
    return IconButton(
      icon: Icon(Icons.cake),
      onPressed: () {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            'Thank you!',
            style: TextStyle(
              color: Colors.orange[200],
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
      ),
      drawer: MenuDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                  'assets/parkcore_logo_orange2.jpg',
                  // width: 300,
                  height: 200,
                  fit:BoxFit.fill
              ),
            ),
            SizedBox(height: 10),
            Text(
              'ParkCore',
              style: Theme.of(context).textTheme.headline,
            ),
            Text(
              'find a spot. go nuts.',
              style: Theme.of(context).textTheme.display1,
            ),
            SizedBox(height: 10),
            showSnackBar(),
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                  'assets/parkcore_logo_green2.jpg',
                  // width: 300,
                  height: 200,
                  fit:BoxFit.fill
              ),
            ),
          ],
        )
      ),
    );
  }
}