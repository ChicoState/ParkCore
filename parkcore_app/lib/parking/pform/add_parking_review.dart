import 'package:flutter/material.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:parkcore_app/models/ParkingData.dart';
import 'package:parkcore_app/models/ParkingData2.dart';
import 'package:parkcore_app/models/ParkingData3.dart';
import 'package:parkcore_app/models/CurrentUser.dart';
import 'pform_helpers.dart';
import 'add_parking_submit.dart';

class AddParkingReview extends StatefulWidget {
  AddParkingReview({Key key,
    this.parkingData, this.parkingData2, this.parkingData3, this.curUser
  }) : super(key: key);

  // This widget is the 'add parking' page of the app. It is stateful: it has a
  // State object (defined below) that contains fields that affect how it looks.
  // This class is the configuration for the state. It holds the values (title)
  // provided by the parent (App widget) and used by the build method of the
  // State. Fields in a Widget subclass are always marked 'final'.

  final ParkingData parkingData;
  final ParkingData2 parkingData2;
  final ParkingData3 parkingData3;
  final CurrentUser curUser;

  @override
  _MyAddParkingReviewState createState() => _MyAddParkingReviewState();
}

class _MyAddParkingReviewState extends State<AddParkingReview> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
              Text('Part 4 of 5'),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: review(),
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
      Text('Size: ' + widget.parkingData2.size),
      Text('Type: ' + widget.parkingData2.type),
      Text('Driveway: ' + widget.parkingData2.driveway),
      Text('Space Type: ' + widget.parkingData2.spaceType),
      Text('Amenities: ' + widget.parkingData2.myAmenities.toString()),
      Text('Additional Details: ' + widget.parkingData2.details),
      Text('Days Available: ' + widget.parkingData3.myDays.toString()),
      Text('Available Starting at: ' + widget.parkingData3.startTime),
      Text('Available Until: ' + widget.parkingData3.endTime),
      Text('Price per month: \$' + widget.parkingData3.price),
      SizedBox(height: 10),
      Text('Additional info connected to this parking space:'),
      Text('Parking Space Owner: ' + getUserName(widget.curUser.currentUser)),
      Text('Parking Space Coordinates: ' + widget.parkingData.coordinates),
      SizedBox(height: 10),
      pageReviewButton(),
      SizedBox(height: 10),
      restart(context),
    ];
  }

  Widget pageReviewButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        RaisedButton(
          onPressed: goToNextPage,
          child: Text(
            'Add Image & Submit',
            style: themeData.textTheme.headline4,
          ),
          color: themeData.accentColor,
        ),
      ],
    );
  }

  // Navigate to form review page (pass existing parkingData & curUser objects)
  void goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddParkingSubmit(
          parkingData: widget.parkingData,
          parkingData2: widget.parkingData2,
          parkingData3: widget.parkingData3,
          curUser: widget.curUser,
        ),
      ),
    );
  }
}
