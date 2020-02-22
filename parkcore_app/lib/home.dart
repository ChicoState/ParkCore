import 'package:flutter/material.dart';
import 'package:parkcore_app/style.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful: it has a
  // State object (defined below) that contains fields that affect how it looks.
  // This class is the configuration for the state. It holds the values (title)
  // provided by the parent (App widget) and used by the build method of the
  // State. Fields in a Widget subclass are always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // Call to setState tells Flutter framework that something has changed in
      // this State. Then the build method is rerun so that the display can
      // reflect the updated values. If we changed _counter without calling
      // setState(), then the build method would not be called again, and so
      // nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // build(): rerun every time setState is called (e.g. for_incrementCounter)
    // Rebuild anything that needs updating instead of having to individually
    // change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.green[900],
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              title: Text('Add Parking'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Update the state of the app.
                // ...
                // Then close the drawer.
                Navigator.pushNamed(context, '/add_parking');
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Find Parking'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Update the state of the app.
                // ...
                // Then close the drawer.
                Navigator.pushNamed(context, '/find_parking');
               // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: TextStyle(
                  color: Colors.green[900],
                ),
              ),
            ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Colors.green[700],
      ),
    );
  }
}