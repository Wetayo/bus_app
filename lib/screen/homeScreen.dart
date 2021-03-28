import 'package:flutter/material.dart';

import 'package:wetayo_bus/components/time_in_hour_and_minute.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Text('HomeScreen'),
            TimeInHourAndMinute(),
          ],
        ),
      ),
    );
  }
}
