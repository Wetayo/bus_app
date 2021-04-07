import 'package:flutter/material.dart';
import 'package:wetayo_bus/components/menuItems.dart';
import 'package:wetayo_bus/main.dart';
import 'package:wetayo_bus/model/loginState.dart';
import 'package:wetayo_bus/screen/homeScreen.dart';
import 'package:wetayo_bus/screen/settingScreen.dart';
import 'package:provider/provider.dart';

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
  double pageScale = 1;

  int selectedMenuItem = 0;

  String pageTitle = 'Homepage';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void setSidebarState() {
    setState(() {
      xOffset = sidebarOpen ? 265 : 60;
      yOffset = sidebarOpen ? 30 : 0;
      pageScale = sidebarOpen ? 0.8 : 1;
    });
  }

  void setPageTitle() {
    switch (selectedMenuItem) {
      case 0:
        pageTitle = 'HomePage';
        break;
      case 1:
        pageTitle = 'Setting';
        break;
    }
  }

  Widget setPageContent() {
    switch (selectedMenuItem) {
      case 0:
        return Consumer<SimpleState>(
          builder: (context, state, child) {
            return HomeScreen(routeId: state.routeId, busNum: state.busNum);
          },
        );
      case 1:
        return SettingScreen();
    }
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
                          setPageTitle();
                        },
                        child: MenuItems(
                          menuIcons: menuIcons[index],
                          menuItems: menuItems[index],
                          index: index,
                          selected: selectedMenuItem,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    logoutAlert(context);
                  },
                  child: Container(
                    child: MenuItems(
                      menuIcons: "icon_logout",
                      menuItems: "Logout",
                      index: menuItems.length + 1,
                      selected: selectedMenuItem,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 200),
            transform: Matrix4.translationValues(xOffset, yOffset, 1.0)
              ..scale(pageScale),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: sidebarOpen
                    ? BorderRadius.circular(20.0)
                    : BorderRadius.circular(0)),
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
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Text(
                          pageTitle,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: setPageContent(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future logoutAlert(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그아웃'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('정말 로그아웃 하시겠습니까?')],
            ),
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('확인'),
                onPressed: () {
                  // final SimpleState state =
                  //     Provider.of<SimpleState>(context, listen: false);
                  // state.setRouteId(null);
                  // state.setBusNum(null);

                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, ROOT_PAGE, (route) => false);

                  final auth = Provider.of<SimpleState>(context, listen: false);
                  auth.logout();
                  Navigator.of(context).pop();
                }),
            FlatButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
