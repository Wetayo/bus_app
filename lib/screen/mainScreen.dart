import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final String routeId;
  final String busNum;
  MainScreen({Key key, this.routeId, this.busNum}) : super(key: key);

  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[Text(widget.routeId), Text(widget.busNum)],
      ),
    ));
  }
}
