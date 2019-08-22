import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/cupertino.dart';

const _apiKey = '9ed09ae29739c01a9cc51c596a1eb6ff';
const _openWeatheerApi = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  int condition = 800;
  String description = 'Sunny';
  double temperature = 15;
  String city = 'Dubna';
  String latitude = '56.743';
  String longitude = '37.196';
  String weatherIcon = '🤷‍';
  String message = 'Time for a walk 🚶';

  String _getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String _getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp >= 10) {
      return 'Time for a walk 🚶';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  void GetWeatherByCityName(BuildContext context, String City) async {
    String url = _buildCityUrl(City);
    NetworkHelper nh = NetworkHelper(url: url);
    var decodingResponse = await nh.getDecodingData(context);
    _parseWeatherResponse(decodingResponse);
    weatherIcon = _getWeatherIcon(condition);
    message = _getMessage(temperature.toInt());
  }

  void GetWeatherData(BuildContext context) async {
    Location l = Location();
    await l.getCurrentPosition();
    latitude = l.latitude;
    longitude = l.longtitude;
    String url = _buildCoordinateUrl(latitude, longitude);
    NetworkHelper nh = NetworkHelper(url: url);
    var decodingResponse = await nh.getDecodingData(context);
    _parseWeatherResponse(decodingResponse);
    weatherIcon = _getWeatherIcon(condition);
    message = _getMessage(temperature.toInt());
  }

  String getPosition() {
    String position = 'lt/lg: ' + latitude + ', ' + longitude;
    return position;
  }

  String _buildCoordinateUrl(String latitude, String longitude) {
    return '$_openWeatheerApi?lat=$latitude&lon=$longitude&appid=$_apiKey';
  }

  String _buildCityUrl(String City) {
    return '$_openWeatheerApi?q=$City&appid=$_apiKey';
  }

  void _parseWeatherResponse(dynamic decodingResponse) {
    description = decodingResponse['weather'][0]['description'];
    temperature = decodingResponse['main']['temp'] - 273.15;
    city = decodingResponse['name'];
    condition = decodingResponse['weather'][0]['id'];
  }
}
