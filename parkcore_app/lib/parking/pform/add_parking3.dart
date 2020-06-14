import 'package:flutter/material.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:parkcore_app/navigate/parkcore_button.dart';
import 'package:parkcore_app/models/ParkingData.dart';
import 'package:parkcore_app/models/ParkingData2.dart';
import 'package:parkcore_app/models/ParkingData3.dart';
import 'package:parkcore_app/models/CurrentUser.dart';
import 'pform_helpers.dart';
import 'add_parking_review.dart';

class AddParking3 extends StatefulWidget {
  AddParking3({
    Key key, this.title, this.parkingData, this.parkingData2, this.curUser
  }) : super(key: key);

  // This widget is the 'add parking' page of the app. It is stateful: it has a
  // State object (defined below) that contains fields that affect how it looks.
  // This class is the configuration for the state. It holds the values (title)
  // provided by the parent (App widget) and used by the build method of the
  // State. Fields in a Widget subclass are always marked 'final'.

  final String title;
  final ParkingData parkingData;
  final ParkingData2 parkingData2;
  final CurrentUser curUser;

  @override
  _MyAddParking3State createState() => _MyAddParking3State();
}

class _MyAddParking3State extends State<AddParking3> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ParkingData3 parkingData3 = ParkingData3(null, '', '', '');
  // CurrentUser curUser = CurrentUser(null);
  FormError formError = FormError();
  final format = DateFormat('HH:mm');
  final priceController = MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  final _days = [
    {'display': 'Sunday', 'value': 'SUN'},
    {'display': 'Monday', 'value': 'MON'},
    {'display': 'Tuesday', 'value': 'TUE'},
    {'display': 'Wednesday', 'value': 'WED'},
    {'display': 'Thursday', 'value': 'THU'},
    {'display': 'Friday', 'value': 'FRI'},
    {'display': 'Saturday', 'value': 'SAT'},
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
                : Text('Part 3 of 5'),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildAvailability() + page3Button(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
      initialValue: parkingData3.myDays,
      onSaved: (value) {
        if (value == null) return;
        setState(() {
          parkingData3.myDays = value;
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
          parkingData3.startTime = DateFormat('HH:mm').format(DateTimeField.convert(time))
            : parkingData3.endTime = DateFormat('HH:mm').format(DateTimeField.convert(time));
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
          parkingData3.price = priceController.text;
        });
      },
    );
  }

  List<Widget> page3Button() {
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
                    'Review',
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

//  void validateAndSubmit() async {
//    // check additional validators
//    if(!validateAndSave()){
//      setState(() {
//        formError.errorMessage = 'Make sure to fill out all required fields';
//        print(formError.errorMessage);
//      });
//    }
//  }

  // Validate form (page 3) -
  // if complete, go to next page; otherwise, set error message
  void validateAndSubmit() async {
    print("Calling validateAndSubmit");
    if(validateAndSave()){
      goToNextPage();
    }
    else{
      setState(() {
        formError.errorMessage = 'Make sure to fill out all required fields';
      });
    }
  }

  // Check individual form validators, go to next page
//  bool validateAndSave() {
//    final form = _formKey.currentState;
//    if (form.validate()) {
//      form.save();
//      if (formError.incomplete) {
//        return false;
//      }
//      Navigator.pushReplacementNamed(context, '/add_parking_review');
//      return true;
//    }
//    return false;
//  }

  // Confirm page 2 is complete and save the current state of the form.
  // 'Size' and 'Type' are not optional, so if these values have not been
  // selected, the form is still incomplete. Other fields may be left blank.
  bool validateAndSave() {
    var form = _formKey.currentState;
    if(!form.validate()) {
      formError.incomplete = true;
      return false;
    }

    formError.incomplete = false;
    form.save();
    return true;
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

  // Navigate to form review page (pass existing parkingData & curUser objects)
  void goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddParkingReview(
          title: widget.title,
          parkingData: widget.parkingData,
          parkingData2: widget.parkingData2,
          parkingData3: parkingData3,
          curUser: widget.curUser,
        ),
      ),
    );
  }
}