import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

//TODO: 08:50/15:13 14
class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherModel});
  final WeatherModel weatherModel;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String position;
  String weatherDescription;
  String weatherIcon;
  String weatherMessage;
  String city;
  double temperature;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InitUiValues();
  }

  void InitUiValues() {
    position = widget.weatherModel.getPosition();
    weatherDescription = widget.weatherModel.description;
    weatherIcon = widget.weatherModel.weatherIcon;
    weatherMessage = widget.weatherModel.message;
    city = widget.weatherModel.city;
    temperature = widget.weatherModel.temperature;
  }

  void UpdateUI() async {
    setState(() {
      position = 'Wait a second';
      weatherDescription = '';
      weatherIcon = '';
      weatherMessage = '';
      city = '';
      temperature = null;
    });
    WeatherModel wm = WeatherModel();
    await wm.GetWeatherData(this.context);
    setState(() {
      position = wm.getPosition();
      weatherDescription = wm.description;
      weatherIcon = wm.weatherIcon;
      weatherMessage = wm.message;
      city = wm.city;
      temperature = wm.temperature;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black45,
//          image: DecorationImage(
//            image: AssetImage('images/location_background.jpg'),
//            fit: BoxFit.cover,
//            colorFilter: ColorFilter.mode(
//                Colors.white.withOpacity(0.8), BlendMode.dstATop),
//          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      UpdateUI();
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      city, // + ': ' + position
                      style: kPositionTextStyle,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      (temperature == null
                          ? ''
                          : temperature.toStringAsPrecision(2)),
                      style: kTempTextStyle,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      weatherIcon,
                      style: kTempTextStyle,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      weatherDescription,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherMessage,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
