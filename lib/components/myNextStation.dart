import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wetayo_bus/api/config_api.dart';
import 'package:wetayo_bus/model/locationBus.dart';
import 'package:wetayo_bus/model/loginState.dart';
import 'package:wetayo_bus/model/stationRoute.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marquee_widget/marquee_widget.dart';

import 'package:graphql/client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:provider/provider.dart';

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

  String _currentRideStation = '';
  String _currentRideRoute = '';
  bool _isCurrentRide = false;

  bool _isRide = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    matchStation();

    getRide(widget.locateData[widget.myidx].stationId,
        widget.locateData[widget.myidx].routeId);

    final SimpleState state = Provider.of<SimpleState>(context, listen: false);
    print(
        '_currentRideStation >> ${state.rideStationId} ------ 현재위치버스 >> ${widget.locateData[widget.myidx].stationId}');

    if (state.isGetRide &&
        state.rideStationId != widget.locateData[widget.myidx].stationId) {
      print('삭제처리중입니다...');

      setState(() {
        _isRide = true;
      });

      deleteRide(state.rideStationId, state.rideRouteId);
    }
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

  GraphQLClient weTayoGraphQLClient() {
    final Link _link = HttpLink(
      DotEnv.env['GQL_URI'],
      defaultHeaders: {
        'api-key': DotEnv.env['GQL_HEADER'],
      },
    );

    return GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );
  }

  void getRide(String getRideStation, String getRideRoute) async {
    setState(() {
      _isRide = true;
    });

    final GraphQLClient _client = weTayoGraphQLClient();

    final QueryOptions options = QueryOptions(
      document: gql(
        """query getRide(\$stationId : Int!, \$routeId : Int!){
            getRide(stationId: \$stationId routeId: \$routeId)
              }""",
      ),
      variables: {
        'stationId': 999999999,
        'routeId': 999999999,
      },
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      print('탑승자조회실패 >> ${result.exception.toString()}');
      return;
    } else if (result.data['getRide']) {
      setState(() {
        _isRide = false;
        //_currentRideStation = widget.locateData[widget.myidx].stationId;
      });
      print('탑승자조회중.. ${result.data['getRide']}');

      _isCurrentRide = true;

      final SimpleState state =
          Provider.of<SimpleState>(context, listen: false);
      state.setGetRideStationId(widget.locateData[widget.myidx].stationId);
      state.setGetRideRouteId(widget.locateData[widget.myidx].routeId);
      state.setIsGetRide(_isCurrentRide);
      _currentRideRoute = widget.locateData[widget.myidx].routeId;

      //return;
    }

    /////////////////////////////////////////////////////////////
    print('_isCurrentRide >> $_isCurrentRide');
    //////////////////////////////////////////////////////////////
    // final SimpleState state = Provider.of<SimpleState>(context, listen: false);
    // print(
    //     '_currentRideStation >> ${state.rideStationId} ------ 현재위치버스 >> ${widget.locateData[widget.myidx].stationId}');

    // if (state.isGetRide &&
    //     state.rideStationId != widget.locateData[widget.myidx].stationId) {
    //   print('삭제처리중입니다...');
    //   deleteRide(state.rideStationId, state.rideRouteId);
    // }

    return;
  }

  void deleteRide(String getRideStation, String getRideRoute) async {
    final SimpleState state = Provider.of<SimpleState>(context, listen: false);
    state.setGetRideStationId('');
    state.setGetRideRouteId('');
    state.setIsGetRide(false);
    print('Delete clear!!');

    if (getRideStation == '' || getRideRoute == '') {
      print('station and route id is Required!!');
      return;
    }

    final GraphQLClient _client = weTayoGraphQLClient();

    final MutationOptions options = MutationOptions(
      document: gql(
        """mutation DeleteRide(\$stationId : Int!, \$routeId : Int!){
                      deleteRide(stationId : \$stationId, routeId : \$routeId){
                        stationId
                        routeId
                      }
                    }""",
      ),
      variables: <String, dynamic>{
        'stationId': 999999999,
        'routeId': 999999999,
      },
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      print('mutationException >> ${result.hasException.toString()}');
      return;
    }

    return;
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
                child: _isRide
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        padding: const EdgeInsets.all(15.0),
                        margin: const EdgeInsets.only(top: 40.0),
                        child: Text(
                          '없어요.',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : GetRide(),
                //     child: Query(
                //       options: QueryOptions(
                //           document: gql(
                //               """query getRide(\$stationId : Int!, \$routeId : Int!){
                // getRide(stationId: \$stationId routeId: \$routeId)
                //   }"""),
                //           variables: {
                //             'stationId': int.parse(
                //                 widget.locateData[widget.myidx].stationId),
                //             'routeId':
                //                 int.parse(widget.locateData[widget.myidx].routeId),
                //           }),
                //       builder: (QueryResult result,
                //           {VoidCallback refetch, FetchMore fetchMore}) {
                //         if (result.exception != null) {
                //           return Center(
                //             child: Container(
                //               decoration: BoxDecoration(
                //                   color: Colors.yellow,
                //                   borderRadius:
                //                       BorderRadius.all(Radius.circular(15.0))),
                //               padding: const EdgeInsets.all(15.0),
                //               margin: const EdgeInsets.only(top: 40.0),
                //               child: Text(
                //                 '없어요',
                //                 style: TextStyle(
                //                   fontSize: 25.0,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //             ),
                //           );
                //         }
                //         if (result.isLoading) {
                //           // setState(() {
                //           //   _isLoading = result.isLoading;
                //           // });

                //           return Center(
                //             child: CircularProgressIndicator(),
                //           );
                //         }
                //         if (result.data["getRide"] != true) {
                //           return Center(
                //             child: Text("없어요."),
                //           );
                //         } else {
                //           // setState(() {
                //           //   _isLoading = result.isLoading;
                //           // });
                //           _currentRideStation =
                //               widget.locateData[widget.myidx].stationId;
                //           _currentRideRoute =
                //               widget.locateData[widget.myidx].routeId;
                //           _isCurrentRide = true;

                //           print(result.data.toString());
                //           return GetRide();
                //         }
                //       },
                //     ),
              ),
              // Center(
              //   child: _isCurrentRide
              //       ? CircularProgressIndicator()
              //       : Mutation(
              //           options: MutationOptions(
              //             document: gql(
              //                 """mutation DeleteRide(\$stationId : Int!, \$routeId : Int!){
              //         deleteRide(stationId : \$stationId, routeId : \$routeId){
              //           stationId
              //           routeId
              //         }
              //       }"""),
              //             update: (GraphQLDataProxy cache, QueryResult result) {
              //               return cache;
              //             },
              //             onError: (OperationException error) {
              //               print('Delete failed >> ${error.toString()}');
              //             },
              //             onCompleted: (dynamic resultData) {
              //               print(
              //                   'Delete completed >> ${resultData.toString()}');
              //             },
              //           ),
              //           builder: (
              //             RunMutation runMutation,
              //             QueryResult result,
              //           ) {
              //             return runMutation(
              //                 {'stationId': 111, 'routeId': 222});
              //           }),
              // )
            ],
          );
  }
}

class GetRide extends StatelessWidget {
  const GetRide({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
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
}
