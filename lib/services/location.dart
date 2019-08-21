import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';

class Location {
  Location({@required this.callback});
  Function(String, String) callback;

  void getCurrentPosition() async {
    Position position;
    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
      String latitude = position.latitude.toString();
      String longtitude = position.longitude.toString();
      callback(latitude, longtitude);
    } catch (e) {
      print('Error: ' + e);
    }
  }
}
