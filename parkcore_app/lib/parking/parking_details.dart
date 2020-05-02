import 'package:flutter/material.dart';
//import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parkcore_app/parking/find_parking.dart';
import 'package:parkcore_app/navigate/parkcore_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Users {
  Users.fromMap(Map<String, dynamic>map, {this.reference})
  : displayName = map['displayName'],
  photoURL = map['photoURL'],
  uid = map['uid'],
  rating = map['rating'];

  Users.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);

  String displayName;
  String photoURL;
  String uid;
  num rating;
  final DocumentReference reference;
}

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Todo.
  DetailScreen({Key key, @required this.spot}) : super(key: key);

  // Declare a field that holds the Todo.
  final Spot spot;

  //StarRating({this.starCount = 5, this.rating = .0, this.onRatingChanged, this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
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
        ),
        actions: <Widget>[
          LogoButton(),
        ],
      ),
      body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: 
          _detailsBody(context),
      ),
      bottomNavigationBar: bottomAppBar()
    );
  }

  Widget bottomAppBar () {

    var roundedPrice = (num.parse(spot.monthPrice)).round();

    return BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('\$' + roundedPrice.toString() + '/month')
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

  Widget _detailsBody(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('users').where('uid', isEqualTo: spot.uid).snapshots(),
      builder: (context, snapshot) {
       if (!snapshot.hasData) return LinearProgressIndicator();

       return _details(context, snapshot.data.documents[0]);
     },
    );
  }
  Widget _details(BuildContext context, DocumentSnapshot data) {

    final currentUser = Users.fromSnapshot(data);

    bool check(String string){
      if(string == 'N/A' || string == '[]' || string == ''){
        return false;
      }
      return true;
    }
    bool checkDriveway(String string){
      if(string == 'Driveway'){
        return true;
      }
      return false;
    }

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
            child: Text(spot.title, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30))
          ),
          Row(
            children: <Widget>[   
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.location_city),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(spot.city + ' ' + spot.state + ', ' + spot.zip),
                ),
                Container(
                  padding: EdgeInsets.only(left: 80.0, top: 5.0),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                   ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image(
                      fit: BoxFit.cover,
                      width: 50,
                      image: NetworkImage(currentUser.photoURL ?? 'https://img.favpng.com/6/14/19/computer-icons-user-profile-icon-design-png-favpng-vcvaCZNwnpxfkKNYzX3fYz7h2.jpg'),
                      ),
                    ),
                    Text(currentUser.displayName),
                    RatingBar(
                      itemSize: 20,
                      initialRating: currentUser.rating.toDouble(),
                      unratedColor: Colors.purple[100],
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => Icon(
                      Icons.star,
                       color: Colors.purple[400],
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                        currentUser.reference.updateData({'rating': rating });
                      },
                    )
                  ]
                )),
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
                  child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    check(spot.type) ? Text('Spot type: ' + spot.type): SizedBox(),
                    check(spot.spacetype) ? Text(spot.spacetype): SizedBox(),
                    checkDriveway(spot.type) ? Text(spot.driveway + ' driveway'): SizedBox(),
                    check(spot.size)? Text('Size: ' + spot.size): SizedBox(),
                  ],
                )
              ),
            ],
          ),
          check(spot.amenities) ? Row(
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
          ) : SizedBox(),
          check(spot.starttime) || check(spot.endtime) ? Row(
            children: <Widget>[   
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.timelapse),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text('Availability: ' + spot.starttime + ' - ' + spot.endtime),
                ),
            ],
          ): SizedBox(),
          check(spot.days) ? Row(
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
          ) : SizedBox(),
          check(spot.spacedetails) ? Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Space Details')
          ) : SizedBox(),
          check(spot.spacedetails) ? Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(spot.spacedetails)
          ) : SizedBox(),
        ],
      ),
    );
  }//_detailsBody
} 