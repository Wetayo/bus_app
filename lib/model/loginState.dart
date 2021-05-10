import 'package:flutter/material.dart';

class SimpleState extends ChangeNotifier {
  @override
  String _routeId;
  String _busNum;

  String _getRideStationId;
  String _getRideRouteId;
  bool _isGetRide;

  bool _isAuthenticated = false;
  // TODO: implement toString

  // 로그인을 위한 set
  void setRouteId(String routeId) {
    _routeId = routeId;
  }

  void setBusNum(String busNum) {
    _busNum = busNum;
  }

  // 탑승자 제거를 위한 set
  void setGetRideStationId(String getRideStationId) {
    _getRideStationId = getRideStationId;
  }

  void setGetRideRouteId(String getRideRouteId) {
    _getRideRouteId = getRideRouteId;
  }

  void setIsGetRide(bool getIsGetRide) {
    _isGetRide = getIsGetRide;
  }

  ///////////////////////////////////
  set isAuthenticated(bool isAuth) {
    _isAuthenticated = isAuth;
    notifyListeners();
  }

  // 로그인을 위한 get
  String get routeId => _routeId;
  String get busNum => _busNum;

  // 탑승자 제거를 위한 get
  String get rideStationId => _getRideStationId;
  String get rideRouteId => _getRideRouteId;
  bool get isGetRide => _isGetRide;

  bool get isAuthenticated {
    return this._isAuthenticated;
  }

  Future login(BuildContext context, String routeId, String busNum) async {
    print('login 호출');
    print(routeId);

    if (routeId == '' || busNum == '') {
      print('실패');
      _loginFailedAlert(context, '필드를 채워주세요.');
      return;
    }

    isAuthenticated = true;
    print(isAuthenticated);
  }

  Future logout() async {
    print('logout 호출');
    isAuthenticated = false;
  }

  void _loginFailedAlert(BuildContext context, String text) =>
      showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(text),
            actions: <Widget>[
              SimpleDialogOption(
                child: const Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
}
