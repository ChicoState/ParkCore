import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:parkcore_app/navigate/parkcore_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:parkcore_app/models/Spot.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key, @required this.spot, this.colRef }) : super(key: key);
  // This widget is the 'detail screen' page of the app. It is stateful: it has a
  // State object (defined below) that contains fields that affect how it looks.
  // This class is the configuration for the state. It holds the values (title)
  // provided by the parent (App widget) and used by the build method of the
  // State. Fields in a Widget subclass are always marked 'final'.

  // Declare a field that holds the Todo.
  final Spot spot;
  final CollectionReference colRef;

  @override
  _MyDetailScreenState createState() => _MyDetailScreenState();
}

class _MyDetailScreenState extends State<DetailScreen> {
//class DetailScreen extends StatelessWidget {

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

    var roundedPrice = (num.parse(widget.spot.monthPrice)).round();

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
    if(widget.spot.uid == 'no current user'){
      return _details(context, null);
    }

    return StreamBuilder<QuerySnapshot>(
      stream: widget.colRef.where('uid', isEqualTo: widget.spot.uid).snapshots(),
      //stream: Firestore.instance.collection('users').where('uid', isEqualTo: spot.uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _details(context, snapshot.data.documents[0]);
      },
    );
  }

  Widget _details(BuildContext context, DocumentSnapshot data) {

    //final currentUser = Users.fromSnapshot(data);
    var currentUser;
    var userExists = false;
    if(data != null){
      currentUser = Users.fromSnapshot(data);
      userExists = true;
    }

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
            key: Key('spotimage'),
            padding: EdgeInsets.only(bottom: 10.0),
            child: userExists && widget.spot.image != null
            ? FadeInImage.assetNetwork(
              //image: NetworkImage(spot.image ?? 'https://homestaymatch.com/images/no-image-available.png'),
              placeholder: 'assets/parkcore_logo_green2.jpg',
              image: widget.spot.image,
              width: 100,
              height: 225,
              fit: BoxFit.cover,
            )
            : Opacity(
              opacity: 0.2,
              child: SvgPicture.asset(
                'assets/Acorns.svg',
                height: 225,
                fit: BoxFit.cover,
                semanticsLabel: 'Acorns image',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              widget.spot.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          Row(
            children: <Widget>[   
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.location_city),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(widget.spot.city + ' ' + widget.spot.state + ', ' + widget.spot.zip),
                ),
                Container(
                  padding: EdgeInsets.only(left: 80.0, top: 5.0),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ClipRRect(
                      key: Key('ownerimage'),
                      borderRadius: BorderRadius.circular(50.0),
                      child: userExists && currentUser.photoURL != null
                      ? Image(
                        fit: BoxFit.cover,
                        width: 50,
                        //image: NetworkImage(currentUser.photoURL ?? 'https://img.favpng.com/6/14/19/computer-icons-user-profile-icon-design-png-favpng-vcvaCZNwnpxfkKNYzX3fYz7h2.jpg'),
                        image: NetworkImage(currentUser.photoURL),
                      )
                      : Image(
                        fit: BoxFit.cover,
                        width: 50,
                        image: AssetImage('assets/parkcore_logo_green2.jpg'),
                      ),
                    ),
                    Text(userExists ? currentUser.displayName : 'Name Withheld'),
                    Row(
                      children: <Widget>[
                        RatingBar(
                          itemSize: 20,
                          initialRating: userExists ? currentUser.rating.toDouble() : 0.0,
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
                          //These changes can be added for specific users who can rate
                          onRatingUpdate: (rating) {
//                        print(rating);
//                        currentUser.reference.updateData({'rating': rating });
                          },
                        ),
                        SizedBox(width: 2.0),
                        Text(userExists ?
                          currentUser.rating.toDouble().toString() : '0.0',
                        ),
                      ],
                    ),
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
                    check(widget.spot.type) ? Text('Spot type: ' + widget.spot.type): SizedBox(),
                    check(widget.spot.spacetype) ? Text(widget.spot.spacetype): SizedBox(),
                    checkDriveway(widget.spot.type) ? Text(widget.spot.driveway + ' driveway'): SizedBox(),
                    check(widget.spot.size)? Text('Size: ' + widget.spot.size): SizedBox(),
                  ],
                )
              ),
            ],
          ),
          check(widget.spot.amenities) ? Row(
            children: <Widget>[   
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.security),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(widget.spot.amenities.substring(1, widget.spot.amenities.length-1)),
                ),
            ],
          ) : SizedBox(key: Key('amenitiesSizedBox')),
          check(widget.spot.starttime) || check(widget.spot.endtime) ? Row(
            children: <Widget>[   
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.timelapse),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text('Availability: ' + widget.spot.starttime + ' - ' + widget.spot.endtime),
                ),
            ],
          ): SizedBox(key: Key('timeSizedBox')),
          check(widget.spot.days) ? Row(
            children: <Widget>[   
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.calendar_today),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(widget.spot.days.substring(1, widget.spot.days.length-1)),
                ),
            ],
          ) : SizedBox(key: Key('daysSizedBox')),
          check(widget.spot.spacedetails) ? Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Space Details')
          ) : SizedBox(key: Key('detailsTitleBox')),
          check(widget.spot.spacedetails) ? Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(widget.spot.spacedetails)
          ) : SizedBox(key: Key('spaceDetailsBox')),
        ],
      ),
    );
  }//_detailsBody
} 