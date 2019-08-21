import 'package:geolocator/geolocator.dart';

class Location {
  String latitude;
  String longtitude;

  void getCurrentPosition() async {
    Position position;
    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
      latitude = position.latitude.toString();
      longtitude = position.longitude.toString();
    } catch (e) {
      print('Error: ' + e);
    }
  }
}
