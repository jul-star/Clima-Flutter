import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

class NetworkHelper {
  NetworkHelper({@required this.url});
  final String url;

  Future<dynamic> getDecodingData(BuildContext context) async {
    http.Response response;
    try {
      response = await http.get(url);
      return checkStatus(response, context);
    } catch (e) {
      _onAlertButtonPressed(context, 'Error: ' + e.toString());
    }
  }

  checkStatus(http.Response response, BuildContext context) {
    var decodingData;

    if (response.statusCode >= 100 && response.statusCode < 200) {
      _onAlertButtonPressed(context, 'Hold on');
    } else if (response.statusCode >= 200 && response.statusCode < 300) {
      print(response.body);
      decodingData = convert.jsonDecode(response.body);
    } else if (response.statusCode >= 300 && response.statusCode < 400) {
      _onAlertButtonPressed(context, 'Go away');
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      _onAlertButtonPressed(context, 'You fucked up');
    } else if (response.statusCode >= 500 && response.statusCode < 600) {
      _onAlertButtonPressed(context, 'I fucked up');
    } else {
      _onAlertButtonPressed(
          context, 'Unknown status: ' + response.statusCode.toString());
    }
    return decodingData;
  }

  _onAlertButtonPressed(context, String title) {
    Alert(
      context: context,
      type: AlertType.error,
      title: title,
      desc: "Try later.",
//      buttons: [
//        DialogButton(
//          child: Text(
//            "COOL",
//            style: TextStyle(color: Colors.white, fontSize: 20),
//          ),
//          onPressed: () => Navigator.pop(context),
//          width: 120,
//        )
//      ],
    ).show();
  }
}
