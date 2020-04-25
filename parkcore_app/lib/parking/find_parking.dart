import 'package:flutter/material.dart';
import 'package:geocoder/model.dart';
//import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:great_circle_distance2/great_circle_distance2.dart';
import 'package:parkcore_app/navigate/parkcore_button.dart';
import 'parking_details.dart';

class Spot{

  Spot.fromMap(Map<String, dynamic>map, {this.reference})
    : title = map['title'], address = map['address'], 
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

  ///This method is to deserialize your JSON
  ///Basically converting a string response to an object model
  ///Here key is always a String type and value can be of any type
  ///so we create a map of String and dynamic.

class FindParking extends StatefulWidget {
  FindParking({Key key, this.title, this.city, this.latlong}) : super(key: key);
  // This widget is the "find parking" page of the app. It is stateful: it has a
  // State object (defined below) that contains fields that affect how it looks.
  // This class is the configuration for the state. It holds the values (title)
  // provided by the parent (App widget) and used by the build method of the
  // State. Fields in a Widget subclass are always marked "final".

  final String title;
  final String city;
  final String latlong;

  @override
  _MyFindParkingState createState() => _MyFindParkingState();
}

class _MyFindParkingState extends State<FindParking> {
  final Map<MarkerId, Marker> _markers = {};
  List<Marker> allMarkers = [];
  bool pressed = false;
  bool isLoading = true;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    await Firestore.instance.collection('parkingSpaces')
      .getDocuments()
      .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) =>
        allMarkers.add(
          Marker(
            markerId: MarkerId('${f.data['title']}'),
            position: LatLng(
              num.parse(f.data['coordinates'].substring(1, f.data['coordinates'].indexOf(','))),
              num.parse(f.data['coordinates'].substring(f.data['coordinates'].indexOf(',') + 1,
                  f.data['coordinates'].length-1)),
            ),
            infoWindow: InfoWindow(title: '${f.data['title']}',
            snippet: '${f.data['zip']}'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('${f.data['title']}'),
                  content: Text('Want to know more about this location?'),
                  actions: [
                    FlatButton(
                      child: Text('Visit the details page for this spot'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              spot: Spot.fromSnapshot(f),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )
              );
            },
          ),
        ),
      );
    });
    setState(() {
      for(num i = 0; i < allMarkers.length; i++){
        _markers[allMarkers[i].markerId] = allMarkers[i];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        actions: <Widget>[
          LogoButton(),
        ],
      ),
      //drawer: MenuDrawer(),
      body: Stack(
        children: <Widget>[
          _googlemap(context),
          DistanceButton(),
          _buildBody(context),
        ],
      )
    );
  }

  Widget DistanceButton() {
    return Align(
      alignment: Alignment.topRight,
      child:
      Container(
        padding: EdgeInsets.all(5.0),
        width: 100,
        height: 70,
        child: RaisedButton(
          onPressed: () {
              setState(() {
                pressed = true;
              });
          },
          color: Color(0xFF4D2C91),
          child:  
          Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Text(
            'Show distance to CSU, Chico',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, color: Colors.white, letterSpacing: 1),
          ),
        ),
      )
    ));
  }

  Widget _googlemap(BuildContext context){
    return Container(
      child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              num.parse(widget.latlong.substring(1, widget.latlong.indexOf(','))),
              num.parse(widget.latlong.substring(widget.latlong.indexOf(',') + 1,
              widget.latlong.length-1)),
            ),
            zoom: 15,
          ),
          markers: _markers.values.toSet(),
      )
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        // stream: Firestore.instance.collection('parkingSpaces').snapshots(),
      stream: Firestore.instance.collection('parkingSpaces')
        .where('city', isEqualTo: widget.city)
        .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        if(snapshot.data.documents.isEmpty){
         return _noSpaces(context);
        }
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            height: MediaQuery.of(context).size.height/2,
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(top: 10.0),
              children: snapshot.map((data) => _buildListItem(context, data)).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget displayDistance(String coordinates){
    
    double adjustDistance(var i){
      if(i > 1){
        return i + i.floor()*.25;
      }
      else{
        return i;
      }
    }
    String haversize() {
      
      var lat = num.parse(coordinates.substring(1, coordinates.indexOf(',')));
      var long = num.parse(coordinates.substring(coordinates.indexOf(',') + 1, coordinates.length -1));
      
      final lat1 = 39.729918;
      final lon1 =  -121.849759;

      final lat2 = lat;
      final lon2 = long;

    var gcd = GreatCircleDistance.fromDegrees(
        latitude1: lat1, longitude1: lon1, latitude2: lat2, longitude2: lon2);

    /*print(
        'Distance from location 1 to 2 using the Haversine formula is: ${(adjustDistance((gcd.haversineDistance()/1609)*15))}');*/
    return(adjustDistance((gcd.haversineDistance()/1609))*25).round().toString();
    
    }

    return Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget> [
          Text(haversize() + ' Min' ?? 'null', style: TextStyle(fontSize: 15)),
          Icon(Icons.directions_walk, size: 20,)
        ]
      )
    );
  }
  

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {

    final parkingSpot = Spot.fromSnapshot(data);

    return Padding(
     padding: const EdgeInsets.all(8.0),
       child: GestureDetector(
         onTap: () {
           Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => DetailScreen(spot: parkingSpot),
            ),
          );
         },
         child: _boxes(parkingSpot.image, parkingSpot.title, parkingSpot.city,
           parkingSpot.state, parkingSpot.zip, parkingSpot.monthPrice, parkingSpot.type, parkingSpot.coordinates),
       )
    );
  }
  Widget _boxes(String image, String title, String city, String state, String zip, String monthprice, String type, String coordinates){

    var roundedPrice = (num.parse(monthprice)).round();

    return Container(
        child: FittedBox(
          child: Material(
            elevation: 20.0,
            borderRadius: BorderRadius.circular(14.0),
            shadowColor: Color(0x802196F3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(image ?? 'https://homestaymatch.com/images/no-image-available.png'),
                    ),
                  ),
                ),
                Container(
                  width: 275,
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(title ?? 'N/A', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0), textAlign: TextAlign.center),
                        Text(city + ', ' + state + ', ' + zip, style: TextStyle(fontSize: 15.0), textAlign: TextAlign.center),
                        Text(type ?? 'N/A', style: TextStyle(fontSize: 15.0), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                    children: <Widget>[
                    pressed ? displayDistance(coordinates) : SizedBox(),
                    Text('\$' + roundedPrice.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                    ])
                  ),
                )
                ],)
            ),
          ),
      );
  }

  Widget _noSpaces(BuildContext context){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        height: 110.0,
        color: Theme.of(context).backgroundColor.withOpacity(0.7),
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(top: 15.0),
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: ListTile(
                title: Row(
                  children: <Widget>[
                    Text(
                      "We're not yet in:\n" + widget.city +
                          "\nLet us know you're interested!",
                      style: Theme.of(context).textTheme.display3,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/contact');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}//end of parking space class
