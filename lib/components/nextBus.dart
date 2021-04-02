import 'package:flutter/material.dart';
import 'package:wetayo_bus/model/locationBus.dart';
import 'package:wetayo_bus/model/stationRoute.dart';

class NextBus extends StatefulWidget {
  final int myidx;

  final List<locationBus> locateData;
  final List<stationRoute> stationData;

  NextBus({
    Key key,
    this.myidx,
    this.locateData,
    this.stationData,
  }) : super(key: key);

  @override
  _NextBusState createState() => _NextBusState();
}

class _NextBusState extends State<NextBus> {
  int idx = 0;
  int reaminStation = 0;

  bool _isNextBus = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    test();
  }

  void test() {
    try {
      print('good');
      setState(() {
        print('good');
        List<stationRoute> stationList = widget.stationData;

        idx = stationList.indexWhere((stationList) => stationList.stationId
            .startsWith(widget.locateData[widget.myidx + 1].stationId));

        reaminStation =
            int.parse(widget.locateData[widget.myidx + 1].stationSeq) -
                int.parse(widget.locateData[widget.myidx].stationSeq);

        print('nextBus ${widget.locateData[widget.myidx + 1].stationId}');
        print('nextBus idx >> $idx');
        if (idx == -1) {
          throw RangeError('error');
        }

        _isNextBus = false;
      });
    } on RangeError catch (e) {
      print('set test');
      setState(() {
        print('test range');
        _isNextBus = true;
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
            child: _isNextBus
                ? Text(
                    '없어요ㅠㅠ',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
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
        ),
        SizedBox(
          height: 20.0,
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: _isNextBus
                ? Text(
                    '',
                    style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    '$reaminStation 개 앞에 있어요',
                    style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[100]),
                    textAlign: TextAlign.center,
                  ),
          ),
        )
      ],
    );
  }
}
