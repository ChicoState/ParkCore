import 'package:flutter/material.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    zip = map['zip'];


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
  final DocumentReference reference;

}//end of class

class FindParking extends StatefulWidget {
  FindParking({Key key, this.title}) : super(key: key);
  // This widget is the "find parking" page of the app. It is stateful: it has a
  // State object (defined below) that contains fields that affect how it looks.
  // This class is the configuration for the state. It holds the values (title)
  // provided by the parent (App widget) and used by the build method of the
  // State. Fields in a Widget subclass are always marked "final".

  final String title;
  

  @override
  _MyFindParkingState createState() => _MyFindParkingState();
}

class _MyFindParkingState extends State<FindParking> {
  final Map<MarkerId, Marker> _markers = {};
  List<Marker> allMarkers = [];
  
Future<void> _onMapCreated(GoogleMapController controller) async {

    await Firestore.instance.collection('parkingSpaces')
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f) => 

    allMarkers.add(
      Marker(
        
        markerId: MarkerId('${f.data['title']}'),
        position: LatLng(num.parse(f.data['coordinates'].substring(1, f.data['coordinates'].indexOf(','))), num.parse(f.data['coordinates'].substring(f.data['coordinates'].indexOf(',') + 1, f.data['coordinates'].length-1))),
        infoWindow: InfoWindow(title: '${f.data['title']}',
        snippet: '${f.data['address']}'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen,),

      )
    )
    );
  });
  setState(() {
    for(int i = 0; i < allMarkers.length; i++){
      
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
          ),
      drawer: MenuDrawer(),
      body: Stack(
        children: <Widget>[
          _googlemap(context),
          _buildBody(context),
        ],
      )
    );
  }
  Widget _googlemap(BuildContext context){

  return Container(
    child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: const LatLng(39.7285, -121.8375),
          zoom: 15,
        ),
        markers: _markers.values.toSet(),
    )
  );
}

  Widget _buildBody(BuildContext context) {
   return StreamBuilder<QuerySnapshot>(
     stream: Firestore.instance.collection('parkingSpaces').snapshots(),
     builder: (context, snapshot) {
       if (!snapshot.hasData) return LinearProgressIndicator();

       return _buildList(context, snapshot.data.documents);
     },
   );
 }

 Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
   return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        height: 400.0, 
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(top: 20.0),
          children: snapshot.map((data) => _buildListItem(context, data)).toList(),
        )
      )
   );
 }

 Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
   
   final parkingSpot = Spot.fromSnapshot(data);
   
   return Padding(
     //key: ValueKey(parkingSpot.address),
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
         child: _boxes(parkingSpot.image, parkingSpot.title, parkingSpot.city, parkingSpot.state, parkingSpot.zip,
       parkingSpot.monthPrice, parkingSpot.type) 
       )
    );
 }

 Widget _boxes(String image, String title, String city, String state, String zip, String monthprice, String type){
    
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
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(title ?? 'N/A', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0), textAlign: TextAlign.center),
                        Text(city + ', ' + state + ', ' + zip, style: TextStyle(fontSize: 15.0), textAlign: TextAlign.center),
                        Text(type ?? 'N/A', style: TextStyle(fontSize: 15.0), textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                  ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text('\$' + monthprice, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                  ),
                )
                ],)
            ),
          ),
      );
  }
}//end of parking space class
