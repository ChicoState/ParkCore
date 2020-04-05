import 'dart:math' as math;

String getRandomCoordinates(String loc){
  const start = "{";
  const mid = ",";
  const end = "}";
  String rand_loc = "";

  final startIndex = loc.indexOf(start);
  final midIndex = loc.indexOf(mid, startIndex + start.length);
  final endIndex = loc.indexOf(end, startIndex + start.length + mid.length);

//    print("lat: "+ loc.substring(startIndex + start.length, midIndex));
//    print("long: "+ loc.substring(midIndex + mid.length, endIndex));
  var rng = math.Random();
  var rand1 = 0.0;
  var rand2 = 0.0;
  for (var i = 0; i < 1; i++) {
    rand1 = rng.nextDouble();
    rand2 = rng.nextDouble();
  }

  var w = 0.00125 * math.sqrt(rand1);
  var t = 2 * math.pi * rand2;
  var x = w * math.cos(t);
  var y = w * math.sin(t);
  var lat = x + double.parse(loc.substring(startIndex + start.length, midIndex));
  var long = y + double.parse(loc.substring(midIndex + mid.length, endIndex));
//    print(lat);
//    print(long);
//    rand_loc = "{" + loc.substring(startIndex + start.length, midIndex) + ","
//      + loc.substring(midIndex + mid.length, endIndex) + "}";
  rand_loc = "{" + lat.toString() + "," + long.toString() + "}";
  return rand_loc;
}