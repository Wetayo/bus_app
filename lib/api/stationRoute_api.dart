const String _urlPrefix =
    'http://openapi.gbis.go.kr/ws/rest/busrouteservice/station?serviceKey=';
const String _serviceKey = '1122334455';
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
