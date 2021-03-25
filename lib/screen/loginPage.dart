import 'package:flutter/material.dart';
import 'package:dropdownfield/dropdownfield.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                            Container(
                                color: Colors.indigo,
                                width: 300.0,
                                child: DropDownField(
                                  controller: testSelected,
                                  hintText: "Select any Test",
                                  enabled: true,
                                  itemsVisibleInDropdown: 4,
                                  items: test,
                                  onValueChanged: (value) {
                                    setState(() {
                                      selectTest = value;
                                    });
                                  },
                                )),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              child: RaisedButton(
                                child: Text("로그인"),
                              ),
                              color: Colors.indigo,
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

String selectTest = "";

final testSelected = TextEditingController();
List<String> test = [
  "11가1234",
  "21가1234",
  "31가1234",
  "15가1514",
  "56버1323",
  "23버5124",
  "83허1235"
];
