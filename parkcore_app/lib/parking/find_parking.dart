import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:parkcore_app/navigate/parkcore_button.dart';
import 'parking_details.dart';
//import 'filter_dialog.dart';

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
class DistanceMatrix {
  List<dynamic> destination_addresses;
  List<dynamic> origin_addresses;
  List<dynamic> rows;
  //String title;
  //String body;

  DistanceMatrix({
    this.destination_addresses,
    this.origin_addresses,
    this.rows,
    //this.body,
  });

  ///This method is to deserialize your JSON
  ///Basically converting a string response to an object model
  ///Here key is always a String type and value can be of any type
  ///so we create a map of String and dynamic.
  factory DistanceMatrix.fromJson(Map<String, dynamic> json) => DistanceMatrix(
    destination_addresses: json['destination_addresses'],
    origin_addresses: json['origin_addresses'],
    rows: json['rows'],
  );
}
DistanceMatrix responseFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return DistanceMatrix.fromJson(jsonData);
}

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
  List<DocumentSnapshot> current;
  // Variables below used for parking space filter options
  int numFilters = 0;
  final List<String> docType = ["size", "type", "monthprice", "amenities"];
  List<String> choice = ["none", "none", "none", "none", "none", "none", "none"];
  List<String> curFilter = ["All", "All", "All", "All"];
  String priceVal = "All";
  List<bool> selected = [false, false, false, false];
  List<String> amenity = ["Lit", "Covered", "Security Camera", "EV Charging"];
  bool _isVisible = false;
  Future<DistanceMatrix> futureAlbum;
  String tempOrigin = 'csuchico';
  String tempDestination = 'csuchico';
  String distanceApiKey = 'YOUR-API-KEY';

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
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen,),
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
                ),
              );
            },
          ),
        ),
      );
    });
    setState(() {
      for(int i = 0; i < allMarkers.length; i++){
        _markers[allMarkers[i].markerId] = allMarkers[i];
      }
    });
  }

  Future<DistanceMatrix> getMatrixResponse(String coordinates) async{

    final response = await http.get('https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=' + coordinates + '&destinations=' + tempDestination + '&mode=walking&key=' + distanceApiKey);
    if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //return DistanceMatrix.fromJson(json.decode(response.body));
      var result = DistanceMatrix.fromJson(json.decode(response.body));
      print("Distance matrix result: " + response.body);
      return result;
    } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
  }

  @override
  void initState() {
    super.initState();
    //futureAlbum = getMatrixResponse(tempOrigin);
    //futureAlbum = getMatrixResponse('39.7285,-121.8375');
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
      stream: Firestore.instance.collection('parkingSpaces')
        .where('city', isEqualTo: widget.city)
        .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        if(snapshot.data.documents.isEmpty){
         return _noSpaces(context);
        }

        if(numFilters > 0){
          List<DocumentSnapshot> filtered = snapshot.data.documents;
          var j = 0;
          for(var i = 0; i < choice.length; i++){
            if(i < 2){
              if(choice[i] != "none"){
                filtered = filtered.where((DocumentSnapshot docSnap) =>
                docSnap[docType[i]] == choice[i]).toList();
              }
            }
            else if(i == 2){
              if(choice[i] != "none"){
                filtered = filtered.where((DocumentSnapshot docSnap) =>
                double.parse(docSnap[docType[i]]) <= double.parse(choice[i])).toList();
              }
            }
            else{
              if(selected[j]){
                filtered = filtered.where((DocumentSnapshot docSnap) =>
                  docSnap[docType[3]].substring(1, docSnap[docType[3]].length-1)
                    .split(", ").contains(amenity[j])).toList();
              }
              j++;
            }
          }
          return _buildList(context, filtered);
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
              children: filterRow() +
                snapshot.map((data) => _buildListItem(context, data)).toList(),
            ),
          );
        },
      ),
    );
  }

  List<Widget> filterRow() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              children:[],
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Column(
              children: [
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      checkFilters();
                    });
                  },
                  child: Text(
                    'Apply Filters',
                    style: TextStyle(
                      fontFamily: 'Century Gothic',
                      fontSize: 16.0,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                SizeFilter(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                TypeFilter(),
              ],
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                PriceFilter(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: AmenitiesFilter(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      AmenityButtons(),
//      Visibility(
//        child: Row(
//          children: [
//            ToggleButtons(
//              children: [
//                Text("Lit"),
//                Text("Covered"),
//                Text("Security Camera"),
//                Text("EV Charging"),
//              ],
//              isSelected: selected,
//              onPressed: (int index) {
//                setState(() {
//                  selected[index] = !selected[index];
//                  print("Selected: " + selected.toString());
//                });
//              },
//              color: Colors.green[300],
//              selectedColor: Colors.green[900],
//              borderWidth: 5.0,
//              borderColor: Colors.green[300],
//              selectedBorderColor: Colors.green[900],
//            ),
//          ],
//        ),
//        visible: _isVisible,
//      ),
    ];
  }

  Widget SizeFilter(){
    return Container(
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.white60,
      ),
      child: ListTileTheme(
        textColor: Color(0xFF358D5B),
        child: ListTile(
          title: const Text(
            'Size',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: DropdownButton<String>(
            hint: Text('Choose'),
            onChanged: (String changedValue) {
              setState(() {
                curFilter[0] = changedValue;
              });
            },
            value: curFilter[0],
            items: <String>['All', 'Compact', 'Regular', 'Oversized']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            style: TextStyle(
              color: Color(0xFF358D5B),
            ),
          ),
        ),
      ),
    );
  }

  Widget TypeFilter(){
    return Container(
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.white60,
      ),
      child: ListTileTheme(
        textColor: Color(0xFF358D5B),
        child: ListTile(
          title: const Text(
            'Type',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: DropdownButton<String>(
            hint: Text('Choose'),
            onChanged: (String changedValue) {
              setState(() {
                curFilter[1] = changedValue;
              });
            },
            value: curFilter[1],
            items: <String>['All', 'Driveway', 'Parking Lot', 'Street']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            style: TextStyle(
              color: Color(0xFF358D5B),
            ),
          ),
        ),
      ),
    );
  }

  Widget PriceFilter(){
    return Container(
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.white60,
      ),
      child: ListTileTheme(
        textColor: Color(0xFF358D5B),
        child: ListTile(
          title: const Text(
            'Price',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: DropdownButton<String>(
            hint: Text('Choose'),
            onChanged: (String changedValue) {
              setState(() {
                if(changedValue == "All"){
                  curFilter[2] = changedValue;
                  priceVal = changedValue;
                }
                else{
                  curFilter[2] = changedValue.substring(1, changedValue.indexOf(' '));
                  priceVal = changedValue;
                }
              });
            },
            value: priceVal,
            items: <String>['All','\$25 or less', '\$50 or less',
              '\$75 or less', '\$100 or less'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            style: TextStyle(
              color: Color(0xFF358D5B),
            ),
          ),
        ),
      ),
    );
  }

  Widget AmenitiesFilter(){
    return FlatButton(
      onPressed: () {
        showAmenities();
        //getDialog();
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) => FilterDialogContent(
//              city: widget.city,
//              latlong: widget.latlong,
//              selected: widget.selected,
//            ),
//            //fullscreenDialog: true,
//          ),
//        );
      },
      child: Text(
        'Amenities',
        style: TextStyle(
          fontFamily: 'Century Gothic',
          fontSize: 16.0,
          color: Color(0xFF358D5B),
        ),
      ),
      color: Colors.white60,
    );
  }

  void showAmenities() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  Widget AmenityButtons() {
    return Visibility(
      child: Container(
        margin: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: Colors.white60,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ToggleButtons(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0),
                  child: Text("Lit"),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0),
                  child: Text("Covered"),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0),
                  child: Text("Security Camera"),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0),
                  child: Text("EV Charging"),
                ),
              ],
              isSelected: selected,
              onPressed: (int index) {
                setState(() {
                  selected[index] = !selected[index];
                  print("Selected: " + selected.toString());
                });
              },
              fillColor: Colors.green[50],
              color: Theme.of(context).backgroundColor,
              selectedColor: Color(0xFF358D5B),
              borderWidth: 1.5,
              borderColor: Theme.of(context).backgroundColor,
              selectedBorderColor: Color(0xFF358D5B),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ],
        ),
      ),
      visible: _isVisible,
    );
  }

//  Future<void> getDialog() async {
//    return showDialog<void>(
//      context: context,
//      //barrierDismissible: false, // user must tap button!
//      builder: (BuildContext context) {
//        return Container(
//          child: FilterDialogContent(),
//        );
//        return AlertDialog(
//          title: Text('Select Amenities'),
//          content: SingleChildScrollView(
//            child: FilterDialogContent(),
//            child: RotatedBox(
//              quarterTurns: 1,
//              child: ToggleButtons(
//                children: [
//                  RotatedBox(quarterTurns: 3, child: Text("Lit")),
//                  RotatedBox(quarterTurns: 3, child: Text("Covered")),
//                  RotatedBox(quarterTurns: 3, child: Text("Security Camera")),
//                  RotatedBox(quarterTurns: 3, child: Text("EV Charging")),
//                ],
//                isSelected: selected,
//                onPressed: (int index) {
//                  setState(() {
//                    selected[index] = !selected[index];
//                    print("Selected: " + selected.toString());
//                  });
//                },
//                color: Colors.green[300],
//                selectedColor: Colors.green[900],
//                borderWidth: 5.0,
//                borderColor: Colors.green[300],
//                selectedBorderColor: Colors.green[900],
//              ),
//            ),
//          ),
//          actions: <Widget>[
//            FlatButton(
//              child: Text('Return'),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }

  void checkFilters() {
    // re-initialize numFilters to 0
    numFilters = 0;

    // Iterate through filter options
    // If current filter was not requested, set choice[i] to none
    // Else, apply the requested filter and increment numFilters by 1
    for(var i = 0; i < curFilter.length; i++){
      if(curFilter[i] == "All") {
        choice[i] = "none";
      }
      else{
        choice[i] = curFilter[i];
        numFilters++;
      }
    }

    // Iterate through the amenities toggle buttons to see if any were selected
    for(var i = 0; i < selected.length; i++){
      if(selected[i]){
        numFilters++;
      }
    }
  }

  Widget _fetchDistance(String coordinates) {

    return FutureBuilder<DistanceMatrix>(
      future: getMatrixResponse(coordinates),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: <Widget> [
                Text(snapshot.data.rows[0]['elements'][0]['duration']['text'] ?? 'null',style: TextStyle(fontSize: 15)),
                Icon(Icons.directions_walk, size: 20,)
              ]
            )
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return SizedBox(
          height: 15,
          width: 15,
          child:CircularProgressIndicator()
        );
      },
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
                   // _fetchDistance(coordinates.substring(1,coordinates.length-1)),
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
                      "We're not yet in\n" + widget.city +
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

//class FilterDialogContent extends StatefulWidget {
//  FilterDialogContent({Key key, this.city, this.latlong, this.selected}): super(key: key);
//
//  final String city;
//  final String latlong;
//  final List<bool> selected;
//
//  @override
//  _DialogContentState createState() => _DialogContentState();
//}
//
//class _DialogContentState extends State<FilterDialogContent> {
//
//  //List<bool> curSelected = [false, false, false, false];
//
//  @override
//  void initState(){
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//      return AlertDialog(
//        title: Text('Select Amenities'),
//        content: SingleChildScrollView(
//          child: RotatedBox(
//            quarterTurns: 1,
//            child: ToggleButtons(
//              children: [
//                RotatedBox(quarterTurns: 3, child: Text("Lit")),
//                RotatedBox(quarterTurns: 3, child: Text("Covered")),
//                RotatedBox(quarterTurns: 3, child: Text("Security Camera")),
//                RotatedBox(quarterTurns: 3, child: Text("EV Charging")),
//              ],
//              isSelected: widget.selected,
//              onPressed: (int index) {
//                setState(() {
//                  widget.selected[index] = !widget.selected[index];
//                  print("Selected: " + widget.selected.toString());
//                });
//              },
//              color: Colors.green[300],
//              selectedColor: Colors.green[900],
//              borderWidth: 5.0,
//              borderColor: Colors.green[300],
//              selectedBorderColor: Colors.green[900],
//            ),
//          ),
//        ),
//        actions: <Widget>[
//          FlatButton(
//            child: Text('Return'),
//            onPressed: () {
//              //Navigator.of(context).pop(curSelected);
//              Navigator.pop(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => FindParking(
//                    title: 'Find Parking',
//                    city: widget.city,
//                    latlong: widget.latlong,
//                    selected: widget.selected,
//                  ),
//                ),
//              );
////              Navigator.pop(
////                context,
////                MaterialPageRoute(
////                  builder: (context) => FindParking(
////                    title: 'Find Parking',
////                    city: widget.city,
////                    latlong: _coordinates == null ?
////                    '{39.7285,-121.8375}' : _coordinates,
////                    selected: curSelected,
////                  ),
////                ),
////              );
//            },
//          ),
//        ],
//      );
////    return RotatedBox(
////      quarterTurns: 1,
////      child: ToggleButtons(
////        children: [
////          RotatedBox(quarterTurns: 3, child: Text("Lit")),
////          RotatedBox(quarterTurns: 3, child: Text("Covered")),
////          RotatedBox(quarterTurns: 3, child: Text("Security Camera")),
////          RotatedBox(quarterTurns: 3, child: Text("EV Charging")),
////        ],
////        isSelected: curSelected,
////        onPressed: (int index) {
////          setState(() {
////            curSelected[index] = !curSelected[index];
////            print("Selected: " + curSelected.toString());
////          });
////        },
////        color: Colors.green[300],
////        selectedColor: Colors.green[900],
////        borderWidth: 5.0,
////        borderColor: Colors.green[300],
////        selectedBorderColor: Colors.green[900],
////      ),
////    );
//  }
//}
