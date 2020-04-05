import 'package:flutter/material.dart';
import 'dart:async';
import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'find_parking.dart';

/*class User {

  User.fromMap(Map<String, dynamic>map, {this.reference})
  : uid = map['uid'],
  displayName = map['displayName'],
  email = map['email'],
  photoURL = map['photoURL'];

  User.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);

  String uid;
  String displayName;
  String email;
  String photoURL;
  final DocumentReference;

}*/

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Spot spot;

  // In the constructor, require a Todo.
  DetailScreen({Key key, @required this.spot}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        elevation: 10,
        leading: Builder(
          builder: (BuildContext context){
            return IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        )
      ),
      body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: 
          _detailsBody(),
      ),
      bottomNavigationBar: bottomAppBar()
    );
  }

  Widget bottomAppBar () {
    
    return BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('\$' + spot.monthPrice + '/month')
              ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
              color: Colors.purple[100],
              padding: EdgeInsets.all(15.0),
              onPressed: () {},
              child: Text('Reserve'),
              )
            ),
          ],
        )
    );
  }

  Widget _detailsBody () {

    return Container(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Image(
              image: NetworkImage(spot.image ?? 'https://homestaymatch.com/images/no-image-available.png'),
              width: 100,
              height: 225,
              fit: BoxFit.cover,
            )
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(spot.title ?? 'none', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30))
          ),
          Row(
            children: <Widget>[   
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.location_city),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(spot.city + ' ' + spot.state + ' , ' + spot.zip),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text('test'),
                ),
                Container(
                  width: 80,
                  height: 50,
                  margin: const EdgeInsets.only(left: 100.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage('https://img.favpng.com/6/14/19/computer-icons-user-profile-icon-design-png-favpng-vcvaCZNwnpxfkKNYzX3fYz7h2.jpg'),
                    ),
                  ),
                ),
            ],
          ),
          Row(
            children: <Widget>[   
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.directions_car ),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(spot.driveway + ', ' + spot.size + ', ' + spot.type + ', ' + spot.spacetype),
                ),
            ],
          ),
          Row(
            children: <Widget>[   
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.security),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(spot.amenities.substring(1, spot.amenities.length-1)),
                ),
            ],
          ),
          Row(
            children: <Widget>[   
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.timelapse),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text('Availability:' + spot.starttime + ' - ' + spot.endtime),
                ),
            ],
          ),
          Row(
            children: <Widget>[   
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.calendar_today),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(spot.days.substring(1, spot.days.length-1)),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Space Details')
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(spot.spacedetails)
          ),
        ],
      ),
    );
  }//_detailsBody
}