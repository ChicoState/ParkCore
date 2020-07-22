// Parking Space Data (page 2 of parking space form)
// parking space size, parking space type (plus driveway or spaceType info,
// depending on type), amenities available, and additional details (optional)
class ParkingData2 {
  ParkingData2(
    this.size,
    this.type,
    this.driveway,
    this.spaceType,
    this.myAmenities,
    this.details,
  );

  String size = '';
  String type = '';
  String driveway = '';
  String spaceType = '';
  List myAmenities = [];
  String details = '';

  Map<String, dynamic> toJson() => {
    'size': size,
    'type': type,
    'driveway': driveway,
    'spacetype': spaceType,
    'amenities': myAmenities.toString(),
    'spacedetails': details,
  };
}