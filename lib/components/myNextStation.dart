import 'package:flutter/material.dart';
import 'package:wetayo_bus/model/locationBus.dart';
import 'package:wetayo_bus/model/stationRoute.dart';

class MyNextStation extends StatefulWidget {
  final int myidx;

  final List<locationBus> locateData;
  final List<stationRoute> stationData;

  MyNextStation({
    Key key,
    this.myidx,
    this.locateData,
    this.stationData,
  }) : super(key: key);

  @override
  _MyNextStationState createState() => _MyNextStationState();
}

class _MyNextStationState extends State<MyNextStation> {
  int idx = 0;
  bool _isCurrentBus = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    test();
  }

  void test() {
    try {
      setState(() {
        List<stationRoute> stationList = widget.stationData;

        idx = stationList.indexWhere((stationList) => stationList.stationId
            .startsWith(widget.locateData[widget.myidx].stationId));
        print('StationId >> ${widget.locateData[widget.myidx].stationId}');
        print('StationName >> ${widget.stationData[idx].stationName}');
        if (idx == -1) {
          throw RangeError('error');
        }
        _isCurrentBus = false;
      });
    } on RangeError catch (e) {
      print('set test');
      setState(() {
        print('test range');
        _isCurrentBus = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Container(
            padding: const EdgeInsets.only(right: 15.0, left: 15.0),
            child: _isCurrentBus
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Text(
                    widget.stationData[idx].stationName,
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
          ),
        )
      ],
    );
  }
}
