import 'package:flutter/material.dart';

class SimpleState extends ChangeNotifier {
  @override
  String _routeId;
  String _busNum;
  // TODO: implement toString

  void setRouteId(String routeId) {
    _routeId = routeId;
  }

  void setBusNum(String busNum) {
    _busNum = busNum;
  }

  String get routeId => _routeId;
  String get busNum => _busNum;
}
