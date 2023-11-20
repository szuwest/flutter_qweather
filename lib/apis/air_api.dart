part of qweather;

/// 实时空气质量和预报
mixin _Air on _ServiceApi {
  /// [获取实时空气质量]: https://dev.qweather.com/docs/android-sdk/android-air/#接口参数说明
  Future<AirNowResp?> getAirNow(String location, {String lang = 'zh-hans'}) async {
    Map<String, dynamic> param = {
      'location': location,
      'lang': lang,
    };
    Map? value = await _methodChannel.invokeMapMethod(
        MethodConstants.GetAirNow, param);
    return value == null ? null : AirNowResp.fromMap(value);
  }

  /// [获取5天空气质量预报]: https://dev.qweather.com/docs/android-sdk/android-air/#接口参数说明-1
  Future<AirDailyResp?> getAir5Day(String location, {String lang = 'zh-hans'}) async {
    Map<String, dynamic> param = {
      'location': location,
      'lang': lang,
    };
    Map? value = await _methodChannel.invokeMapMethod(
        MethodConstants.GetAir5Day, param);
    return value == null ? null : AirDailyResp.fromMap(value);
  }
}
