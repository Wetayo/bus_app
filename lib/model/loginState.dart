import 'package:flutter/material.dart';

class SimpleState extends ChangeNotifier {
  @override
  String _routeId;
  String _busNum;

  bool _isAuthenticated = false;
  // TODO: implement toString

  void setRouteId(String routeId) {
    _routeId = routeId;
  }

  void setBusNum(String busNum) {
    _busNum = busNum;
  }

  set isAuthenticated(bool isAuth) {
    _isAuthenticated = isAuth;
    notifyListeners();
  }

  String get routeId => _routeId;
  String get busNum => _busNum;

  bool get isAuthenticated {
    return this._isAuthenticated;
  }

  Future login(String routeId, String busNum) async {
    print('login 호출');
    print(isAuthenticated);
    isAuthenticated = true;
    print(isAuthenticated);
  }

  Future logout() async {
    print('logout 호출');
    isAuthenticated = false;
  }
}
