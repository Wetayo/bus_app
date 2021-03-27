import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wetayo_bus/screen/loginPage.dart';
import 'package:provider/provider.dart';
import 'package:wetayo_bus/screen/mainScreen.dart';
import 'model/loginState.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (_) => SimpleState(),
      child: MyApp(),
    ));

const String ROOT_PAGE = '/';
const String MAIN_PAGE = '/main';

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
      title: 'LoginForm',
      debugShowCheckedModeBanner: false,
      initialRoute: ROOT_PAGE,
      routes: {
        ROOT_PAGE: (context) => LoginPage(),
        MAIN_PAGE: (context) => MainScreen()
      },
    );
  }
}
