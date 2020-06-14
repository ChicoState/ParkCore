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
//
//    this.size,
//    this.type,
//    this.driveway,
//    this.spaceType,
//    this.myAmenities,
//    this.details,
//    this.myDays,
//    this.startTime,
//    this.endTime,
//    this.price,
//    this.coordinates,
//    this.coord_rand,
//    this.downloadURL,
//    this.reserved,
//    this.cur_tenant,
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

//  String size = '';
//  String type = '';
//  String driveway = '';
//  String spaceType = '';
//  List myAmenities = [];
//  String details = '';
//  List myDays = [];
//  String startTime = '';
//  String endTime = '';
//  String price = '';
//  String coordinates = '';
//  String coord_rand = '';
//  String downloadURL = '';
//  String uid = ''; // parkingSpace owner is the current user
//  String reserved = ''; // list of UIDs (if reserved, starts empty)
//  String cur_tenant = ''; // current tenant (a UID, or empty if spot is available)

  Map<String, dynamic> toJson() => {
    'title': title,
    'address': address,
    'city': city_format,
    'state': state,
    'zip': zip,
    'uid': uid,
    'coordinates': coordinates, // generated from the input address
    'coordinates_r': coord_rand, // random coordinates near actual address

//    'size': size,
//    'type': type,
//    'driveway': driveway,
//    'spacetype': spaceType,
//    'amenities': myAmenities.toString(),
//    'spacedetails': details,
//    'days': myDays.toString(),
//    'starttime': startTime,
//    'endtime': endTime,
//    'monthprice': price,
//    'coordinates': coordinates, // generated from the input address
//    'coordinates_r': coord_rand, // random coordinates near actual address
//    'downloadURL': downloadURL, // for the image (put in firebase storage)
//   // 'uid': getUserID(), // parkingSpace owner is the current user
//    'reserved': [].toString(), // list of UIDs (if reserved, starts empty)
//    'cur_tenant': '', // current tenant (a UID, or empty if spot is available)
  };
}