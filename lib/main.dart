import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wetayo_bus/screen/loginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.white,
      ),
      home: Scaffold(
        body: Container(
          child: LoginPage(),
        ),
      ),
    );
  }
}
