import 'package:flutter/material.dart';
import 'package:wetayo_bus/components/busNum_input_field.dart';
import 'package:wetayo_bus/components/routeId_input_field.dart';
import 'package:wetayo_bus/components/text_field_container.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'MainScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key key,
  }) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _routeId = "";
  String _busNum = "";

  void onClickLogin(BuildContext context, String routeId, String busNum) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(routeId: routeId, busNum: busNum),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: (MediaQuery.of(context).size.width -
                          MediaQuery.of(context).padding.top) *
                      0.75,
                  height: (MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top) *
                      0.65,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(25.0),
                        child: Image.asset('assets/WETAYO_CI01.png'),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(25.0),
                              child: Text(
                                'SIGN IN TO YOUR ACCOUNT',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            RoundedRouteIdField(
                              hintText: "RouteId",
                              onChanged: (value) {
                                setState(() {
                                  _routeId = value;
                                  print('routeId >> $_routeId');
                                });
                              },
                            ),
                            RoundedBusNumField(
                              onChanged: (value) {
                                setState(() {
                                  _busNum = value;
                                  print('busNum >> $_busNum');
                                });
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              child: RaisedButton(
                                child: Text("로그인"),
                                onPressed: () =>
                                    onClickLogin(context, _routeId, _busNum),
                              ),
                              color: Colors.indigo,
                            ),
                            Text(
                              'routId : $_routeId',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 10.0),
                            ),
                            Text(
                              'busNum : $_busNum',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 10.0),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
