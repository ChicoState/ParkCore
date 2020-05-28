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
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parkcore_app/parking/random_coordinates.dart';
import 'package:parkcore_app/navigate/parkcore_button.dart';

class AddParking extends StatefulWidget {
  AddParking({Key key, this.title}) : super(key: key);
  // This widget is the 'add parking' page of the app. It is stateful: it has a
  // State object (defined below) that contains fields that affect how it looks.
  // This class is the configuration for the state. It holds the values (title)
  // provided by the parent (App widget) and used by the build method of the
  // State. Fields in a Widget subclass are always marked 'final'.

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
  //Current User is a FirebaseUser
  CurrentUser curUser = CurrentUser();
  ParkingSpace parkingSpace = ParkingSpace();
  PageNumber pageNum = PageNumber();
  FormError formError = FormError();
  final ImagePicker _picker = ImagePicker();
  File _imageFile;

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

  final format = DateFormat('HH:mm');
  final priceController = MoneyMaskedTextController(
      decimalSeparator: '.',
      thousandSeparator: ',',
  );

  String getUserName() {
    if (curUser.currentUser != null) {
      return curUser.currentUser.displayName;
    } else {
      return 'no current user';
    }
  }

  String getUserID() {
    if (curUser.currentUser != null) {
      return curUser.currentUser.uid;
    } else {
      return 'no current user';
    }
  }

  final _stateData = [
    {'display': 'California', 'value': 'CA'},
  ];

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

  final _days = [
    {'display': 'Sunday', 'value': 'SUN'},
    {'display': 'Monday', 'value': 'MON'},
    {'display': 'Tuesday', 'value': 'TUE'},
    {'display': 'Wednesday', 'value': 'WED'},
    {'display': 'Thursday', 'value': 'THU'},
    {'display': 'Friday', 'value': 'FRI'},
    {'display': 'Saturday', 'value': 'SAT'},
  ];

  // Select an image via gallery or camera
  Future<void> getUserImage(ImageSource source) async {
    var selected = await _picker.getImage(source: source);

    setState(() {
      _imageFile = File(selected.path);
    });
  }

  // Get a unique ID for each image upload
  Future<void> getUniqueFile() async {
    final uuid = Uuid().v1();
    parkingSpace.downloadURL = await _uploadFile(uuid);
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
                : Text('Part ' + pageNum.page.toString() + ' of 5'),
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
    );
  }

  List<Widget> formPages() {
    if (pageNum.page == 1) {
      return buildAddress() + pageButton('Next: Parking Space Info');
    } else if (pageNum.page == 2) {
      return buildParkingType() + pageButton('Next: Price & Availability');
    } else if (pageNum.page == 3) {
      return buildAvailability() + pageButton('Review');
    } else if (pageNum.page == 4) {
      return review() + pageButton('Add Image & Submit');
    } else {
      return buildImages() + submitParking();
    }
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
          'Adding a parking space owned by: ' + getUserName()
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

  List<Widget> buildParkingType() {
    return [
      Container(
        decoration: BoxDecoration(
          color: formError.incomplete ? Colors.red[50] : Colors.green[50],
        ),
        child: getSize(),
      ),
      SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(
          color: formError.incomplete ? Colors.red[50] : Colors.green[50],
        ),
        child: getType(),
      ),
      SizedBox(height: 10),
      parkingSpace.type == 'Driveway' ?
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
      SizedBox(height: 30),
    ];
  }

  List<Widget> buildAvailability() {
    return [
      Container(
        decoration: BoxDecoration(color: Colors.green[50]),
        child: getDays(),
      ),
      SizedBox(height: 10),
      getTime('start'),
      SizedBox(height: 10),
      getTime('end'),
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
          getImageType('camera'),
          SizedBox(width: 10),
          getImageType('gallery'),
        ],
      ),
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
          parkingSpace.title = value;
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
          parkingSpace.address = value;
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
          parkingSpace.city = value;
        });
      },
    );
  }

  Widget getState() {
    return DropDownFormField(
      titleText: 'State',
      hintText: '* Currently only available in California:',
      required: true,
      value: parkingSpace.state,
      onSaved: (value) {
        setState(() {
          if (parkingSpace.state.isEmpty) {
            formError.incomplete = true;
          } else {
            formError.incomplete = false;
            parkingSpace.state = value;
          }
        });
      },
      onChanged: (value) {
        setState(() {
          parkingSpace.state = value;
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
          parkingSpace.zip = value;
        });
      },
    );
  }

  // Page 2 Parking Form Widgets (Parking Space Information)

  Widget getSize() {
    return DropDownFormField(
      titleText: '* Parking Space Size',
      hintText: 'Select one:',
      required: true,
      value: parkingSpace.size,
      onSaved: (value) {
        setState(() {
          if (parkingSpace.size.isEmpty) {
            formError.incomplete = true;
          } else {
            formError.incomplete = false;
            parkingSpace.size = value;
          }
        });
      },
      onChanged: (value) {
        setState(() {
          parkingSpace.size = value;
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
      value: parkingSpace.type,
      onSaved: (value) {
        setState(() {
          if (parkingSpace.type.isEmpty) {
            formError.incomplete = true;
          } else {
            formError.incomplete = false;
            parkingSpace.type = value;
          }
        });
      },
      onChanged: (value) {
        setState(() {
          parkingSpace.type = value;
        });
      },
      dataSource: _typeData,
      textField: 'display',
      valueField: 'value',
    );
  }

  Widget getDrivewayDetails() {
    return DropDownFormField(
      titleText: '* Driveway Parking Space:',
      hintText: 'Select one:',
      value: parkingSpace.driveway,
      onSaved: (value) {
        setState(() {
          if (value.isEmpty) {
            parkingSpace.driveway = 'N/A';
          } else {
            parkingSpace.driveway = value;
          }
          parkingSpace.spaceType = 'N/A';
        });
      },
      onChanged: (value) {
        setState(() {
          parkingSpace.driveway = value;
        });
      },
      dataSource: _drivewayData,
      textField: 'display',
      valueField: 'value',
    );
  }

  Widget getSpaceType() {
    return DropDownFormField(
      titleText: '* Additional Parking Space Info',
      hintText: 'Select one:',
      value: parkingSpace.spaceType,
      onSaved: (value) {
        setState(() {
          if (value.isEmpty) {
            parkingSpace.spaceType = 'N/A';
          } else {
            parkingSpace.spaceType = value;
          }
          parkingSpace.driveway = 'N/A';
        });
      },
      onChanged: (value) {
        setState(() {
          parkingSpace.spaceType = value;
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
      initialValue: parkingSpace.myAmenities,
      onSaved: (value) {
        if (value == null) return;
        setState(() {
          parkingSpace.myAmenities = value;
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
      decoration: textFormFieldDeco('Other important details about your space:'),
      onSaved: (value) {
        if (value.isEmpty) {
          parkingSpace.details = '';
        }
        setState(() {
          parkingSpace.details = value;
        });
      },
    );
  }

// Page 3 Parking Form Widgets (Availability and Price)

  Widget getDays() {
    return MultiSelectFormField(
      autovalidate: false,
      titleText: '* Days Available',
      dataSource: _days,
      textField: 'display',
      valueField: 'value',
      okButtonLabel: 'OK',
      cancelButtonLabel: 'CANCEL',
      hintText: 'Select all days your parking space\nwill be available',
      initialValue: parkingSpace.myDays,
      onSaved: (value) {
        if (value == null) return;
        setState(() {
          parkingSpace.myDays = value;
        });
      },
    );
  }

  Widget getTime(String type) {
    return DateTimeField(
      format: format,
      decoration: InputDecoration(
        labelText: type == 'start' ?
          'Parking Space Available Starting at:':'Parking Space Available Until:',
      ),
      onShowPicker: (context, currentValue) async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
        );
        setState(() {
          type == 'start' ?
            parkingSpace.startTime = DateFormat('HH:mm').format(DateTimeField.convert(time))
            : parkingSpace.endTime = DateFormat('HH:mm').format(DateTimeField.convert(time));
        });
        return DateTimeField.convert(time);
      },
    );
  }

  Widget getPrice() {
    return TextFormField(
      key: Key('price'),
      validator: validatePrice,
      controller: priceController,
      keyboardType: TextInputType.number,
      decoration: textFormFieldDeco('* Price per month (\$):'),
      onSaved: (value) {
        setState(() {
          parkingSpace.price = priceController.text;
        });
      },
    );
  }

  InputDecoration textFormFieldDeco(String label) {
    return InputDecoration(
      labelText: label,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }

  // Page 4 Parking Form Widgets (Image and Submit)

  Widget showImage() {
    return Center(
      child: _imageFile == null
        ? Text(
          'No image selected.',
          style: Theme.of(context).textTheme.headline3,
        )
        : Image.file(_imageFile),
    );
  }

  Widget getImageType(String type) {
    return Expanded(
      child: FormField<File>(
        //validator: validateImage,
        builder: (FormFieldState<File> state) {
          return RaisedButton(
            child: Icon(
              type == 'camera' ? Icons.photo_camera : Icons.photo_library,
            ),
            onPressed: () =>
              type == 'camera' ?
              getUserImage(ImageSource.camera) : getUserImage(ImageSource.gallery),
            color: Theme.of(context).backgroundColor,
            textColor: Colors.white,
          );
        },
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
      Text('Title: ' + parkingSpace.title),
      Text('Address: ' + parkingSpace.address),
      Text('City: ' + parkingSpace.city_format),
      Text('State: ' + parkingSpace.state),
      Text('Zip: ' + parkingSpace.zip),
      Text('Size: ' + parkingSpace.size),
      Text('Type: ' + parkingSpace.type),
      Text('Driveway: ' + parkingSpace.driveway),
      Text('Space Type: ' + parkingSpace.spaceType),
      Text('Amenities: ' + parkingSpace.myAmenities.toString()),
      Text('Additional Details: ' + parkingSpace.details),
      Text('Days Available: ' + parkingSpace.myDays.toString()),
      Text('Available Starting at: ' + parkingSpace.startTime),
      Text('Available Until: ' + parkingSpace.endTime),
      Text('Price per month: \$' + parkingSpace.price),
      SizedBox(height: 10),
      Text('Additional info connected to this parking space:'),
      Text('Parking Space Owner: ' + getUserName()),
      Text('Parking Space Coordinates: ' + parkingSpace.coordinates),
      SizedBox(height: 10),
      restart(),
      SizedBox(height: 50),
    ];
  }

  // Parking Form Buttons

  List<Widget> pageButton(String buttonText) {
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
                    buttonText,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }

  Widget restart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RaisedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/add_parking');
          },
          child: Text(
            'Restart Form',
            style: Theme.of(context).textTheme.headline4,
          ),
          color: Theme.of(context).backgroundColor,
        ),
      ],
    );
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
                print('parking space added to database');
                Navigator.pushReplacementNamed(context, '/form_success');
              }
              catch (e) {
                print('Error occurred: $e');
              }
            },
            child: Text(
              'Submit',
              style: Theme.of(context).textTheme.headline4,
            ),
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    ];
  }

  // Create ParkingSpaces database entry
  Future<void> createParkingSpace() async {
    try {
      await getUniqueFile();
    } catch (e) {
      print('Error occurred: $e');
    }

    var parkingData = {
      'title': parkingSpace.title,
      'address': parkingSpace.address,
      'city': parkingSpace.city_format,
      'state': parkingSpace.state,
      'zip': parkingSpace.zip,
      'size': parkingSpace.size,
      'type': parkingSpace.type,
      'driveway': parkingSpace.driveway,
      'spacetype': parkingSpace.spaceType,
      'amenities': parkingSpace.myAmenities.toString(),
      'spacedetails': parkingSpace.details,
      'days': parkingSpace.myDays.toString(),
      'starttime': parkingSpace.startTime,
      'endtime': parkingSpace.endTime,
      'monthprice': parkingSpace.price,
      'coordinates': parkingSpace.coordinates, // generated from the input address
      'coordinates_r': parkingSpace.coord_rand, // random coordinates near actual address
      'downloadURL': parkingSpace.downloadURL, // for the image (put in firebase storage)
      'uid': getUserID(), // parkingSpace owner is the current user
      'reserved': [].toString(), // list of UIDs (if reserved, starts empty)
      'cur_tenant': '', // current tenant (a UID, or empty if spot is available)
    };

    await Firestore.instance.runTransaction((transaction) async {
      CollectionReference ref = Firestore.instance.collection('parkingSpaces');
      await ref.add(parkingData);
    });
  }

  // Form Validation

  void validateAndSubmit() async {
    // After address info is input, create associated coordinates (if possible),
    if(pageNum.page == 1){
      try {
        _formKey.currentState.save();
        var _geoAddress = parkingSpace.address + ', ' + parkingSpace.city
            + ', ' + parkingSpace.zip;
        var addresses = await Geocoder.local.findAddressesFromQuery(_geoAddress);
        var first = addresses.first;
        parkingSpace.coordinates = first.coordinates.toString();
        parkingSpace.coord_rand = getRandomCoordinates(parkingSpace.coordinates);

        print(first.addressLine + ' : ' + first.coordinates.toString());
        print('random coordinates : ' + parkingSpace.coord_rand);

        setState(() {
          //var addr = first.addressLine.split(', ');
          var addr = getSplitAddress(first.addressLine);
          parkingSpace.city_format = addr[1];
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
    }
    // if location was valid, check additional validators
    if (!formError.invalidLoc) {
      if(!validateAndSave()){
        setState(() {
          formError.errorMessage = 'Make sure to fill out all required fields';
          print(formError.errorMessage);
        });
      }
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
      setState(() {
        pageNum.page++;
      });
      return true;
    }
    return false;
  }

  List<String> getSplitAddress(String address){
    return address.split(', ');
  }

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

  String validatePrice(String value) {
    if (value.isEmpty) {
      return 'Field can\'t be empty';
    }
    if (value.contains(' ')) {
      return 'Field can\'t contain spaces';
    }
    return null;
  }
}

class CurrentUser {
  FirebaseUser _currentUser;

  FirebaseUser get currentUser => _currentUser;
  set currentUser(FirebaseUser currentUser) => _currentUser = currentUser;
}

class PageNumber {
  int _page = 1;

  int get page => _page;
  set page(int page) => _page = page;
}

class FormError {
  bool _incomplete = false;
  bool _invalidLoc = false;
  String _errorMessage = '';

  bool get incomplete => _incomplete;
  set incomplete(bool incomplete) => _incomplete = incomplete;

  bool get invalidLoc => _invalidLoc;
  set invalidLoc(bool invalidLoc) => _invalidLoc = invalidLoc;

  String get errorMessage => _errorMessage;
  set errorMessage(String errorMessage) => _errorMessage = errorMessage;
}

class ParkingSpace {
  String _title = '';
  String _address = '';
  String _city = '';
  String _city_format = '';
  String _state = '';
  String _zip = '';
  String _size = '';
  String _type = '';
  String _driveway = '';
  String _spaceType = '';
  List _myAmenities = [];
  String _details = '';
  List _myDays = [];
  String _startTime = '';
  String _endTime = '';
  String _price = '';
  String _coordinates = '';
  String _coord_rand = '';
  String _downloadURL;

  String get title => _title;
  set title(String title) => _title = title;

  String get address => _address;
  set address(String address) => _address = address;

  String get city => _city;
  set city(String city) => _city = city;

  String get city_format => _city_format;
  set city_format(String city) => _city_format = city;

  String get state => _state;
  set state(String state) => _state = state;

  String get zip => _zip;
  set zip(String zip) => _zip = zip;

  String get size => _size;
  set size(String size) => _size = size;

  String get type => _type;
  set type(String type) => _type = type;

  String get driveway => _driveway;
  set driveway(String driveway) => _driveway = driveway;

  String get spaceType => _spaceType;
  set spaceType(String spaceType) => _spaceType = spaceType;

  List<dynamic> get myAmenities => _myAmenities;
  set myAmenities(List<dynamic> myAmenities) => _myAmenities = myAmenities;

  String get details => _details;
  set details(String details) => _details = details;

  List<dynamic> get myDays => _myDays;
  set myDays(List<dynamic> myDays) => _myDays = myDays;

  String get startTime => _startTime;
  set startTime(String startTime) => _startTime = startTime;

  String get endTime => _endTime;
  set endTime(String endTime) => _endTime = endTime;

  String get price => _price;
  set price(String price) => _price = price;

  String get coordinates => _coordinates;
  set coordinates(String coordinates) => _coordinates = coordinates;

  String get coord_rand => _coord_rand;
  set coord_rand(String coord_rand) => _coord_rand = coord_rand;

  String get downloadURL => _downloadURL;
  set downloadURL(String downloadURL) => _downloadURL = downloadURL;
}
