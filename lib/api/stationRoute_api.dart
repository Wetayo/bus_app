import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

String _urlPrefix = DotEnv.env['STATION_ROUTE_URL'];
String _serviceKey = DotEnv.env['STATION_ROUTE_KEY'];
const String _idPrefix = '&routeId=';
const String _defaultid = '';

const String STATUS_OK = '0';

String buildUrl(String id) {
  StringBuffer sb = StringBuffer();
  sb.write(_urlPrefix);
  sb.write(_serviceKey);
  sb.write(_idPrefix);
  sb.write(id);

  return sb.toString();
}
