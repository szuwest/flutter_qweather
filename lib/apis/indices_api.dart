part of qweather;

/// 天气生活指数API
mixin _Indices on _ServiceApi {
  /// [获取1天生活指数]: https://dev.qweather.com/docs/android-sdk/android-indices/#接口参数说明
  Future<DailyIndicesResp?> getIndices1Day(String location,
      {Set<IndicesType>? indicesTypes, String lang = 'zh-hans'}) async {
    if (indicesTypes == null ||
        indicesTypes.isEmpty ||
        (indicesTypes.length > 1 && indicesTypes.contains(IndicesType.ALL)))
      indicesTypes = {IndicesType.ALL};
    Map param = {
      "location": location,
      'lang': lang,
      "indicesTypes": indicesTypes.map((e) => e.code).toList()
    };
    Map? value = await _methodChannel.invokeMapMethod(
        MethodConstants.GetIndices1Day, param);
    return value == null ? null : DailyIndicesResp.fromMap(value);
  }

  /// [获取3天生活指数]: https://dev.qweather.com/docs/android-sdk/android-indices/#接口参数说明-1
  Future<DailyIndicesResp?> getIndices3Day(String location,
      {Set<IndicesType>? indicesTypes, String lang = 'zh-hans'}) async {
    if (indicesTypes == null ||
        indicesTypes.isEmpty ||
        (indicesTypes.length > 1 && indicesTypes.contains(IndicesType.ALL)))
      indicesTypes = {IndicesType.ALL};
    Map param = {
      "location": location,
      'lang': lang,
      "indicesTypes": indicesTypes.map((e) => e.code).toList()
    };
    Map? value = await _methodChannel.invokeMapMethod(
        MethodConstants.GetIndices3Day, param);
    return value == null ? null : DailyIndicesResp.fromMap(value);
  }
}
