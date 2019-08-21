import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class NetworkHelper {
  NetworkHelper({@required this.url});
  final String url;

  Future<dynamic> getDecodingData() async {
    http.Response response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print(response.body);
      return convert.jsonDecode(response.body);
    } else {
      // 1* Hold on
      // 2* Ok
      // 3* Go away
      // 4* You fucked up
      // 5* I fucked up
      return null;
    }
  }
}
