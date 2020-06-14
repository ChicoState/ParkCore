// Parking Space Data (page 3 of parking space form)
// space availability: days, start/end times, price (per month)
class ParkingData3 {
  ParkingData3(
    this.myDays,
    this.startTime,
    this.endTime,
    this.price,
//    this.downloadURL,
//    this.reserved,
//    this.cur_tenant,
      );

  List myDays = [];
  String startTime = '';
  String endTime = '';
  String price = '';
//  String downloadURL = '';
//  String reserved = ''; // list of UIDs (if reserved, starts empty)
//  String cur_tenant = ''; // current tenant (a UID, or empty if spot is available)

  Map<String, dynamic> toJson() => {
    'days': myDays.toString(),
    'starttime': startTime,
    'endtime': endTime,
    'monthprice': price,
//    'downloadURL': downloadURL, // for the image (put in firebase storage)
//    'reserved': [].toString(), // list of UIDs (if reserved, starts empty)
//    'cur_tenant': '', // current tenant (a UID, or empty if spot is available)
  };
}