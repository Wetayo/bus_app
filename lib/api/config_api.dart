import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlService {
  static final HttpLink httpLink = HttpLink("https://api.wetayo.club/wetayo",
      defaultHeaders: <String, String>{
        'api_key': FlutterConfig.get('GQL_HEADER')
      });
  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink as Link, cache: GraphQLCache()));
}

final graphqlService = GraphqlService();
