import 'package:flutter/material.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:parkcore_app/models/ParkingData.dart';
import 'package:parkcore_app/models/CurrentUser.dart';
import 'package:parkcore_app/navigate/parkcore_button.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoder/geocoder.dart';
import 'package:parkcore_app/parking/random_coordinates.dart';
import 'pform_helpers.dart';

class AddParking2 extends StatefulWidget {
  AddParking2({Key key, this.title, this.parkingData, this.curUser}) : super(key: key);

  // This widget is the 'add parking' page of the app. It is stateful: it has a
  // State object (defined below) that contains fields that affect how it looks.
  // This class is the configuration for the state. It holds the values (title)
  // provided by the parent (App widget) and used by the build method of the
  // State. Fields in a Widget subclass are always marked 'final'.

  final String title;
  final ParkingData parkingData;
  final CurrentUser curUser;

  @override
  _MyAddParking2State createState() => _MyAddParking2State();
}

class _MyAddParking2State extends State<AddParking2> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
//  ParkingData parkingData = ParkingData(
//    null, null, null, null, null, null, null, null, null, null, null,
//    null, null, null, null, null, null, null, null, null, null,
//  );
 // CurrentUser curUser = CurrentUser(null);
  FormError formError = FormError();

  @override
  void initState() {
    super.initState();
    //loadCurrentUser();
  }

//  void loadCurrentUser() {
//    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
//      setState(() {
//        curUser.currentUser = user;
//      });
//    });
//  }
//
//  String getUserName() {
//    if (curUser.currentUser != null) {
//      return curUser.currentUser.displayName;
//    } else {
//      return 'no current user';
//    }
//  }

  @override
  Widget build(BuildContext context) {
    // build(): rerun every time setState is called (e.g. for stateful methods)
    // Rebuild anything that needs updating instead of having to individually
    // change instances of widgets.
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      key: _scaffoldKey,
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//              formError.incomplete || formError.invalidLoc
//                  ? Text(formError.errorMessage, style: TextStyle(color: Colors.red))
//                  : Text('Part ' + pageNum.page.toString() + ' of 5'),
              Text('Part 2 of 5'),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: review() + page2Button(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> review() {
    return [
      Text(
        'Review your information:',
        style: Theme.of(context).textTheme.headline3,
      ),
      SizedBox(height: 10),
      Text('Title: ' + widget.parkingData.title),
      Text('Address: ' + widget.parkingData.address),
      Text('City: ' + widget.parkingData.city_format),
      Text('State: ' + widget.parkingData.state),
      Text('Zip: ' + widget.parkingData.zip),
//      Text('Size: ' + widget.parkingData.size),
//      Text('Type: ' + widget.parkingData.type),
//      Text('Driveway: ' + widget.parkingData.driveway),
//      Text('Space Type: ' + widget.parkingData.spaceType),
//      Text('Amenities: ' + widget.parkingData.myAmenities.toString()),
//      Text('Additional Details: ' + widget.parkingData.details),
//      Text('Days Available: ' + widget.parkingData.myDays.toString()),
//      Text('Available Starting at: ' + widget.parkingData.startTime),
//      Text('Available Until: ' + widget.parkingData.endTime),
//      Text('Price per month: \$' + widget.parkingData.price),
      SizedBox(height: 10),
      Text('Additional info connected to this parking space:'),
      Text('Parking Space Owner: ' + getUserName(widget.curUser.currentUser)),
      Text('Parking Space Coordinates: ' + widget.parkingData.coordinates),
      SizedBox(height: 10),
      //restart(),
      SizedBox(height: 50),
    ];
  }

  // Page 1 Parking Form Widgets (title, full address)


  List<Widget> page2Button() {
    return [
      Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: validateAndSubmit,
                  child: Text(
                    'Next',
                    style: themeData.textTheme.headline4,
                  ),
                  color: themeData.accentColor,
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }


  void validateAndSubmit() async {
  // check additional validators
    if(!validateAndSave()){
      setState(() {
        formError.errorMessage = 'Make sure to fill out all required fields';
        print(formError.errorMessage);
      });
    }
  }

  // Check individual form validators, go to next page
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (formError.incomplete) {
        return false;
      }
      Navigator.pushReplacementNamed(context, '/parking3');
      return true;
    }
    return false;
  }
}