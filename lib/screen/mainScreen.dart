import 'package:flutter/material.dart';

import 'AppContainer.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      title: 'WetayoBus',
      home: Scaffold(
        body: Container(
          color: Color(0xFFB1F2B36),
          child: AppContainer(),
        ),
      ),
    );
  }
}
