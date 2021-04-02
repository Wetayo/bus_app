import 'package:flutter/material.dart';
import 'package:wetayo_bus/model/locationBus.dart';
import 'package:wetayo_bus/model/stationRoute.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
  bool _isLoading = false;

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
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
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
              ),
              Center(
                child: Query(
                  options: QueryOptions(
                      document: gql(
                          """query getRide(\$stationId : Int!, \$routeId : Int!){
            getRide(stationId: \$stationId routeId: \$routeId)
              }"""),
                      variables: {
                        'stationId': int.parse(
                            widget.locateData[widget.myidx].stationId),
                        'routeId':
                            int.parse(widget.locateData[widget.myidx].routeId),
                      }),
                  builder: (QueryResult result,
                      {VoidCallback refetch, FetchMore fetchMore}) {
                    if (result.exception != null) {
                      return Center(child: Text("없어요"));
                    }
                    if (result.isLoading) {
                      // setState(() {
                      //   _isLoading = result.isLoading;
                      // });

                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (result.data["getRide"] != true) {
                      return Center(
                        child: Text("예약 정보가 없어오."),
                      );
                    } else {
                      // setState(() {
                      //   _isLoading = result.isLoading;
                      // });

                      print(result.data.toString());
                      return Text('승차 예약이 있어요');
                    }
                  },
                ),
              )
            ],
          );
  }
}
