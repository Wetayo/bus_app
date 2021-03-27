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

  bool sidebarOpen = false;

  double xOffset = 60;
  double yOffset = 0;

  int selectedMenuItem = 0;

  void setSidebarState() {
    setState(() {
      xOffset = sidebarOpen ? 265 : 60;
    });
  }

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
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        sidebarOpen = false;
                        selectedMenuItem = index;
                        setSidebarState();
                      },
                      child: MenuItems(
                        menuIcons: menuIcons,
                        menuItems: menuItems,
                        index: index,
                        selected: selectedMenuItem,
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
          AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 200),
            transform: Matrix4.translationValues(xOffset, yOffset, 1.0),
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 24.0),
                  height: 60.0,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          sidebarOpen = !sidebarOpen;
                          setSidebarState();
                        },
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(20.0),
                          child: Icon(Icons.menu),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItems extends StatelessWidget {
  const MenuItems({
    Key key,
    @required this.menuIcons,
    @required this.menuItems,
    this.index,
    this.selected,
  }) : super(key: key);

  final List<String> menuIcons;
  final List<String> menuItems;
  final int index;
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: selected == index ? Color(0xFFB1F1B26) : Color(0xFFB1F2B36),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset('assets/${menuIcons[index]}.png'),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              menuItems[index],
              style: TextStyle(color: Colors.white, fontSize: 10.0),
            ),
          )
        ],
      ),
    );
  }
}
