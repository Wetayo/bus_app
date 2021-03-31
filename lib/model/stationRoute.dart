class stationRoute {
  String _centerYn;
  String _districtCd;
  String _mobileNo;
  String _regionName;
  String _stationId;
  String _stationName;
  String _x;
  String _y;
  String _stationSeq;
  String _turnYn;

  stationRoute(
    this._centerYn,
    this._districtCd,
    this._mobileNo,
    this._regionName,
    this._stationId,
    this._stationName,
    this._x,
    this._y,
    this._stationSeq,
    this._turnYn,
  );

  String get centerYn => _centerYn;
  String get districtCd => _districtCd;
  String get mobileNo => _mobileNo;
  String get regionName => _regionName;
  String get stationId => _stationId;
  String get stationName => _stationName;
  String get x => _x;
  String get y => _y;
  String get stationSeq => _stationSeq;
  String get turnYn => _turnYn;
}
