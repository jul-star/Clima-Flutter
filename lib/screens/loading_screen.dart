import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '9ed09ae29739c01a9cc51c596a1eb6ff';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String myPosition = 'My position';
  String latitude;
  String longtitude;
  String rawResponse;

  @override
  void initState() {
    // TODO: implement initState
    rawResponse = 'Wait a second';
    print('Init 1');
    super.initState();
    Location l = Location(callback: SetPosition);
    l.getCurrentPosition();
    print('Init 2');
  }

  void SetPosition(String latt, String longt) {
    String defaultLatitude = '56.743';
    String defaultLongtitude = '37.196';
    latitude = latt ?? defaultLatitude;
    longtitude = longt ?? defaultLongtitude;
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longtitude&appid=$apiKey';
    NetworkHelper nh = NetworkHelper(url: url, callback: SetWeather);
    nh.getData();
    setState(() {
      myPosition = 'latt/longt: ' + latitude + ', ' + longtitude;
    });
  }

  void SetWeather(dynamic decodingResponse) {
    if (decodingResponse == null) {
      setState(() {
        rawResponse = 'Try later.';
      });
    } else {
      String weatherDescription = decodingResponse['weather'][0]['description'];
      double temperature = decodingResponse['main']['temp'] - 273.15;
      String city = decodingResponse['name'];
      setState(() {
        rawResponse = city +
            ': ' +
            weatherDescription +
            '\n' +
            'temperature: ' +
            temperature.toStringAsPrecision(2);
      });
    }
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
