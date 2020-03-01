import 'package:flutter/material.dart';
import 'package:parkcore_app/menu_drawer.dart';

class FindParking extends StatefulWidget {
  FindParking({Key key, this.title}) : super(key: key);
  // This widget is the "find parking" page of the app. It is stateful: it has a
  // State object (defined below) that contains fields that affect how it looks.
  // This class is the configuration for the state. It holds the values (title)
  // provided by the parent (App widget) and used by the build method of the
  // State. Fields in a Widget subclass are always marked "final".

  final String title;

  @override
  _MyFindParkingState createState() => _MyFindParkingState();
}

class _MyFindParkingState extends State<FindParking> {

  @override
  Widget build(BuildContext context) {
    // build(): rerun every time setState is called (e.g. for stateful methods)
    // Rebuild anything that needs updating instead of having to individually
    // change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      drawer: MenuDrawer(),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Find Parking',
                style: Theme.of(context).textTheme.display1,
              ),
            ]
        ),
      ),
    );
  }
}