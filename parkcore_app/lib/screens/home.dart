import 'package:flutter/material.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parkcore_app/navigate/parkcore_button.dart';
import 'package:parkcore_app/screens/parkcore_text.dart';
import 'package:geocoder/geocoder.dart';
import 'package:parkcore_app/parking/find_parking.dart';


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
  final _searchKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();

  String _input = "none";
  String _loc = "";
  String _city = "";
  String _coordinates = "";
  bool _found = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        actions: <Widget>[LogoButton()],
      ),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: Column(
              children: <Widget>[
                Form(
                  key: _searchKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: SearchBar(),
                  ),
                ),
                SizedBox(height: 10),
                _input == "none" ? Text("") : SearchReturn(),
                SizedBox(height: 50),
                ParkCoreText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Search Bar includes Search By Location field and Search Button
  List<Widget> SearchBar() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: Column(
              children: [
                SearchField(),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Column(
              children: [
                SearchButton(),
              ],
            ),
          ),
        ],
      ),
    ];
  }

  // Search By Location field
  Widget SearchField() {
    return TextFormField(
      autofocus: true,
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search by location',
        hintStyle: TextStyle(
          fontSize: 18.0,
          color: Theme.of(context).backgroundColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }

  // Search By Location Button
  Widget SearchButton() {
    return Ink(
      padding: EdgeInsets.all(3.0),
      decoration: const ShapeDecoration(
        color: Color(0xFF4D2C91),
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: Icon(
          Icons.search,
          size: 35.0,
        ),
        color: Colors.white,
        tooltip: 'Search for parking space locations',
        onPressed: () {
          submitSearch(_searchController.text);
        },
      ),
    );
  }

  // When Search Button is clicked, try to find a location (set of coordinates)
  void submitSearch(String search) async {
    try {
      validateLocation();
      setState(() {
        _input = "Find parking near: " + search;
      });
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  // Show Search Results
  Widget SearchReturn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("$_input"),
        SizedBox(height: 10.0),
        Divider(
          color: Colors.black,
          height: 20,
        ),
        _found ? FoundResults() : FailedSearch(),
        Divider(
          color: Colors.black,
          height: 20,
        ),
      ],
    );
  }

  // If Search was successful, show the location that was found
  Widget FoundResults() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 5,
          fit: FlexFit.tight,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  _loc,
                  style: Theme.of(context).textTheme.display2,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Column(
            children: [
              RaisedButton(
                child: Text("Go!"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FindParking(
                        title: 'Find Parking',
                        city: _city,
                        latlong: _coordinates == null ?
                        '{39.7285,-121.8375}' : _coordinates,
                      ),
                    ),
                  );
                },
                color: Theme.of(context).backgroundColor,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // If Search was not successful, show error message
  Widget FailedSearch() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        _loc,
        style: Theme.of(context).textTheme.display2,
      ),
    );
  }

  // Use geocoder to search for a location that matches search result input
  void validateLocation() async {
    try {
      var addresses =
      await Geocoder.local.findAddressesFromQuery(_searchController.text);
      var first = addresses.first;
      var addr = first.addressLine.split(", ");

      print(first.addressLine + " : " + first.coordinates.toString());

      setState(() {
        _found = true;
        // geocoder has different results depending on details given
        if(addr.length <= 3){
          _city = addr[0];  // when addr is: city, state, country
        }
        else{
          _city = addr[1]; // when addr is: address, city, state, country
        }
        _loc = "${first.addressLine}";
        _coordinates = first.coordinates.toString();
      });
    }
    catch (e) {
      print("Error occurred: $e");
      setState(() {
        _found = false;
        _loc = "Sorry, no search results for '" + _searchController.text + "'.";
      });
    }
  }

}




//class _MyHomePageState extends State<MyHomePage> {
//  //int _counter = 0;
//
//  void _incrementCounter() {
////     setState(() {
////       // Call to setState tells Flutter framework that something has changed in
////       // this State. Then the build method is rerun so that the display can
////       // reflect the updated values. If we changed _counter without calling
////       // setState(), then the build method would not be called again, and so
////       // nothing would appear to happen.
////       _counter++;
////     });
//
//    Firestore.instance.runTransaction((transaction) async {
//      DocumentSnapshot freshSnap = await Firestore.instance
//          .collection('test')
//          .document('IpejvjqCkEsjvHGp71xk')
//          .get();
//      await transaction.update(freshSnap.reference, {
//        'count': freshSnap['count'] + 1,
//      });
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // build(): rerun every time setState is called (e.g. for_incrementCounter)
//    // Rebuild anything that needs updating instead of having to individually
//    // change instances of widgets.
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//        centerTitle: true,
//        backgroundColor: Theme.of(context).backgroundColor,
//        actions: <Widget>[LogoButton()],
//      ),
//      drawer: MenuDrawer(),
//      body: Center(
//        child: ParkCoreText(),
//    )
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
//    );
//  }
//}
