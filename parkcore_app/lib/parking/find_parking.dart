import 'package:flutter/material.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//this the original 
class Spot{

//Spot(String title, String address, String amentities, String coordinates, String city, String driveway, String monthPrice,
  //String spacetype,
  //String image,
  //String type);

  Spot.fromMap(Map<String, dynamic>map, {this.reference})
    : title = map['title'], address = map['address'], 
    amentities = map['amentities'],
    coordinates = map['coordinates'],
    city = map['city'], 
    driveway = map['driveway'],
    monthPrice = map['monthPrice'],
    spacetype = map['spacetype'],
    image = map['downloadURL'],
    type = map['type'];

  Spot.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);
  
  String title;
  String address;
  String amentities;
  String coordinates;
  String city;
  String driveway;
  String monthPrice;
  String spacetype;
  String image;
  String type;
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

    await Firestore.instance.collection("parkingSpaces")
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
  /*Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }*/

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
     key: ValueKey(parkingSpot.address),
     padding: const EdgeInsets.all(8.0),
       child: _boxes(parkingSpot.image, parkingSpot.title, parkingSpot.amentities, parkingSpot.coordinates, parkingSpot.city,
       parkingSpot.driveway, parkingSpot.monthPrice, parkingSpot.spacetype, parkingSpot.type) 
    );
 }

 Widget _boxes(String image, String title, String amentities, String coordinates, String city, String driveway, String monthprice, String spacetype, String type){
    
    /*var commaPos = coordinates.indexOf(',');
    double lat = num.parse(coordinates.substring(1, commaPos));
    double long = num.parse(coordinates.substring(commaPos + 1, coordinates.length-1));
    */
    
    return GestureDetector(
      onTap: () {
          //_gotoLocation(lat,long);
      },
      child:Container(
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
                  height: 75,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(image ?? "https://homestaymatch.com/images/no-image-available.png"),
                    ),
                  ),
                ),
                Container(
                  width: 275,
                  //height: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(title ?? "N/A", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        //Text(amentities ?? "N/A", textAlign: TextAlign.center),
                        Text("City: " + city ?? "N/A", textAlign: TextAlign.center),
                        //Text(coordinates ?? "N/A", textAlign: TextAlign.center),
                        //Text(driveway ?? "N/A", textAlign: TextAlign.center),
                        //Text("Price: " + monthprice ?? "N/A", textAlign: TextAlign.right),
                        Text("Space type: " + spacetype ?? "N/A", textAlign: TextAlign.center),
                        Text(type ?? "N/A", textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                  ),
                ],)
            ),
          ),
        ),
      );
  }
}//end of parking space class
