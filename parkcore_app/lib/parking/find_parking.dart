import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:great_circle_distance2/great_circle_distance2.dart';
import 'package:parkcore_app/navigate/parkcore_button.dart';
import 'parking_details.dart';
import 'package:parkcore_app/models/Spot.dart';

  ///This method is to deserialize your JSON
  ///Basically converting a string response to an object model
  ///Here key is always a String type and value can be of any type
  ///so we create a map of String and dynamic.

class FindParking extends StatefulWidget {
  FindParking({Key key, this.title, this.city, this.latlong}) : super(key: key);
  // This widget is the 'find parking' page of the app. It is stateful: it has a
  // State object (defined below) that contains fields that affect how it looks.
  // This class is the configuration for the state. It holds the values (title)
  // provided by the parent (App widget) and used by the build method of the
  // State. Fields in a Widget subclass are always marked 'final'.

  final String title;
  final String city;
  final String latlong;

  @override
  _MyFindParkingState createState() => _MyFindParkingState();
}

class _MyFindParkingState extends State<FindParking> {
  final Map<MarkerId, Marker> _markers = {};
  List<Marker> allMarkers = [];

  // Variables below used for parking space filter options
  int numFilters = 0;
  final List<String> docType = ['size', 'type', 'monthprice', 'amenities'];
  List<String> choice = ['none', 'none', 'none', 'none', 'none', 'none', 'none'];
  List<String> curFilter = ['All', 'All', 'All', 'All'];
  String priceVal = 'All';
  List<bool> selected = [false, false, false, false];
  List<String> amenity = ['Lit', 'Covered', 'Security Camera', 'EV Charging'];
  List<String> sizeOptions = ['All', 'Compact', 'Regular', 'Oversized'];
  List<String> typeOptions = ['All', 'Driveway', 'Parking Lot', 'Street'];
  List<String> priceOptions = ['All','\$25 or less', '\$50 or less',
                              '\$75 or less', '\$100 or less'];
  bool _isVisible = false;
  bool pressed = false;

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
                ),
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
      stream: Firestore.instance.collection('parkingSpaces')
        .where('city', isEqualTo: widget.city)
        .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        if(snapshot.data.documents.isEmpty){
          return _noSpaces(context);
        }

        // If filter options are chosen, update the list of parking spaces shown
        if(numFilters > 0){
          //List<DocumentSnapshot>
          var filtered = snapshot.data.documents;
          for(var i = 0; i < choice.length; i++){
            if(i < 2){ // Type or Size filter
              if(choice[i] != 'none'){
                filtered = filtered.where((DocumentSnapshot docSnap) =>
                docSnap[docType[i]] == choice[i]).toList();
              }
            }
            else if(i == 2){ // Price filter
              if(choice[i] != 'none'){
                filtered = filtered.where((DocumentSnapshot docSnap) =>
                double.parse(docSnap[docType[i]]) <= double.parse(choice[i])).toList();
              }
            }
            else{ // Amenities filters (i >= 3)
              if(choice[i] != 'none'){
                filtered = filtered.where((DocumentSnapshot docSnap) =>
                  docSnap[docType[3]].substring(1, docSnap[docType[3]].length-1)
                    .split(', ').contains(choice[i])).toList();
              }
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

  // Show filter options in row above the list of parking spaces
  List<Widget> filterRow() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Column(
              children:[],
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              children:[
                FiltersButton('Apply Filters', true),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Column(
              children: [
                FiltersButton('Show All', false),
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
    ];
  }

  // Apply or remove filters as selected
  Widget FiltersButton(String txt, bool apply){
    return RaisedButton(
      onPressed: () {
        setState(() {
          apply ? checkFilters() : showAll();
        });
      },
      child: Text(
        txt,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).backgroundColor,
        ),
      ),
      color: Colors.white,
      highlightColor: Theme.of(context).accentColor,
    );
  }

  // show all listed parking spaces at this location (clear all selected)
  void showAll(){
    numFilters = 0;
    for(var i = 0; i < curFilter.length; i++){
      curFilter[i] = 'All';
      selected[i] = false;
    }
  }

  // Get the dropdown menu items for the given filter option
  List<DropdownMenuItem<String>> getFilterOptions(List<String> options){
    return options.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  // Select 1 size filter option from dropdown list
  Widget SizeFilter(){
    return Container(
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.white60,
      ),
      child: ListTileTheme(
        child: ListTile(
          title: Text(
            'Size',
            style: Theme.of(context).textTheme.headline5,
          ),
          trailing: DropdownButton<String>(
            hint: Text('Choose'),
            onChanged: (String changedValue) {
              setState(() {
                curFilter[0] = changedValue;
              });
            },
            value: curFilter[0],
            items: getFilterOptions(sizeOptions),
            style: TextStyle(
              color: Color(0xFF358D5B),
            ),
          ),
        ),
      ),
    );
  }

  // Select 1 Type filter option from dropdown list
  Widget TypeFilter(){
    return Container(
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.white60,
      ),
      child: ListTileTheme(
        child: ListTile(
          title: Text(
            'Type',
            style: Theme.of(context).textTheme.headline5,
          ),
          trailing: DropdownButton<String>(
            hint: Text('Choose'),
            onChanged: (String changedValue) {
              setState(() {
                curFilter[1] = changedValue;
              });
            },
            value: curFilter[1],
            items: getFilterOptions(typeOptions),
            style: TextStyle(
              color: Color(0xFF358D5B),
            ),
          ),
        ),
      ),
    );
  }

  // Select 1 Price filter option from dropdown list
  Widget PriceFilter(){
    return Container(
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.white60,
      ),
      child: ListTileTheme(
        child: ListTile(
          title: Text(
            'Price',
            style: Theme.of(context).textTheme.headline5,
          ),
          trailing: DropdownButton<String>(
            hint: Text('Choose'),
            onChanged: (String changedValue) {
              setState(() {
                if(changedValue == 'All'){
                  curFilter[2] = changedValue;
                  priceVal = changedValue;
                }
                else{
                  curFilter[2] = changedValue.substring(1, changedValue.indexOf(' '));
                  priceVal = changedValue;
                }
              });
            },
            value: curFilter[2] == 'All' ? curFilter[2] : priceVal,
            items: getFilterOptions(priceOptions),
            style: TextStyle(
              color: Color(0xFF358D5B),
            ),
          ),
        ),
      ),
    );
  }

  // Button to show/hide amenity filter options
  // (option to select multiple)
  Widget AmenitiesFilter(){
    return FlatButton(
      onPressed: () {
        setState(() {
          _isVisible = !_isVisible;
        });
      },
      child: Text(
        'Amenities',
        style: Theme.of(context).textTheme.headline5,
      ),
      color: Colors.white60,
    );
  }

  // Toggle Buttons for filtering amenities (visible when Amenities is clicked)
  // Can toggle options on and off without changing list, current choices are
  // applied when the Apply Filters button is clicked
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
                  child: selected[0] ? Icon(Icons.lightbulb_outline):Text('Lit'),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0),
                  child: selected[1] ? Icon(Icons.beach_access): Text('Covered'),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0),
                  child: selected[2] ? Icon(Icons.videocam): Text('Security Camera'),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0),
                  child: selected[3] ? Icon(Icons.battery_charging_full): Text('EV Charging'),
                ),
              ],
              isSelected: selected,
              onPressed: (int index) {
                setState(() {
                  selected[index] = !selected[index];
                  print('Selected: ' + selected.toString());
                });
              },
              color: Theme.of(context).backgroundColor,
              borderColor: Theme.of(context).backgroundColor,
              selectedColor: Color(0xFF358D5B),
              selectedBorderColor: Color(0xFF358D5B),
              highlightColor: Color(0xFF99F1B8),
              fillColor: Colors.white,
              borderWidth: 1.5,
              borderRadius: BorderRadius.circular(5.0),
            ),
          ],
        ),
      ),
      visible: _isVisible,
    );
  }

  // When Apply Filters button is clicked, reset filter parameters
  void checkFilters() {
    // re-initialize numFilters to 0
    numFilters = 0;

    // Iterate through filter options
    // If current filter was not requested, set corresponding choice to none
    // Else, apply the requested filter and increment numFilters
    for(var i = 0; i < curFilter.length; i++){
      if(curFilter[i] == 'All') {
        choice[i] = 'none';
      }
      else{
        choice[i] = curFilter[i];
        numFilters++;
      }
    }

    // Iterate through the amenities toggle buttons to see if any were selected
    // If amenity not selected, set corresponding choice to none
    // Else, apply the requested amenity filter and increment numFilters
    for(var i = 0; i < selected.length; i++){
      if(!selected[i]){
        choice[i+3] = 'none';
      }
      else{
        choice[i+3] = amenity[i];
        numFilters++;
      }
    }
  }

  double adjustDistance(var i){
    if(i > 1){
      return i + i.floor()*.25;
    }
    else{
      return i;
    }
  }

  String haversize(coordinates) {

    var lat = num.parse(coordinates.substring(1, coordinates.indexOf(',')));
    var long = num.parse(coordinates.substring(coordinates.indexOf(',') + 1, coordinates.length -1));

    final lat1 = 39.729918;
    final lon1 =  -121.849759;

    final lat2 = lat;
    final lon2 = long;

    var gcd = GreatCircleDistance.fromDegrees(
      latitude1: lat1, longitude1: lon1, latitude2: lat2, longitude2: lon2);

    return(adjustDistance((gcd.haversineDistance()/1609))*25).round().toString();

  }

  Widget displayDistance(String coordinates){

    return Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget> [
          Text(haversize(coordinates) + ' Min' ?? 'null', style: TextStyle(fontSize: 15)),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _noSpaces(BuildContext context){
    return Align(
      key: Key('nospaces'),
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
                      'We\'re not yet in\n' + widget.city +
                          '\nLet us know you\'re interested!',
                      style: Theme.of(context).textTheme.headline4,
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
