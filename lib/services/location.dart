import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';

class Location {
  Location({@required this.callback});
  String latitude;
  String longtitude;
  Function(String) callback;

  void getCurrentPosition() async {
    Position position;
    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
      latitude = position.latitude.toString();
      longtitude = position.longitude.toString();
      callback(latitude + ', ' + longtitude);
    } catch (e) {
      print(e);
    }
  }
}
