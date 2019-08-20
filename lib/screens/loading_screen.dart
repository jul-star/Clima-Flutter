import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String myPosition = 'My position';

  @override
  void initState() {
    // TODO: implement initState
    print('Init 1');
    Location l = Location(callback: SetPosition);
    l.getCurrentPosition();
    super.initState();
    print('Init 2');
  }

  void SetPosition(String pos) {
    String defaultPosition = 'Unknown location';
    setState(() {
      myPosition = pos ?? defaultPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(myPosition),
      ),
    );
  }
}
