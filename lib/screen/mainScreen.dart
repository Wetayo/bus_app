import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wetayo_bus/model/loginState.dart';

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
        body: Consumer<SimpleState>(
          builder: (context, state, child) {
            print(
                'login 성공 >> ${state.routeId}    login 성공 >> ${state.busNum}');
            return Container(
              color: Color(0xFFB1F2B36),
              child: AppContainer(),
            );
          },
        ),
      ),
    );
  }
}
