import 'package:flutter/material.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parkcore_app/navigate/parkcore_button.dart';
import 'package:parkcore_app/screens/parkcore_text.dart';

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
  //int _counter = 0;

  void _incrementCounter() {
//     setState(() {
//       // Call to setState tells Flutter framework that something has changed in
//       // this State. Then the build method is rerun so that the display can
//       // reflect the updated values. If we changed _counter without calling
//       // setState(), then the build method would not be called again, and so
//       // nothing would appear to happen.
//       _counter++;
//     });

    Firestore.instance.runTransaction((transaction) async {
      DocumentSnapshot freshSnap = await Firestore.instance
          .collection('test')
          .document('IpejvjqCkEsjvHGp71xk')
          .get();
      await transaction.update(freshSnap.reference, {
        'count': freshSnap['count'] + 1,
      });
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
        backgroundColor: Theme.of(context).backgroundColor,
        actions: <Widget>[LogoButton()],
      ),
      drawer: MenuDrawer(),
      body: Center(
        child: ParkCoreText(),
      )
//        child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Text(
//                'ParkCore',
//                style: Theme.of(context).textTheme.headline,
//              ),
//              Text(
//                'find a spot. go nuts.',
//                style: Theme.of(context).textTheme.display1,
//              ),
//              SizedBox(height: 10),
//              Container(
//                margin: const EdgeInsets.all(20.0),
//                padding: const EdgeInsets.all(20.0),
//                decoration: const BoxDecoration(
//                  border: Border(
//                    top: BorderSide(width: 2.0, color: Color(0xFF99F1B8)),
//                    left: BorderSide(width: 2.0, color: Color(0xFF99F1B8)),
//                    right: BorderSide(width: 2.0, color: Color(0xFF358D5B)),
//                    bottom: BorderSide(width: 2.0, color: Color(0xFF358D5B)),
//                  ),
//                ),
//                child: Text(
//                  'ParkCore is a parking application that allows local property '
//                  'owners around the Chico State campus to earn a little money '
//                  'through the rental of their driveway to students, faculty, '
//                  'and staff.',
//                  style: Theme.of(context).textTheme.display2,
//                  textAlign: TextAlign.center,
//                ),
//              ),
//              Text('You have pushed the button this many times:'),
//              StreamBuilder(
//                  stream: Firestore.instance.collection('test').snapshots(),
//                  builder: (context, snapshot) {
//                    if (!snapshot.hasData) {
//                      return Text('Loading Clicks...',
//                          style: Theme.of(context).textTheme.display1);
//                    }
//                    return Text(snapshot.data.documents[0]['count'].toString(),
//                        style: Theme.of(context).textTheme.display1);
//                  })

//               Text(
//                 '$_counter',
//                 style: Theme.of(context).textTheme.display2,
//               ),
 //           ]),
 //     ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//        backgroundColor: Theme.of(context).backgroundColor,
//      ),
    );
  }
}
