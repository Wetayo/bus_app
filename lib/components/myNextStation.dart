import 'package:flutter/material.dart';
import 'package:wetayo_bus/model/locationBus.dart';
import 'package:wetayo_bus/model/stationRoute.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marquee_widget/marquee_widget.dart';

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
    matchStation();
  }

  void matchStation() {
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
      print('set matchStation');
      setState(() {
        print('matchStation range');
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
                      : Marquee(
                          child: Text(
                            widget.stationData[idx].stationName,
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
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
                        'stationId': 999999999,
                        'routeId': 999999999,
                      }),
                  builder: (QueryResult result,
                      {VoidCallback refetch, FetchMore fetchMore}) {
                    if (result.exception != null) {
                      return Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          padding: const EdgeInsets.all(15.0),
                          margin: const EdgeInsets.only(top: 40.0),
                          child: Text(
                            '없어요',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
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
                        child: Text("없어요."),
                      );
                    } else {
                      // setState(() {
                      //   _isLoading = result.isLoading;
                      // });

                      print(result.data.toString());
                      return Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          padding: const EdgeInsets.all(15.0),
                          margin: const EdgeInsets.only(top: 40.0),
                          child: Text(
                            '승차 예약이 있어요',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          );
  }
}
