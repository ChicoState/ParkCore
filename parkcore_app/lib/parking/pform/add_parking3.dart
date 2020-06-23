import 'package:flutter/material.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:parkcore_app/models/ParkingData.dart';
import 'package:parkcore_app/models/ParkingData2.dart';
import 'package:parkcore_app/models/ParkingData3.dart';
import 'pform_helpers.dart';
import 'add_parking_review.dart';

class AddParking3 extends StatefulWidget {
  AddParking3({
    Key key, this.parkingData, this.parkingData2, this.curUser
  }) : super(key: key);

  // This widget is the 'add parking' page of the app. It is stateful: it has a
  // State object (defined below) that contains fields that affect how it looks.
  // This class is the configuration for the state. It holds the values (title)
  // provided by the parent (App widget) and used by the build method of the
  // State. Fields in a Widget subclass are always marked 'final'.

  final ParkingData parkingData;
  final ParkingData2 parkingData2;
  final String curUser;

  @override
  _MyAddParking3State createState() => _MyAddParking3State();
}

class _MyAddParking3State extends State<AddParking3> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // parkingData3 params: days, start time, end time, price
  ParkingData3 parkingData3 = ParkingData3(null, '', '', '');
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
                : Text('Part 3 of 5'),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildAvailability(),
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
      SizedBox(height: 10),
      page3Button(),
      SizedBox(height: 10),
      restart(context),
    ];
  }

  // Page 3 Parking Form Widgets (Availability and Price)

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

  // Page3Button validates form input and navigates to page 4 of form
  Widget page3Button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        RaisedButton(
          onPressed: validateAndSubmit,
          child: Text(
            'Review',
            style: themeData.textTheme.headline4,
          ),
          color: themeData.accentColor,
        ),
      ],
    );
  }

  // Validate form (page 3) -
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

  // Confirm page 3 is complete and save the current state of the form.
  // 'Price' is not optional, so if this value has not been selected,
  // the form is still incomplete. Other fields may be left blank.
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

  // A controller (priceController) and keyboardType (TextInputType.number)
  // are used to ensure a valid USD amount is entered. Then validatePrice()
  // ensures that a month price has been chosen (default is 0.00)
  String validatePrice(String value) {
    if (value == '0.00') {
      return 'Value must be greater than \$0.00';
    }
    return null;
  }

  // Navigate to form review page (pass existing parkingData & curUser objects)
  void goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddParkingReview(
          parkingData: widget.parkingData,
          parkingData2: widget.parkingData2,
          parkingData3: parkingData3,
          curUser: widget.curUser,
        ),
      ),
    );
  }
}
