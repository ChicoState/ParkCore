// Parking Space Data (page 1 of parking space form)
// title, address, user id, and associated coordinates
class ParkingData {
  ParkingData(
    this.title,
    this.address,
    this.city,
    this.state,
    this.zip,
    this.uid,
    this.coordinates,
    this.coord_rand,
  );

  String title = '';
  String address = '';
  String city = '';
  String city_format = '';
  String state = '';
  String zip = '';
  String uid = ''; // parkingSpace owner is the current user
  String coordinates = '';
  String coord_rand = '';

  Map<String, dynamic> toJson() => {
    'title': title,
    'address': address,
    'city': city_format,
    'state': state,
    'zip': zip,
    'uid': uid,
    'coordinates': coordinates, // generated from the input address
    'coordinates_r': coord_rand, // random coordinates near actual address
  };
}