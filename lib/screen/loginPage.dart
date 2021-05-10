import 'package:flutter/material.dart';
import 'package:wetayo_bus/components/busNum_input_field.dart';
import 'package:wetayo_bus/components/routeId_input_field.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wetayo_bus/main.dart';
import 'package:wetayo_bus/model/loginState.dart';
import 'package:flutter/services.dart';

import 'MainScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key key,
  }) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _routeId = "224000002";
  String _busNum = "";

  void onClickLogin(BuildContext context, String routeId, String busNum) {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => MainScreen(routeId: routeId, busNum: busNum),
    //     ));

    //// Provider 상태 관리 버전
    print('Login Push');
    final SimpleState state = Provider.of<SimpleState>(context, listen: false);
    state.setRouteId(routeId);
    state.setBusNum(busNum);

    Navigator.pushNamed(context, MAIN_PAGE);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    final authProvider = Provider.of<SimpleState>(context, listen: false);
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
                                onPressed: () async {
                                  await authProvider.login(
                                      context, _routeId, _busNum);
                                  authProvider.setRouteId(_routeId);
                                  authProvider.setBusNum(_busNum);
                                },
                              ),
                              color: Color(0xFFB1F2B36),
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
