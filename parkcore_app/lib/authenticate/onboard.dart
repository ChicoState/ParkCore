import 'package:flutter/material.dart';

class OnBoard extends StatefulWidget {
  OnBoard({Key key, this.title}) : super(key: key);
  // This widget is the "onboarding" page of the app. It is stateful: it has a
  // State object (defined below) that contains fields that affect how it looks.
  // This class is the configuration for the state. It holds the values (title)
  // provided by the parent (App widget) and used by the build method of the
  // State. Fields in a Widget subclass are always marked "final".

  final String title;

  @override
  _MyOnBoardState createState() => _MyOnBoardState();
}

class _MyOnBoardState extends State<OnBoard> {

  @override
  Widget build(BuildContext context) {
    // build(): rerun every time setState is called (e.g. for stateful methods)
    // Rebuild anything that needs updating instead of having to individually
    // change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: new Icon(Icons.close),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to ParkCore!',
                style: Theme.of(context).textTheme.display1,
              ),
            ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/home');
        },
        child: Icon(Icons.home),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}