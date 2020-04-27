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
        actions: <Widget>[
          LogoButton(),
        ],
      ),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
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
        color: Color(0xFF7E57C2),
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
