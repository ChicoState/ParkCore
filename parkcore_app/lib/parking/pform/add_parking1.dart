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
import 'add_parking2.dart';

class AddParking1 extends StatefulWidget {
  AddParking1({Key key, this.title}) : super(key: key);
  // This widget is the 'add parking' page of the app. It is stateful: it has a
  // State object (defined below) that contains fields that affect how it looks.
  // This class is the configuration for the state. It holds the values (title)
  // provided by the parent (App widget) and used by the build method of the
  // State. Fields in a Widget subclass are always marked 'final'.

  final String title;

  @override
  _MyAddParking1State createState() => _MyAddParking1State();
}

class _MyAddParking1State extends State<AddParking1> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ParkingData parkingData = ParkingData(null, null, null, null, null, null, null, null);
  CurrentUser curUser = CurrentUser(null);
  FormError formError = FormError();
  final _stateData = [
    {'display': 'California', 'value': 'CA'},
  ];

  @override
  void initState() {
    super.initState();
    loadCurrentUser();
  }

  void loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        curUser.currentUser = user;
      });
    });
  }

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
              formError.incomplete || formError.invalidLoc
                ? Text(formError.errorMessage, style: TextStyle(color: Colors.red))
                : Text('Part 1 of 5'),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildAddress() + page1Button(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildAddress() {
    return [
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.green[50],
        ),
        child: Text(
          'Adding a parking space owned by: ' + getUserName(curUser.currentUser)
              + '\nRequired fields marked with *',
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(height: 20),
      getTitle(),
      SizedBox(height: 10),
      getAddress(),
      SizedBox(height: 10),
      getCity(),
      SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(
          color: formError.incomplete ? Colors.red[50] : Colors.green[50],
        ),
        child: getState(),
      ),
      SizedBox(height: 10),
      getZip(),
      SizedBox(height: 30),
    ];
  }

  // Page 1 Parking Form Widgets (title, full address)

  Widget getTitle() {
    return TextFormField(
      key: Key('title'),
      autofocus: true,
      validator: validateTitle,
      decoration: textFormFieldDeco(
          '* Enter a descriptive title for your parking space:'),
      onSaved: (value) {
        setState(() {
          parkingData.title = value;
        });
      },
    );
  }

  Widget getAddress() {
    return TextFormField(
      key: Key('address'),
      validator: validateAddress,
      decoration: textFormFieldDeco('* Street Address:'),
      onSaved: (value) {
        setState(() {
          parkingData.address = value;
        });
      },
    );
  }

  Widget getCity() {
    return TextFormField(
      key: Key('city'),
      validator: validateCity,
      decoration: textFormFieldDeco('* City:'),
      onSaved: (value) {
        setState(() {
          parkingData.city = value;
        });
      },
    );
  }

  Widget getState() {
    return DropDownFormField(
      titleText: 'State',
      hintText: '* Currently only available in California:',
      required: true,
      value: parkingData.state,
      onSaved: (value) {
        setState(() {
          formError.incomplete = false;
          parkingData.state = value;
        });
      },
      onChanged: (value) {
        setState(() {
          parkingData.state = value;
        });
      },
      dataSource: _stateData,
      textField: 'display',
      valueField: 'value',
    );
  }

  Widget getZip() {
    return TextFormField(
      key: Key('zip'),
      autofocus: true,
      validator: validateZip,
      decoration: textFormFieldDeco('* Zip Code:'),
      onSaved: (value) {
        setState(() {
          parkingData.zip = value;
        });
      },
    );
  }

  List<Widget> page1Button() {
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
                    'Next: Parking Space Info',
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

  // Form Validators

  String validateTitle(String value) {
    if (value.isEmpty) {
      return 'Field can\'t be empty';
    }
    if (value.length >= 25) {
      return 'Title cannot be more than 25 characters';
    }
    return null;
  }

  String validateAddress(String value) {
    if (value.isEmpty) {
      return 'Field can\'t be empty';
    }
    if (value.length >= 60) {
      return 'Address cannot be more than 60 characters';
    }
    return null;
  }

  String validateCity(String value) {
    if (value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  String validateZip(String value) {
    if (value.isEmpty) {
      return 'Field can\'t be empty';
    }
    if (value.length != 5) {
      return 'Enter your 5 digit zip code';
    }
    if (value.contains(' ')) {
      return 'Field can\'t contain spaces';
    }
    if(!RegExp('^[0-9]{5}\$').hasMatch(value)){
      return 'Enter a valid 5 digit US zip code';
    }
    return null;
  }

  // Validate form (page 1) - Check if state has been selected.
  // Then check if title, address, city, and zip are valid, and if so,
  // check if the geocoder returns a valid set of coordinates.
  // Otherwise, return appropriate error message.
  void validateAndSubmit() async {
    final form = _formKey.currentState;
    if (parkingData.state == null) {
      setState(() {
        formError.incomplete = true;
        formError.errorMessage = 'Make sure to select a state';
      });
    }

    if(form.validate()){
      validateGeo();
    }
    else{
      setState(() {
        formError.errorMessage = 'Make sure to fill out all required fields';
      });
    }
  }

  // Create coordinates associated with the given address (if possible)
  void validateGeo() async {
    try {
      _formKey.currentState.save();
      var _geoAddress = parkingData.address + ', ' + parkingData.city
          + ', ' + parkingData.zip;
      var addresses = await Geocoder.local.findAddressesFromQuery(_geoAddress);
      var first = addresses.first;
      parkingData.coordinates = first.coordinates.toString();
      parkingData.coord_rand = getRandomCoordinates(parkingData.coordinates);

      print(first.addressLine + ' : ' + first.coordinates.toString());
      print('random coordinates : ' + parkingData.coord_rand);
      var addr = first.addressLine.split(', ');

      setState(() {
        parkingData.city_format = addr[1];
        formError.invalidLoc = false;
      });
    }
    catch (e) {
      print('Error occurred: $e');
      setState(() {
        formError.invalidLoc = true;
        formError.errorMessage = 'We can\'t find you!\nPlease enter a valid location.';
      });
    }

    // if location was valid, confirm page 1 is complete, and go to next page
    if (!formError.invalidLoc) {
      if(validateAndSave()){
        goToNextPage();
      }
    }
  }

  //Confirm page 1 is complete, save the current state of the form, set UID
  bool validateAndSave() {
    if (formError.incomplete) {
      return false;
    }
    _formKey.currentState.save();
    parkingData.uid = getUserID(curUser.currentUser);
    return true;
  }

  // Navigate to page 2 of form (passing parkingData and curUser objects)
  void goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddParking2(
          title: widget.title,
          parkingData: parkingData,
          curUser: curUser,
        ),
      ),
    );
  }
}