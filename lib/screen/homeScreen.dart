import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wetayo_bus/components/time_in_hour_and_minute.dart';
import 'package:wetayo_bus/model/locationBus.dart';
import 'package:wetayo_bus/model/loginState.dart';

import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

import '../api/busLocation_api.dart' as location_api;
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TimeInHourAndMinute(),
                SizedBox(
                  width: 100,
                )
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  height: MediaQuery.of(context).size.height * 0.42,
                  width: MediaQuery.of(context).size.width * 0.28,
                ),
                SizedBox(
                  width: 30.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.28,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Consumer<SimpleState>(
                          builder: (context, state, child) {
                            return MyNextStation(
                              routeId: state.routeId,
                              busNum: '경기70사1161',
                            );
                          },
                        ),
                        //Container(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  height: MediaQuery.of(context).size.height * 0.42,
                  width: MediaQuery.of(context).size.width * 0.28,
                ),
                SizedBox(
                  width: 60.0,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyNextStation extends StatefulWidget {
  final String routeId;
  final String busNum;

  MyNextStation({Key key, this.routeId, this.busNum}) : super(key: key);

  @override
  _MyNestStationState createState() => _MyNestStationState();
}

class _MyNestStationState extends State<MyNextStation> {
  bool _isLoading = false;
  int myidx = 0;

  final Xml2Json xml2Json = Xml2Json();

  List<locationBus> _locateData = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 10), (timer) {
      _getLocationBusList();
    });
  }

  _getLocationBusList() async {
    setState(() => _isLoading = true);

    //String station = _stationController.text;
    Consumer<SimpleState>(
      builder: (context, state, child) {},
    );
    print('widget item >> ${widget.routeId}');
    var response = await http.get(location_api.buildUrl(widget.routeId));
    String responseBody = response.body;
    xml2Json.parse(responseBody);
    var jsonString = xml2Json.toParker();
    //print('res >> $jsonString');

    var json = jsonDecode(jsonString);
    print(json);
    Map<String, dynamic> errorMessage = json['response']['msgHeader'];

    print('errorcode >> ${errorMessage['resultCode']}');
    if (errorMessage['resultCode'] != location_api.STATUS_OK) {
      setState(() {
        final String errMessage = errorMessage['resultMessage'];
        print('error >> $errMessage');

        _locateData = const [];
        _isLoading = false;
      });
      return;
    }

    List<dynamic> stationRoutesList =
        json['response']['msgBody']['busLocationList'];
    final int cnt = stationRoutesList.length;
    print('route_cnt >> $cnt');

    List<locationBus> list = List.generate(cnt, (int i) {
      Map<String, dynamic> item = stationRoutesList[i];
      return locationBus(
        item['endBus'],
        item['lowPlate'],
        item['plateNo'],
        item['plateType'],
        item['remainSeatCnt'],
        item['routeId'],
        item['stationId'],
        item['stationSeq'],
      );
    });

    print('route_list >>> ${list[0].plateType}');

    setState(() {
      list.sort(
          (a, b) => int.parse(a.stationSeq).compareTo(int.parse(b.stationSeq)));
      _locateData = list;

      for (int i = 0; i < list.length; i++) {
        print(list[i].stationSeq);
      }

      int whereidx =
          list.indexWhere((list) => list.plateNo.startsWith(widget.busNum));
      myidx = whereidx;
      print('idx >> $whereidx');
      print('here!! >> ${_locateData[whereidx].plateNo}');
      print('previous >> ${_locateData[whereidx - 1].plateNo}');
      print('next >> ${_locateData[whereidx + 1].plateNo}');
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: <Widget>[
              Consumer<SimpleState>(
                builder: (context, state, child) {
                  return Text(_locateData[myidx].stationId);
                },
              ),
            ],
          );
  }
}
