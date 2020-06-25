// Parking Space Data (page 3 of parking space form)
// space availability: days, start/end times, price (per month)
class ParkingData3 {
  ParkingData3(
    this.myDays,
    this.startTime,
    this.endTime,
    this.price,
  );

  List myDays = [];
  String startTime = '';
  String endTime = '';
  String price = '';

  Map<String, dynamic> toJson() => {
    'days': myDays.toString(),
    'starttime': startTime,
    'endtime': endTime,
    'monthprice': price,
  };
}