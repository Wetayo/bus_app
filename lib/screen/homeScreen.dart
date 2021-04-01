import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wetayo_bus/api/config_api.dart';
import 'package:wetayo_bus/components/myNextStation.dart';
import 'package:wetayo_bus/components/nextBus.dart';
import 'package:wetayo_bus/components/previousBus.dart';

import 'package:wetayo_bus/components/time_in_hour_and_minute.dart';
import 'package:wetayo_bus/model/locationBus.dart';
import 'package:wetayo_bus/model/loginState.dart';

import 'package:http/http.dart' as http;
import 'package:wetayo_bus/model/stationRoute.dart';
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

import '../api/busLocation_api.dart' as location_api;
import '../api/stationRoute_api.dart' as station_api;
import 'dart:async';

class HomeScreen extends StatefulWidget {
  final String routeId;
  final String busNum;

  HomeScreen({
    Key key,
    this.routeId,
    this.busNum,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading0 = true;
  bool _isLoading1 = true;
  bool _isLoading2 = true;
  int myidx = 0;
  int stationIdx = 0;

  final Xml2Json xml2Json = Xml2Json();

  List<locationBus> _locateData = [];
  List<stationRoute> _stationData = [];

  @override
  void initState() {
    super.initState();
    _getStationRoute();
    _getLocationBusList();

    Timer.periodic(Duration(seconds: 10), (timer) {
      _getStationRoute();
      _getLocationBusList();
    });
  }

  // ***********************************
  // 실시간 버스 도착정보를 보기위한 비동기 함수
  // ***********************************
  _getLocationBusList() async {
    setState(() {
      _isLoading0 = true;
      _isLoading2 = true;
    });

    //String station = _stationController.text;
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
        _isLoading0 = false;
        _isLoading2 = false;
      });
      return;
    }

    List<dynamic> busLocationList =
        json['response']['msgBody']['busLocationList'];
    final int cnt = busLocationList.length;
    print('route_cnt >> $cnt');

    List<locationBus> list = List.generate(cnt, (int i) {
      Map<String, dynamic> item = busLocationList[i];
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
      //print('here!! >> ${_locateData[whereidx].plateNo}');
      //print('previous >> ${_locateData[whereidx - 1].plateNo}');
      //print('next >> ${_locateData[whereidx + 1].plateNo}');
      _isLoading0 = false;
      _isLoading2 = false;
    });
  }

  // ***********************************
  // 노선의 정류소 리스트를 조회하기 위한 비동기 함수
  // ***********************************
  _getStationRoute() async {
    setState(() => _isLoading1 = true);

    //String station = _stationController.text;
    //print('widget item >> ${widget.routeId}');
    var response = await http.get(station_api.buildUrl(widget.routeId));
    String responseBody = response.body;
    xml2Json.parse(responseBody);
    var jsonString = xml2Json.toParker();
    //print('res >> $jsonString');

    var json = jsonDecode(jsonString);
    print('station >> $json');
    Map<String, dynamic> errorMessage = json['response']['msgHeader'];

    print('Station errorcode >> ${errorMessage['resultCode']}');
    if (errorMessage['resultCode'] != location_api.STATUS_OK) {
      setState(() {
        final String errMessage = errorMessage['resultMessage'];
        print('Station error >> $errMessage');

        _locateData = const [];
        _isLoading1 = false;
      });
      return;
    }

    List<dynamic> stationRoutesList =
        json['response']['msgBody']['busRouteStationList'];
    final int cnt = stationRoutesList.length;
    print('station_cnt >> $cnt');

    List<stationRoute> list = List.generate(cnt, (int i) {
      Map<String, dynamic> item = stationRoutesList[i];
      return stationRoute(
        item['centerYn'],
        item['districtCd'],
        item['mobileNo'],
        item['regionName'],
        item['stationId'],
        item['stationName'],
        item['x'],
        item['y'],
        item['stationSeq'],
        item['turnYn'],
      );
    });

    print('station_list >>> ${list[0].stationName}');

    setState(() {
      _stationData = list;
      _isLoading1 = false;
      stationIdx = list.indexWhere(
          (list) => list.stationId.startsWith(_locateData[myidx].stationId));
    });
  }

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
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, top: 25.0, bottom: 10.0),
                          child: Text(
                            '앞 버스',
                            style: TextStyle(
                              fontSize: (35.0),
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[50],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10.0, left: 15.0),
                          child: Text(
                            '▶︎ 정류장',
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        _isLoading0
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : NextBus(
                                myidx: myidx,
                                locateData: _locateData,
                                stationData: _stationData,
                              )
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
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.28,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, top: 25.0, bottom: 10.0),
                          child: Text(
                            '다음 정류장',
                            style: TextStyle(
                              fontSize: (40.0),
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[50],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                          child: Text(
                            '▶︎ 정류장',
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        _isLoading1
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : GraphQLProvider(
                                client: graphqlService.client,
                                child: MyNextStation(
                                  myidx: myidx,
                                  locateData: _locateData,
                                  stationData: _stationData,
                                ),
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
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, top: 25.0, bottom: 10.0),
                          child: Text(
                            '이전 버스',
                            style: TextStyle(
                              fontSize: (35.0),
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[50],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10.0, left: 15.0),
                          child: Text(
                            '▶︎ 정류장',
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        _isLoading2
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : PreviousBus(
                                myidx: myidx,
                                locateData: _locateData,
                                stationData: _stationData,
                              )
                      ],
                    ),
                  ),
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
