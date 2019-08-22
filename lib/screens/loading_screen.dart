import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String myPosition = 'My position';
  String rawResponse;

  @override
  void initState() {
    // TODO: implement initState
    rawResponse = 'Wait a second';
    print('Init 1');
    super.initState();
    getLocationWeather();
    print('Init 2');
  }

  void getLocationWeather() async {
    WeatherModel wm = WeatherModel();
    var decodingResponse = await wm.GetWeatherData();
    String position = wm.getPosition();
    String weather = wm.parseWeatherResponse(decodingResponse);
    int condition = wm.parseWeatherCondition(decodingResponse);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weather: weather, position: position);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.lime,
          size: 50.0,
        ),
//        child: Text(myPosition + '\n' + rawResponse),
      ),
    );
  }
}

//SpinKitRotatingCircle(
//color: Colors.white,
//size: 50.0,
//);
