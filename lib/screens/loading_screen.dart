import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/screens/location_screen.dart';

const apiKey = '9ed09ae29739c01a9cc51c596a1eb6ff';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String myPosition = 'My position';
  String latitude;
  String longitude;
  String rawResponse;

  @override
  void initState() {
    // TODO: implement initState
    rawResponse = 'Wait a second';
    print('Init 1');
    super.initState();
    GetWeatherData();

    print('Init 2');
  }

  void GetWeatherData() async {
    Location l = Location();
    await l.getCurrentPosition();
    String defaultLatitude = '56.743';
    String defaultLongtitude = '37.196';
    latitude = l.latitude ?? defaultLatitude;
    longitude = l.longtitude ?? defaultLongtitude;
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';
    NetworkHelper nh = NetworkHelper(url: url);
    var decodingResponse = await nh.getDecodingData();
    print(decodingResponse);
    String position = 'lt/lg: ' + latitude + ', ' + longitude;
    String weather = getWeather(decodingResponse);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weather: weather, position: position);
    }));
  }

  String getWeather(dynamic decodingResponse) {
    if (decodingResponse == null) {
      return 'Try later.';
    }
    String weatherDescription = decodingResponse['weather'][0]['description'];
    double temperature = decodingResponse['main']['temp'] - 273.15;
    String city = decodingResponse['name'];
    return city +
        ': ' +
        weatherDescription +
        '\n' +
        'temperature: ' +
        temperature.toStringAsPrecision(2);
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
