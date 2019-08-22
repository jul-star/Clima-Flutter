import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  int condition = 800;
  String weatherDescription = 'Sunny';
  double temperature = 15;
  String city = 'Dubna';
  String latitude = '56.743';
  String longitude = '37.196';

  String getWeatherIcon(int condition) {
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

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future<dynamic> GetWeatherData() async {
    Location l = Location();
    await l.getCurrentPosition();
    latitude = l.latitude;
    longitude = l.longtitude;
    String url = buildUrl(latitude, longitude);
    NetworkHelper nh = NetworkHelper(url: url);
    var decodingResponse = await nh.getDecodingData();
    return decodingResponse;
  }

  String getPosition() {
    String position = 'lt/lg: ' + latitude + ', ' + longitude;
    return position;
  }

  String buildUrl(String latitude, String longitude) {
    const apiKey = '9ed09ae29739c01a9cc51c596a1eb6ff';
    const openWeatheerApi = 'https://api.openweathermap.org/data/2.5/weather';
    String url = '$openWeatheerApi?lat=$latitude&lon=$longitude&appid=$apiKey';
    return url;
  }

  int parseWeatherCondition(dynamic decodingResponse) {
    return 800;
  }

  String parseWeatherResponse(dynamic decodingResponse) {
    if (decodingResponse == null) {
      return 'Try later.';
    }
    weatherDescription = decodingResponse['weather'][0]['description'];
    temperature = decodingResponse['main']['temp'] - 273.15;
    city = decodingResponse['name'];
    return city +
        ': ' +
        weatherDescription +
        '\n' +
        'temperature: ' +
        temperature.toStringAsPrecision(2);
  }
}
