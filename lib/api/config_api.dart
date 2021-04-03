import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlService {
  static final HttpLink httpLink = HttpLink("https://api.wetayo.club/wetayo",
      defaultHeaders: <String, String>{
        'api_key': 'cce9dd9b-fe83-4a17-a519-466edc1592bb'
      });
  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink as Link, cache: GraphQLCache()));
}

final graphqlService = GraphqlService();
