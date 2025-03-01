part of qweather;

/// 地理信息搜索API
mixin _Geo on _ServiceApi {
  /// [城市信息查询]: https://dev.qweather.com/docs/android-sdk/android-geo/#城市信息查询
  Future<GeoPoiLocationResp?> geoCityLookup(String location,
      {String range = 'world', int number = 10, String lang = 'zh-hans'}) async {
    Map param = {
      "location": location,
      'lang': lang,
      "range": range.isEmpty ? 'world' : range,
      "number": Platform.isAndroid ? number : number.toString()
    };
    Map? value = await _methodChannel.invokeMapMethod(
        MethodConstants.GeoCityLookup, param);
    return value == null ? null : GeoPoiLocationResp.fromMap(value);
  }

  /// [热门城市查询]: https://dev.qweather.com/docs/android-sdk/android-geo/#热门城市查询
  Future<GeoPoiLocationResp?> getGeoTopCity(
      {String range = 'world', int number = 10, String lang = 'zh-hans'}) async {
    Map param = {
      "range": range.isEmpty ? 'world' : range,
      'lang': lang,
      "number": Platform.isAndroid ? number : number.toString()
    };
    Map? value = await _methodChannel.invokeMapMethod(
        MethodConstants.GetGeoTopCity, param);
    return value == null ? null : GeoPoiLocationResp.fromMap(value);
  }

  /// [POI信息搜索]: https://dev.qweather.com/docs/android-sdk/android-geo/#POI信息搜索
  Future<GeoPoiLocationResp?> geoPoiLookup(String location, PoiType type,
      {String city = '', int number = 10, String lang = 'zh-hans'}) async {
    Map param = {
      "location": location,
      "city": city,
      'lang': lang,
      "number": Platform.isAndroid ? number : number.toString(),
      "type": type.code
    };

    Map? value = await _methodChannel.invokeMapMethod(
        MethodConstants.GeoPoiLookup, param);
    return value == null ? null : GeoPoiLocationResp.fromMap(value);
  }

  /// [POI范围搜索]: https://dev.qweather.com/docs/android-sdk/android-geo/#POI范围搜索
  Future<GeoPoiLocationResp?> geoPoiRangeLookup(String location, PoiType type,
      {int radius = 5, int number = 10, String lang = 'zh-hans'}) async {
    Map param = {
      "location": location,
      'lang': lang,
      "radius": Platform.isAndroid ? radius : radius.toString(),
      "number": Platform.isAndroid ? number : number.toString(),
      "type": type.code
    };
    Map? value = await _methodChannel.invokeMapMethod(
        MethodConstants.GeoPoiRangeLookup, param);
    return value == null ? null : GeoPoiLocationResp.fromMap(value);
  }
}
