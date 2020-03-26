import 'dart:io';
import 'package:flutter/material.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

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
  bool _incomplete = false;
  bool _invalidLoc = false;
  String _errorMessage = '';

  String _title = '';
  String _address = '';
  String _city = '';
  String _state = '';
  String _zip = '';
  String _geoAddress = '';
  String _coordinates = '';

  String _size = '';
  String _type = '';
  String _driveway = '';
  String _spaceType = '';
  List _myAmenities = [];
  String _details = '';

  List _myDays = [];
  final format = DateFormat("HH:mm");
  String _startTime = '';
  String _endTime = '';
  String _price = '';

  File _imageFile;
  String _downloadURL;

  final _stateData = [
    {"display": "California", "value": "CA"},
  ];

  final _sizeData = [
    {"display": "Compact", "value": "Compact"},
    {"display": "Regular", "value": "Regular"},
    {"display": "Oversized", "value": "Oversized"},
  ];

  final _typeData = [
    {"display": "Driveway", "value": "Driveway"},
    {"display": "In a Parking Lot", "value": "Parking Lot"},
    {"display": "On the Street", "value": "Street"},
  ];

  final _drivewayData = [
    {"display": "N/A", "value": "N/A"},
    {"display": "Left side", "value": "Left"},
    {"display": "Right side", "value": "Right"},
    {"display": "Center", "value": "Center"},
    {"display": "Whole Driveway", "value": "Whole Driveway"},
  ];

  final _parkingSpaceTypeData = [
    {"display": "N/A", "value": "N/A"},
    {"display": "Angled", "value": "Angled"},
    {"display": "Parallel", "value": "Parallel"},
    {"display": "Perpendicular", "value": "Perpendicular"},
  ];

  final _parkingAmenities = [
    {"display": "Lit", "value": "Lit"},
    {"display": "Covered", "value": "Covered"},
    {"display": "Security Camera", "value": "Security Camera"},
    {"display": "EV Charging", "value": "EV Charging"},
  ];

  final _days = [
    {"display": "Sunday", "value": "SUN"},
    {"display": "Monday", "value": "MON"},
    {"display": "Tuesday", "value": "TUE"},
    {"display": "Wednesday", "value": "WED"},
    {"display": "Thursday", "value": "THU"},
    {"display": "Friday", "value": "FRI"},
    {"display": "Saturday", "value": "SAT"},
  ];

  // Select an image via gallery or camera
  Future<void> getImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  // Get a unique ID for each image upload
  Future<void> getUniqueFile() async {
    final String uuid = Uuid().v1();
    _downloadURL = await _uploadFile(uuid);
  }

  // get download URL for image files
  Future<String> _uploadFile(filename) async {
    final StorageReference ref =
        FirebaseStorage.instance.ref().child('$filename.jpg');
    final StorageUploadTask uploadTask = ref.putFile(
      _imageFile,
      StorageMetadata(
        contentLanguage: 'en',
      ),
    );

    final downloadURL =
        await (await uploadTask.onComplete).ref.getDownloadURL();
    return downloadURL.toString();
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
      ),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                _incomplete || _invalidLoc
                    ? Text(_errorMessage, style: TextStyle(color: Colors.red))
                    : Text("Part " + _page.toString() + " of 5"),
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
    if (_page == 1) {
      return buildAddress() + pageButton('Next: Parking Space Info');
    } else if (_page == 2) {
      return buildParkingType() + pageButton('Next: Price & Availability');
    } else if (_page == 3) {
      return buildAvailability() + pageButton('Review');
    } else if (_page == 4) {
      return review() + restart() + pageButton('Add Image & Submit');
    } else {
      return buildImages() + submitParking();
    }
  }

  List<Widget> buildAddress() {
    return [
      getTitle(),
      SizedBox(height: 10),
      getAddress(),
      SizedBox(height: 10),
      getCity(),
      SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(
          color: _incomplete ? Colors.red[50] : Colors.white10,
        ),
        child: getState(),
      ),
      SizedBox(height: 10),
      getZip(),
      SizedBox(height: 30),
    ];
  }

  List<Widget> buildParkingType() {
    return [
      Container(
        decoration: BoxDecoration(
          color: _incomplete ? Colors.red[50] : Colors.white10,
        ),
        child: getSize(),
      ),
      SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(
          color: _incomplete ? Colors.red[50] : Colors.white10,
        ),
        child: getType(),
      ),
      SizedBox(height: 10),
      _type == "Driveway" ? getDrivewayDetails() : getSpaceType(),
      SizedBox(height: 10),
      getAmenities(),
      SizedBox(height: 10),
      getDetails(),
      SizedBox(height: 30),
    ];
  }

  List<Widget> buildAvailability() {
    return [
      getDays(),
      SizedBox(height: 10),
      Text('Parking Space Available Starting at:'),
      getStartTime(),
      SizedBox(height: 10),
      Text('Parking Space Available Until:'),
      getEndTime(),
      SizedBox(height: 10),
      getPrice(),
      SizedBox(height: 30),
    ];
  }

  List<Widget> buildImages() {
    return [
      showImage(),
      SizedBox(height: 10),
      Row(
        children: <Widget>[
          getCameraImage(),
          getGalleryImage(),
        ],
      ),
      SizedBox(height: 30),
    ];
  }

  // Page 1 Parking Form Widgets

  Widget getTitle() {
    return TextFormField(
      key: Key('title'),
      autofocus: true,
      validator: validateTitle,
      keyboardType: TextInputType.multiline,
      maxLines: 2,
      decoration: InputDecoration(
        labelText: 'Enter a descriptive title for your parking space:',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).backgroundColor,
          ),
        ),
      ),
      onSaved: (value) {
        setState(() {
          _title = value;
        });
      },
    );
  }

  Widget getAddress() {
    return TextFormField(
      key: Key('address'),
      validator: validateAddress,
      decoration: InputDecoration(
        labelText: 'Street Address:',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).backgroundColor,
          ),
        ),
      ),
      onSaved: (value) {
        setState(() {
          _address = value;
        });
      },
    );
  }

  Widget getCity() {
    return TextFormField(
      key: Key('city'),
      validator: validateCity,
      decoration: InputDecoration(
        labelText: 'City:',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).backgroundColor,
          ),
        ),
      ),
      onSaved: (value) {
        setState(() {
          _city = value;
        });
      },
    );
  }

  Widget getState() {
    return DropDownFormField(
      titleText: 'State',
      hintText: '*Required*\nCurrently only available in California:',
      required: true,
      value: _state,
      onSaved: (value) {
        setState(() {
          if (_state.isEmpty) {
            _incomplete = true;
          } else {
            _incomplete = false;
            _state = value;
          }
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
    );
  }

  Widget getZip() {
    return TextFormField(
      key: Key('zip'),
      autofocus: true,
      validator: validateZip,
      decoration: InputDecoration(
        labelText: 'Zip Code:',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).backgroundColor,
          ),
        ),
      ),
      onSaved: (value) {
        setState(() {
          _zip = value;
        });
      },
    );
  }

  // Page 2 Parking Form Widgets

  Widget getSize() {
    return DropDownFormField(
      titleText: 'Parking Space Size',
      hintText: '*Required*\nSelect one:',
      required: true,
      value: _size,
      onSaved: (value) {
        setState(() {
          if (_size.isEmpty) {
            _incomplete = true;
          } else {
            _incomplete = false;
            _size = value;
          }
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
    );
  }

  Widget getType() {
    return DropDownFormField(
      titleText: 'Type of Parking Space',
      hintText: '*Required*\nSelect one:',
      required: true,
      value: _type,
      onSaved: (value) {
        setState(() {
          if (_type.isEmpty) {
            _incomplete = true;
          } else {
            _incomplete = false;
            _type = value;
          }
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
    );
  }

  Widget getDrivewayDetails() {
    return DropDownFormField(
      titleText: 'Driveway Parking Space:',
      hintText: 'Select one:',
      value: _driveway,
      onSaved: (value) {
        setState(() {
          if (value.isEmpty) {
            _driveway = "N/A";
          } else {
            _driveway = value;
          }
          _spaceType = "N/A";
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
    );
  }

  Widget getSpaceType() {
    return DropDownFormField(
      titleText: 'Additional Parking Info',
      hintText: 'Select one:',
      value: _spaceType,
      onSaved: (value) {
        setState(() {
          if (value.isEmpty) {
            _spaceType = "N/A";
          } else {
            _spaceType = value;
          }
          _driveway = "N/A";
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
      value: _myAmenities,
      onSaved: (value) {
        setState(() {
          _myAmenities = value;
        });
      },
    );
  }

  Widget getDetails() {
    return TextFormField(
      key: Key('details'),
      autofocus: true,
      keyboardType: TextInputType.multiline,
      maxLines: 6,
      decoration: InputDecoration(
        labelText: 'Other important details about your space:',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).backgroundColor,
          ),
        ),
      ),
      onSaved: (value) {
        if (value.isEmpty) {
          _details = "";
        }
        setState(() {
          _details = value;
        });
      },
    );
  }

// Page 3 Parking Form Widgets

  Widget getDays() {
    return MultiSelectFormField(
      autovalidate: false,
      titleText: 'Days Available',
      dataSource: _days,
      textField: 'display',
      valueField: 'value',
      okButtonLabel: 'OK',
      cancelButtonLabel: 'CANCEL',
      hintText: 'Select all days your parking space\nwill be available',
      value: _myDays,
      onSaved: (value) {
        setState(() {
          _myDays = value;
        });
      },
    );
  }

  Widget getStartTime() {
    return DateTimeField(
      format: format,
      onShowPicker: (context, currentValue) async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
        );
        setState(() {
          _startTime = DateFormat('HH:mm').format(DateTimeField.convert(time));
        });
        return DateTimeField.convert(time);
      },
    );
  }

  Widget getEndTime() {
    return DateTimeField(
      format: format,
      onShowPicker: (context, currentValue) async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
        );
        setState(() {
          _endTime = DateFormat('HH:mm').format(DateTimeField.convert(time));
        });
        return DateTimeField.convert(time);
      },
    );
  }

  Widget getPrice() {
    return TextFormField(
      key: Key('price'),
      validator: validatePrice,
      decoration: InputDecoration(
        labelText: 'Price per month (\$):',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).backgroundColor,
          ),
        ),
      ),
      onSaved: (value) {
        setState(() {
          _price = value;
        });
      },
    );
  }

  // Page 4 Parking Form Widgets

  Widget showImage() {
    return Center(
      child: _imageFile == null
          ? Text('No image selected.')
          : Image.file(_imageFile),
    );
  }

  Widget getCameraImage() {
    return Expanded(
      child: FormField<File>(
        //validator: validateImage,
        builder: (FormFieldState<File> state) {
          return RaisedButton(
            child: Icon(Icons.photo_camera),
            onPressed: () => getImage(ImageSource.camera),
          );
        },
      ),
    );
  }

  Widget getGalleryImage() {
    return Expanded(
      child: FormField<File>(
        //validator: validateImage,
        builder: (FormFieldState<File> state) {
          return RaisedButton(
            child: Icon(Icons.photo_library),
            onPressed: () => getImage(ImageSource.gallery),
          );
        },
      ),
    );
  }

  List<Widget> review() {
    return [
      Text(
        'Review your information:',
        style: Theme.of(context).textTheme.display2,
      ),
      SizedBox(height: 10),
      Text('Title: ' + _title),
      Text('Address: ' + _address),
      Text('City: ' + _city),
      Text('State: ' + _state),
      Text('Zip: ' + _zip),
      Text('Size: ' + _size),
      Text('Type: ' + _type),
      Text('Driveway: ' + _driveway),
      Text('Space Type: ' + _spaceType),
      Text('Amenities: ' + _myAmenities.toString()),
      Text('Additional Details: ' + _details),
      Text('Days Available: ' + _myDays.toString()),
      Text('Available Starting at: ' + _startTime),
      Text('Available Until: ' + _endTime),
      Text('Price per month: \$' + _price),
      Text('Generated info:'),
      Text('Parking Space Coordinates: ' + _coordinates),
      SizedBox(height: 10),
    ];
  }

  // Parking Form Buttons

  List<Widget> pageButton(String buttonText) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton(
            onPressed: validateAndSubmit,
            child: Text(
              buttonText,
              style: Theme.of(context).textTheme.display2,
            ),
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    ];
  }

  List<Widget> restart() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/add_parking');
            },
            child: Text(
              'Restart Form',
              style: Theme.of(context).textTheme.display2,
            ),
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    ];
  }

  List<Widget> submitParking() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            key: Key('submit'),
            onPressed: () {
              final form = _formKey.currentState;
              form.save();

              try {
                createParkingSpace();
                Navigator.pushReplacementNamed(context, '/home');
                print("parking space added to database");
              } catch (e) {
                print("Error occured: $e");
              }
            },
            child: Text(
              'Submit',
              style: Theme.of(context).textTheme.display2,
            ),
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    ];
  }

  Future<void> createParkingSpace() async {
    try {
      await getUniqueFile();
    } catch (e) {
      print("Error occured: $e");
    }

    var parkingData = {
      'title': _title,
      'address': _address,
      'city': _city,
      'state': _state,
      'zip': _zip,
      'size': _size,
      'type': _type,
      'driveway': _driveway,
      'spacetype': _spaceType,
      'amenities': _myAmenities.toString(),
      'spacedetails': _details,
      'days': _myDays.toString(),
      'starttime': _startTime,
      'endtime': _endTime,
      'monthprice': _price,
      'coordinates': _coordinates,
      'downloadURL': _downloadURL,
    };

    await Firestore.instance.runTransaction((transaction) async {
      CollectionReference ref = Firestore.instance.collection('parkingSpaces');
      await ref.add(parkingData);
    });
  }

  // Form Validation

  void validateAndSubmit() async {
    if (_page == 1) {
      try {
        _formKey.currentState.save();
        _geoAddress =
            _address + ", " + _city + ", " + _state + " " + _zip + ", USA";
        var addresses =
            await Geocoder.local.findAddressesFromQuery(_geoAddress);
        var first = addresses.first;
        _coordinates = first.coordinates.toString();
        print(first.addressLine + " : " + first.coordinates.toString());
        setState(() {
          _invalidLoc = false;
        });
      } catch (e) {
        print("Error occured: $e");
        setState(() {
          _invalidLoc = true;
          _errorMessage = "We can't find you!\nPlease enter a valid location.";
        });
      }
    }
    if (!_invalidLoc) {
      if (validateAndSave()) {
      } else {
        setState(() {
          _errorMessage = "Make sure to fill out all required fields";
          print(_errorMessage);
        });
      }
    }
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (_incomplete) {
        return false;
      }
      setState(() {
        _page++;
        // print(_page);
      });
      return true;
    }
    return false;
  }

  String validateTitle(String value) {
    if (value.isEmpty) {
      return 'Field can\'t be empty; \n'
          'This is what potential renters will see instead of your address';
    }
    if (value.length > 60) {
      return 'Title cannot be more than 60 characters';
    }
    return null;
  }

  String validateAddress(String value) {
    if (value.isEmpty) {
      return 'Field can\'t be empty';
    }
    if (value.length > 60) {
      return 'Address cannot be more than 60 characters';
    }
    return null;
  }

  String validateCity(String value) {
    if (value.isEmpty) {
      return 'Field can\'t be empty';
    }
//    if(value.toUpperCase() != 'CHICO'){
//      return 'Sorry, we are not operating in your town yet';
//    }
    return null;
  }

  String validateState(String value) {
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
    if (value.contains(" ")) {
      return 'Field can\'t contain spaces';
    }
    for (int i = 0; i < value.length; i++) {
      if (!RegExp('[r0-9-]').hasMatch(value[i])) {
        return 'Enter a valid zip code';
      }
    }
    return null;
  }

  String validatePrice(String value) {
    if (value.isEmpty) {
      return 'Field can\'t be empty';
    }
    if (value.contains(" ")) {
      return 'Field can\'t contain spaces';
    }
    for (int i = 0; i < value.length; i++) {
      if (!RegExp('[r0-9-]').hasMatch(value[i])) {
        return 'Enter a valid dollar amount';
      }
    }
    return null;
  }
}
