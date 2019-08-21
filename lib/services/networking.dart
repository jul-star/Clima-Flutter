import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class NetworkHelper {
  NetworkHelper({@required this.url, @required this.callback});
  final String url;
  Function(dynamic) callback;

  void getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print(response.body);
      var decode = convert.jsonDecode(response.body);
      callback(decode);
    } else {
      // 1* Hold on
      // 2* Ok
      // 3* Go away
      // 4* You fucked up
      // 5* I fucked up
      callback(null);
    }
  }
}
