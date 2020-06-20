import 'package:flutter/material.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:parkcore_app/models/ParkingData.dart';
import 'package:parkcore_app/models/ParkingData2.dart';
import 'package:parkcore_app/models/CurrentUser.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'pform_helpers.dart';
import 'add_parking3.dart';

class AddParking2 extends StatefulWidget {
  AddParking2({Key key, this.parkingData, this.curUser}) : super(key: key);

  // This widget is the 'add parking' page of the app. It is stateful: it has a
  // State object (defined below) that contains fields that affect how it looks.
  // This class is the configuration for the state. It holds the values (title)
  // provided by the parent (App widget) and used by the build method of the
  // State. Fields in a Widget subclass are always marked 'final'.

  final ParkingData parkingData;
  final CurrentUser curUser;

  @override
  _MyAddParking2State createState() => _MyAddParking2State();
}

class _MyAddParking2State extends State<AddParking2> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // parkingData2 params: size, type, driveway, spaceType, amenities, details
  ParkingData2 parkingData2 = ParkingData2(null, null, '', '', null, '');
  FormError formError = FormError();

  final _sizeData = [
    {'display': 'Compact', 'value': 'Compact'},
    {'display': 'Regular', 'value': 'Regular'},
    {'display': 'Oversized', 'value': 'Oversized'},
  ];

  final _typeData = [
    {'display': 'Driveway', 'value': 'Driveway'},
    {'display': 'In a Parking Lot', 'value': 'Parking Lot'},
    {'display': 'On the Street', 'value': 'Street'},
  ];

  final _drivewayData = [
    {'display': 'N/A', 'value': 'N/A'},
    {'display': 'Left side', 'value': 'Left'},
    {'display': 'Right side', 'value': 'Right'},
    {'display': 'Center', 'value': 'Center'},
    {'display': 'Whole Driveway', 'value': 'Whole Driveway'},
  ];

  final _parkingSpaceTypeData = [
    {'display': 'N/A', 'value': 'N/A'},
    {'display': 'Angled', 'value': 'Angled'},
    {'display': 'Parallel', 'value': 'Parallel'},
    {'display': 'Perpendicular', 'value': 'Perpendicular'},
  ];

  final _parkingAmenities = [
    {'display': 'Lit', 'value': 'Lit'},
    {'display': 'Covered', 'value': 'Covered'},
    {'display': 'Security Camera', 'value': 'Security Camera'},
    {'display': 'EV Charging', 'value': 'EV Charging'},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // build(): rerun every time setState is called (e.g. for stateful methods)
    // Rebuild anything that needs updating instead of having to individually
    // change instances of widgets.
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      key: _scaffoldKey,
      appBar: parkingFormAppBar(),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              formError.incomplete ?
                Text(formError.errorMessage, style: TextStyle(color: Colors.red))
                : Text('Part 2 of 5'),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildParkingType(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildParkingType() {
    return [
      Container(
        key: Key('sizeField'),
        decoration: BoxDecoration(
          color: formError.incomplete ? Colors.red[50] : Colors.green[50],
        ),
        child: getSize(),
      ),
      SizedBox(height: 10),
      Container(
        key: Key('typeField'),
        decoration: BoxDecoration(
          color: formError.incomplete ? Colors.red[50] : Colors.green[50],
        ),
        child: getType(),
      ),
      SizedBox(height: 10),
      parkingData2.type == 'Driveway' ?
      Container(
        decoration: BoxDecoration(color: Colors.green[50]),
        child: getDrivewayDetails(),
      ):
      Container(
        decoration: BoxDecoration(color: Colors.green[50]),
        child: getSpaceType(),
      ),
      SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(color: Colors.green[50]),
        child: getAmenities(),
      ),
      SizedBox(height: 10),
      getDetails(),
      SizedBox(height: 10),
      page2Button(),
      SizedBox(height: 10),
      restart(context),
    ];
  }

  // Page 2 Parking Form Widgets (Parking Space Information)

  Widget getSize() {
    return DropDownFormField(
      titleText: '* Parking Space Size',
      hintText: 'Select one:',
      required: true,
      value: parkingData2.size,
      onSaved: (value) {
        setState(() {
          parkingData2.size = value;
        });
      },
      onChanged: (value) {
        setState(() {
          parkingData2.size = value;
        });
      },
      dataSource: _sizeData,
      textField: 'display',
      valueField: 'value',
    );
  }

  Widget getType() {
    return DropDownFormField(
      titleText: '* Type of Parking Space',
      hintText: 'Select one:',
      required: true,
      value: parkingData2.type,
      onSaved: (value) {
        setState(() {
          parkingData2.type = value;
        });
      },
      onChanged: (value) {
        setState(() {
          parkingData2.type = value;
        });
      },
      dataSource: _typeData,
      textField: 'display',
      valueField: 'value',
    );
  }

  // Provides additional parking space info if 'Driveway' is chosen for Type
  Widget getDrivewayDetails() {
    return DropDownFormField(
      titleText: 'Driveway Parking Space Info:',
      hintText: 'Select one:',
      value: parkingData2.driveway,
      onSaved: (value) {
        setState(() {
          if (value == null) {
            parkingData2.driveway = 'N/A';
          } else {
            parkingData2.driveway = value;
          }
          parkingData2.spaceType = 'N/A';
        });
      },
      onChanged: (value) {
        setState(() {
          parkingData2.driveway = value;
        });
      },
      dataSource: _drivewayData,
      textField: 'display',
      valueField: 'value',
    );
  }

  // Provides add'l parking space info if 'Parking Lot' or 'Street' chosen for Type
  Widget getSpaceType() {
    return DropDownFormField(
      titleText: 'Additional Parking Space Info',
      hintText: 'Select one:',
      value: parkingData2.spaceType,
      onSaved: (value) {
        setState(() {
          if (value == null) {
            parkingData2.spaceType = 'N/A';
          } else {
            parkingData2.spaceType = value;
          }
          parkingData2.driveway = 'N/A';
        });
      },
      onChanged: (value) {
        setState(() {
          parkingData2.spaceType = value;
        });
      },
      dataSource: _parkingSpaceTypeData,
      textField: 'display',
      valueField: 'value',
    );
  }

  Widget getAmenities() {
    return MultiSelectFormField(
      autovalidate: false,
      titleText: 'Parking Spot Amenities',
      dataSource: _parkingAmenities,
      textField: 'display',
      valueField: 'value',
      okButtonLabel: 'OK',
      cancelButtonLabel: 'CANCEL',
      hintText: 'Select all that apply',
      initialValue: parkingData2.myAmenities,
      onSaved: (value) {
        if (value == null) return;
        setState(() {
          parkingData2.myAmenities = value;
        });
      },
    );
  }

  Widget getDetails() {
    return TextFormField(
      key: Key('details'),
      autofocus: true,
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      decoration: textFormFieldDeco('Other important details about your space:'),
      onSaved: (value) {
        if (value.isEmpty) return;
        setState(() {
          parkingData2.details = value;
        });
      },
    );
  }

  // Page2Button validates form input and navigates to page 3 of form
  Widget page2Button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        RaisedButton(
          onPressed: validateAndSubmit,
          child: Text(
            'Next: Price & Availability',
            style: themeData.textTheme.headline4,
          ),
          color: themeData.accentColor,
        ),
      ],
    );
  }

  // Validate form (page 2) -
  // if complete, go to next page; otherwise, set error message
  void validateAndSubmit() async {
    if(validateAndSave()){
      goToNextPage();
    }
    else{
      setState(() {
        formError.errorMessage = 'Make sure to fill out all required fields';
      });
    }
  }

  // Confirm page 2 is complete and save the current state of the form.
  // 'Size' and 'Type' are not optional, so if these values have not been
  // selected, the form is still incomplete. Other fields may be left blank.
  bool validateAndSave() {
    if(parkingData2.size == null || parkingData2.type == null) {
      formError.incomplete = true;
      return false;
    }

    formError.incomplete = false;
    _formKey.currentState.save();
    return true;
  }

  // Navigate to form page 3 (pass existing parkingData & curUser objects)
  void goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddParking3(
          parkingData: widget.parkingData,
          parkingData2: parkingData2,
          curUser: widget.curUser,
        ),
      ),
    );
  }
}
