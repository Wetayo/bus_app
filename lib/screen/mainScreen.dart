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

class AppContainer extends StatefulWidget {
  @override
  _AppContainState createState() => _AppContainState();
}

class _AppContainState extends State<AppContainer> {
  final List<String> menuItems = ['Home', 'Setting'];
  final List<String> menuIcons = ['icon_home', 'icon_settings'];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  child: Text('Search Bar'),
                ),
                Container(
                  child: Expanded(
                      child: new ListView.builder(
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) => Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            child:
                                Image.asset('assets/${menuIcons[index]}.png'),
                          ),
                          Container(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                menuItems[index],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.0),
                              ))
                        ],
                      ),
                    ),
                  )),
                ),
                Container(
                  child: Text('Logout'),
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Text('HomePage'),
          )
        ],
      ),
    );
  }
}
