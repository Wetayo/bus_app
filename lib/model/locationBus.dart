class locationBus {
  String _endBus;
  String _lowPlate;
  String _plateNo;
  String _plateType;
  String _remainSeatCnt;
  String _routeId;
  String _stationId;
  String _stationSeq;

  locationBus(
    this._endBus,
    this._lowPlate,
    this._plateNo,
    this._plateType,
    this._remainSeatCnt,
    this._routeId,
    this._stationId,
    this._stationSeq,
  );

  String get endBus => _endBus;
  String get lowPlate => _lowPlate;
  String get plateNo => _plateNo;
  String get plateType => _plateType;
  String get remainSeatCnt => _remainSeatCnt;
  String get routeId => _routeId;
  String get stationId => _stationId;
  String get stationSeq => _stationSeq;
}
