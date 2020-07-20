import 'package:cloud_firestore/cloud_firestore.dart';

class Spot{

  Spot.fromMap(Map<String, dynamic>map, {this.reference})
      : title = map['title'],
        address = map['address'],
        amenities = map['amenities'],
        coordinates = map['coordinates'],
        city = map['city'],
        driveway = map['driveway'],
        monthPrice = map['monthprice'],
        spacetype = map['spacetype'],
        image = map['downloadURL'],
        type = map['type'],
        size = map['size'],
        days = map['days'],
        spacedetails = map['spacedetails'],
        starttime = map['starttime'],
        endtime = map['endtime'],
        state = map['state'],
        zip = map['zip'],
        uid = map['uid'];

  Spot.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  String title;
  String address;
  String amenities;
  String coordinates;
  String city;
  String driveway;
  String monthPrice;
  String spacetype;
  String image;
  String type;
  String size;
  String days;
  String spacedetails;
  String starttime;
  String endtime;
  String state;
  String zip;
  String uid;
  final DocumentReference reference;

}//end of class