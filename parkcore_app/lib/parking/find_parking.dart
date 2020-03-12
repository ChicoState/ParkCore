import 'package:flutter/material.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkcore_app/src/locations.dart' as locations;

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
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
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
          _buildContainer(),
        ],
      )
    );
  }
    Widget _buildContainer(){
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        height: 400.0,
        child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _boxes(
              "https://www.architectureartdesigns.com/wp-content/uploads/2016/02/colored-brown-driveway-ozark-pattern-concrete-inc_67193-630x328.jpg",
              'large', 'Daily/Monthly Rental',"345 Spear Street, San Fransisco, CA 94105"),
          ),
          SizedBox(height: 20.0),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                "https://photos.zillowstatic.com/p_h/ISjzmcek2fr14c1000000000.jpg",
                'compact', 'Monthly Rental',"901 Cherry Avenue, San Bruno, CA 94066"),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _boxes(
              "https://odis.homeaway.com/odis/listing/58e3a7a2-6413-4825-932a-f4e75342f599.f6.jpg",
              'large', 'Daily Rental',"803 11th Avenue, Sunnyvale, CA 94089"),
          ),
          SizedBox(height: 20.0),
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: _boxes(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRWN_FTF_T7fPWk6BQG_tR0C3VTnz699Dpsy_VmGmBnqrk_j-ls",
            'compact', 'Daily/Monthly Rental', "1600 Amphitheatre Parkway, Chico, CA 94043"),
          ),
        ],
        )
      ),
    );
  }

Widget _googlemap(BuildContext context){

  return Container(
    child: GoogleMap(
      onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: const LatLng(39.7285, -121.8375),
          zoom: 7,
        ),
        markers: _markers.values.toSet(),
    )
  );
}

 Widget _boxes(String _image, String size, String term, String name){
    return GestureDetector(
      onTap: () {
          //_gotoLocation(lat,long);
      },
      child:Container(
        child: FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 20.0,
            borderRadius: BorderRadius.circular(14.0),
            shadowColor: Color(0x802196F3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 150,
                  height: 125,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(_image),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(name),
                        Text("Size: " + size),
                        Text(term),
                        Text("Available"),
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

}

