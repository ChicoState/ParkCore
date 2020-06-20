import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkcore_app/parking/pform/add_parking3.dart';
import 'package:parkcore_app/models/ParkingData3.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

void main() {

  testWidgets('Check if parking space price is empty', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: AddParking3(),
    ));

    expect(AddParking3().createState().validatePrice('0.00'), 'Value must be greater than \$0.00');
  });

  test('ParkingData3 Days Available get and set', () {
    // parkingData3 params: days, start time, end time, price
    final parkingData = ParkingData3(null, '', '', '');
    parkingData.myDays = ['MON', 'TUE', 'WED', 'THU', 'FRI'];
    Map<String, dynamic> parkingJson = parkingData.toJson();
    expect(parkingJson['days'], '[MON, TUE, WED, THU, FRI]');
  });

  test('ParkingData3 Start Time get and set', () {
    final parkingData = ParkingData3(null, '', '', '');
    parkingData.startTime = '09:00';
    Map<String, dynamic> parkingJson = parkingData.toJson();
    expect(parkingJson['starttime'], '09:00');
  });

  test('ParkingData3 End Time get and set', () {
    final parkingData = ParkingData3(null, '', '', '');
    parkingData.endTime = '20:00';
    Map<String, dynamic> parkingJson = parkingData.toJson();
    expect(parkingJson['endtime'], '20:00');
  });

  test('Parking Space Price getter and setter', () {
    final parkingData = ParkingData3(null, '', '', '');
    parkingData.price = '42.00';
    Map<String, dynamic> parkingJson = parkingData.toJson();
    expect(parkingJson['monthprice'], '42.00');
  });
}