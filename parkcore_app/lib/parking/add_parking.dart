//import 'dart:html';
//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';


class AddParking extends StatefulWidget {
  AddParking({Key key, this.title}) : super(key: key);
  // This widget is the "add parking" page of the app. It is stateful: it has a
  // State object (defined below) that contains fields that affect how it looks.
  // This class is the configuration for the state. It holds the values (title)
  // provided by the parent (App widget) and used by the build method of the
  // State. Fields in a Widget subclass are always marked "final".

  final String title;

  @override
  _MyAddParkingState createState() => _MyAddParkingState();
}

class _MyAddParkingState extends State<AddParking> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  // Note: This is a `GlobalKey<FormState>`, not GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int _page = 1;
  int _tmp_type = 0;
  int _size;
  int _type;
  int _driveway;
  int _spaceType;


  Map<String, dynamic> _myData = {
    "_title": null,
    "_address": null,
    "_city": null,
    "_state": null,
    "_zip": null,
  };
//    "_size": 0,
//    "_type": 0,
//    "_driveway": 0,
//    //"_streetParking": 0,
//    "_spaceType": 0,
//  };

  final _stateData = [
    {"display": "California", "value": "CA"},
  ];

  final _sizeData = [
    {"display": "Compact", "value": 0},
    {"display": "Regular", "value": 1},
    {"display": "Oversized", "value": 2},
  ];

  final _typeData = [
    {"display": "Driveway", "value": 0},
    {"display": "In a Parking Lot", "value": 1},
    {"display": "On the Street", "value": 2},
  ];

  final _drivewayData = [
    {"display": "N/A", "value": 0},
    {"display": "Left side", "value": 1},
    {"display": "Right side", "value": 2},
    {"display": "Center", "value": 3},
    {"display": "Whole Driveway", "value": 4},
  ];

//  final _streetParkingData = [
//    {"display": "N/A", "value": 0},
//    {"display": "In a Parking Lot", "value": 1},
//    {"display": "On the Street", "value": 2},
//  ];

  final _parkingSpaceTypeData = [
    {"display": "N/A", "value": 0},
    {"display": "Angled", "value": 1},
    {"display": "Parallel", "value": 2},
    {"display": "Perpendicular", "value": 3},
  ];



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
      ),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget> [
//                _title == null ?
//                Text('Post Your Parking Space',
//                  style: Theme.of(context).textTheme.display1,
//                )
//                :Text('$_title $_city',
//                  style: Theme.of(context).textTheme.display1,
//                ),
                SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: formPages(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> formPages() {
    if(_page == 1){
      return buildAddress() + pageButton('Next: Parking Space Info');
    }
    else if(_page == 2){
//      return buildParkingType() + addParkingSpaceInfo()
      return buildParkingType()
        + goBack() + pageButton('Next');
    }
    else{
      return review() + pageButton('Submit');
    }
  }

  List<Widget> buildAddress() {
    return [
      TextFormField(
        key: Key('title'),
        autofocus: true,
        validator: validateTitle,
        decoration: InputDecoration(
          labelText: 'Enter a descriptive title for your parking space:',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.lightGreen
            ),
          ),
        ),
        onSaved: (value) {
          setState(() {
            _myData["_title"] = value;
          });
        },
      ),
      SizedBox(height: 10),
      TextFormField(
        key: Key('address'),
        validator: validateAddress,
        decoration: InputDecoration(
          labelText: 'Street Address:',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.lightGreen
            ),
          ),
        ),
        onSaved: (value) {
          setState(() {
            _myData["_address"] = value;
          });
        },
      ),
      SizedBox(height: 10),
      TextFormField(
        key: Key('city'),
        validator: validateCity,
        decoration: InputDecoration(
          labelText: 'City:',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.lightGreen
            ),
          ),
        ),
        onSaved: (value) {
          setState(() {
            _myData["_city"] = value;
          });
        },
      ),
      SizedBox(height: 10),
      DropDownFormField(
        titleText: 'State',
        hintText: 'Currently only available in California:',
        //value: _state,
        value: _myData["_state"],
        onSaved: (value) {
          setState(() {
            //_state = value;
            _myData["_state"] = value;
          });
        },
        onChanged: (value) {
          setState(() {
            //_state = value;
            _myData["_state"] = value;
          });
        },
        dataSource: _stateData,
        textField: 'display',
        valueField: 'value',
      ),
      SizedBox(height: 10),
      TextFormField(
        key: Key('zip'),
        autofocus: true,
        validator: validateZip,
        decoration: InputDecoration(
          labelText: 'Zip Code:',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.lightGreen
            ),
          ),
        ),
        onSaved: (value) {
          setState(() {
            _myData["_zip"] = value;
          });
        },
      ),
    ];
  }

  List<Widget> buildParkingType() {
    return[
      SizedBox(height: 10),
      DropDownFormField(
        titleText: 'Parking Space Size',
        hintText: 'Select one:',
        value: _size,
       // value: _myData["_size"],
        onSaved: (value) {
          setState(() {
           // _myData["_size"] = value;
            _size = value;
          });
        },
        onChanged: (value) {
          setState(() {
           // _myData["_size"] = value;
            _size = value;

          });
        },
        dataSource: _sizeData,
        textField: 'display',
        valueField: 'value',
      ),
      SizedBox(height: 10),
      DropDownFormField(
        titleText: 'Type of Parking Space',
        hintText: 'Select one:',
        value: _type,
       // value: _myData["_type"],
        onSaved: (value) {
          setState(() {
            //_myData["_type"] = value;
            _type = value;
          });
        },
        onChanged: (value) {
          setState(() {
           // _myData["_type"] = value;
            _type = value;
          });
        },
        dataSource: _typeData,
        textField: 'display',
        valueField: 'value',
      ),
      SizedBox(height: 10),
      _type == 0 ?
      DropDownFormField(
        titleText: 'Driveway Parking Space',
        hintText: 'Select one:',
        //value: _myData["_driveway"],
        value: _driveway,
        onSaved: (value) {
          setState(() {
            _driveway = value;
            _spaceType = 0;
//            _myData["_driveway"] = value;
//            _myData["_spaceType"] = 0;
          });
        },
        onChanged: (value) {
          setState(() {
            _driveway = value;
            _spaceType = 0;
//            _myData["_driveway"] = value;
//            _myData["_spaceType"] = 0;
          });
        },
        dataSource: _drivewayData,
        textField: 'display',
        valueField: 'value',
      )
      :DropDownFormField(
        titleText: 'Additional Parking Info',
        hintText: 'Select one:',
        //value: _myData["_spaceType"],
        value: _spaceType,
        onSaved: (value) {
          setState(() {
            _spaceType = value;
            _driveway = 0;
//            _myData["_driveway"] = 0;
//            _myData["_spaceType"] = value;
          });
        },
        onChanged: (value) {
          setState(() {
            _spaceType = value;
            _driveway = 0;
//            _myData["_driveway"] = 0;
//            _myData["_spaceType"] = value;
          });
        },
        dataSource: _parkingSpaceTypeData,
        textField: 'display',
        valueField: 'value',
      ),
      //addParkingSpaceInfo(),
    ];
  }

 // List<Widget> addParkingSpaceInfo() {
//  Widget addParkingSpaceInfo() {
//    if(_myData["_type"] == 0){
//      return DropDownFormField(
//        titleText: 'Driveway Parking Space',
//        hintText: 'Select one:',
//        value: _myData["_driveway"],
//        onSaved: (value) {
//          setState(() {
//            _myData["_driveway"] = value;
//          });
//        },
//        onChanged: (value) {
//          setState(() {
//            _myData["_driveway"] = value;
//          });
//        },
//        dataSource: _drivewayData,
//        textField: 'display',
//        valueField: 'value',
//      );
//    }
//    else{
//      return DropDownFormField(
//        titleText: 'Additional Parking Info',
//        hintText: 'Select one:',
//        value: _myData["_spaceType"],
//        onSaved: (value) {
//          setState(() {
//            _myData["_spaceType"] = value;
//          });
//        },
//        onChanged: (value) {
//          setState(() {
//            _myData["_spaceType"] = value;
//          });
//        },
//        dataSource: _parkingSpaceTypeData,
//        textField: 'display',
//        valueField: 'value',
//      );
//    }
//  }

  List<Widget> pageButton(String buttonText) {
    return [
      RaisedButton(
        onPressed: validateAndSubmit,
        child: Text(
          buttonText,
          style: Theme.of(context).textTheme.display2,
        ),
        color: Colors.green[100],
      ),
    ];
  }

  List<Widget> goBack(){
    return [
      RaisedButton(
        onPressed: () {
          setState(() {
            _page--;
            _formKey.currentState.reset();
            print(_page);
          });
        },
        child: Text(
          'Back',
          style: Theme.of(context).textTheme.display2,
        ),
        color: Colors.green[100],
      ),
    ];
  }

  List<Widget> review() {
    return [
      Text('Review your information:'),
      Text('Title: ' + _myData["_title"]),
      Text('Address: ' + _myData["_address"]),
      Text('City: ' + _myData["_city"]),
      Text('State: ' + _myData["_state"]),
      Text('Zip: ' + _myData["_zip"]),
     // Text('Size: ' + _sizeData[0]["display"]),
      Text('Size: ' + _sizeData[_size]["display"]),
      Text('Type: ' + _typeData[_type]["display"]),
      Text('Driveway: ' + _drivewayData[_driveway]["display"]),
      Text('Space Type: ' + _parkingSpaceTypeData[_spaceType]["display"]),
//      Text('Size: ' + _sizeData[_myData["_size"]]["display"]),
//      Text('Type: ' + _typeData[_myData["_type"]]["display"]),
//      Text('Driveway: ' + _drivewayData[_myData["_driveway"]]["display"]),
//      Text('Space Type: ' + _parkingSpaceTypeData[_myData["_spaceType"]]["display"]),
//      Text(
//          'Driveway: $_myData["_driveway"]',
//      ),
    ];
  }


  List<Widget> submitParking() {
    return [
      RaisedButton(
        key: Key('submit'),
       // onPressed: validateAndSubmit,
        onPressed: () {
          final form = _formKey.currentState;
          form.save();
//          if (form.validate()) {
//            form.save();
//            //print(_page);
//            //print(_myData);
//            setState(() {
//
//            });
//            return true;
//          }
//          return false;
        },
        child: Text(
          'Submit',
          style: Theme.of(context).textTheme.display2,
        ),
        color: Colors.green[100],
      ),
    ];
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      var snackBar = SnackBar(
        content: Text("Processing"),
//        action: SnackBarAction(
//          label: 'Return',
//          onPressed: () {
//            Navigator.pop(context);
//          },
//        ),
      );
      // Find the Scaffold via key and use it to show a SnackBar!
 //     _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print(_page);
      print(_myData);
      setState(() {
        _page++;
      });
      return true;
    }
    return false;
  }

  String validateTitle(String value) {
    if(value.isEmpty){
      return 'Field can\'t be empty; \n'
          'This is what potential renters will see instead of your address';
    }
    if(value.length > 60){
      return 'Title cannot be more than 60 characters';
    }
//    if(value.contains(" ")){
//      return 'Field can\'t contain spaces';
//    }
    return null;
  }

  String validateAddress(String value) {
    if(value.isEmpty){
      return 'Field can\'t be empty';
    }
    if(value.length > 60){
      return 'Address cannot be more than 60 characters';
    }
//    if(value.contains(" ")){
//      return 'Field can\'t contain spaces';
//    }
    return null;
  }

  String validateCity(String value) {
    if(value.isEmpty){
      return 'Field can\'t be empty';
    }
    if(value.toLowerCase() != 'chico'){
      return 'Sorry, we are not operating in your town yet';
    }
//    if(value.contains(" ")){
//      return 'Field can\'t contain spaces';
//    }
    return null;
  }

  String validateZip(String value) {
    if(value.isEmpty){
      return 'Field can\'t be empty';
    }
    if(value.length != 5){
      return 'Enter your 5 digit zip code';
    }
    if(value.contains(" ")){
      return 'Field can\'t contain spaces';
    }
    for(int i=0; i<value.length; i++) {
      if(!RegExp('[r0-9-]').hasMatch(value[i])){
        return 'Enter a valid zip code';
      }
    }

    return null;
  }

//  _displaySnackBar(BuildContext context, String text) {
//    final snackBar = SnackBar(content: Text(text));
//    _scaffoldKey.currentState.showSnackBar(snackBar);
//  }
}
