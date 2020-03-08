//import 'dart:html';

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
  String _title;
  String _address;
  String _city;
  String _state;
  int _size;
  int _type = 0;
  int _driveway;
  int _streetParking;
  int _spaceType;

  final _stateData = [
    {"display": "California", "value": "CA"},
  ];

  final _sizeData = [
    {"display": "Compact Car", "value": 0},
    {"display": "Regular", "value": 1},
    {"display": "Oversized", "value": 2},
  ];

  final _typeData = [
    {"display": "Driveway", "value": 0},
    {"display": "Other", "value": 1},
  ];

  final _drivewayData = [
    {"display": "Left side", "value": 0},
    {"display": "Right side", "value": 1},
    {"display": "Center", "value": 2},
    {"display": "Whole Driveway", "value": 3},
  ];

  final _streetParkingData = [
    {"display": "In a Parking Lot", "value": 0},
    {"display": "On the Street", "value": 1},
  ];

  final _parkingSpaceTypeData = [
    {"display": "Angled", "value": 0},
    {"display": "Parallel", "value": 1},
    {"display": "Perpendicular", "value": 2},
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
          //child: Padding(
            padding: const EdgeInsets.all(16.0),
            //padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
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
                    children: buildInputs()
                      + addParkingSpaceInfo()
                      + buildSubmitButtons(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
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
        onSaved: (value) => _title = value,
      ),
      SizedBox(height: 10),
      TextFormField(
        key: Key('address'),
       // validator: validateAddress,
        decoration: InputDecoration(
          labelText: 'Street Address:',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.lightGreen
            ),
          ),
        ),
        onSaved: (value) => _address = value,
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
        onSaved: (value) => _city = value,
      ),
      SizedBox(height: 10),
      DropDownFormField(
        titleText: 'State',
        hintText: 'Currently only available in California:',
        value: _state,
        onSaved: (value) {
          setState(() {
            _state = value;
          });
        },
        onChanged: (value) {
          setState(() {
            _state = value;
          });
        },
        dataSource: _stateData,
        textField: 'display',
        valueField: 'value',
      ),
      SizedBox(height: 10),
      DropDownFormField(
        titleText: 'Parking Space Size',
        hintText: 'Select one:',
        value: _size,
        onSaved: (value) {
          setState(() {
            _size = value;
          });
        },
        onChanged: (value) {
          setState(() {
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
        onSaved: (value) {
          setState(() {
            _type = value;
          });
        },
        onChanged: (value) {
          setState(() {
            _type = value;
          });
        },
        dataSource: _typeData,
        textField: 'display',
        valueField: 'value',
      ),
    ];
  }

  List<Widget> addParkingSpaceInfo() {
    if(_type == 0){
      return [
        SizedBox(height: 10),
        DropDownFormField(
          titleText: 'Driveway Parking Space',
          hintText: 'Select one:',
          value: _driveway,
          onSaved: (value) {
            setState(() {
              _driveway = value;
            });
          },
          onChanged: (value) {
            setState(() {
              _driveway = value;
            });
          },
          dataSource: _drivewayData,
          textField: 'display',
          valueField: 'value',
        ),
      ];
    }
    else{
      return [
        SizedBox(height: 10),
        DropDownFormField(
        titleText: 'Other Parking',
        hintText: 'Select one:',
        value: _streetParking,
        onSaved: (value) {
        setState(() {
        _streetParking = value;
        });
        },
        onChanged: (value) {
        setState(() {
        _streetParking = value;
        });
        },
        dataSource: _streetParkingData,
        textField: 'display',
        valueField: 'value',
        ),
        SizedBox(height: 10),
        DropDownFormField(
          titleText: 'Additional Parking Info',
          hintText: 'Select one:',
          value: _spaceType,
          onSaved: (value) {
            setState(() {
              _spaceType = value;
            });
          },
          onChanged: (value) {
            setState(() {
              _spaceType = value;
            });
          },
          dataSource: _parkingSpaceTypeData,
          textField: 'display',
          valueField: 'value',
        ),
      ];
    }
  }

  List<Widget> buildSubmitButtons() {
    return [
      RaisedButton(
        key: Key('submit'),
        onPressed: validateAndSubmit,
//        onPressed: () {
          // Validate returns true if the form is valid, otherwise false.
//          if (_formKey.currentState.validate()) {
//            // If the form is valid, display a snackbar. In the real world,
//            // you'd often call a server or save the information in a database.
//            Scaffold.of(context).showSnackBar(new SnackBar(
//              content: new Text('Processing Data...'),
//            ));
//          }
//        },
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
      setState(() {

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

  _displaySnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
