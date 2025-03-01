import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qweather/constants.dart';
import 'package:flutter_qweather/flutter_qweather.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  /// _location
  /// LocationID 或者 经纬度;
  /// LocationID 可通过geo 接口查询 或 查看https://github.com/qwd/LocationList
  String _location = "106.227305,29.592024";
  TextEditingController _controller = TextEditingController();
  WeatherNowResp? _weatherNowResp;

  @override
  void initState() {
    _controller.text = _location;
    super.initState();
    initPlatformState();
    initQweather();
  }

  // 初始化 Qweather
  Future<void> initQweather() async {
    QweatherConfig config = QweatherConfig(
        publicIdForAndroid: 'HE2104211812191773',
        keyForAndroid: '83716e1718b64b22b5b9615300ac366e',
        publicIdForIos: 'HE2104211812581604',
        keyForIos: 'e5d46c6726d34584ae16eb2e4520e610',
        biz: false,
        debug: true);
    await FlutterQweather.instance.init(config);
    // await FlutterQweather.instance.setDebug();
    await queryWeatherNow();
    FlutterQweather.instance.getAirNow(_location, lang: 'en');
    // FlutterQweather.instance.geoPoiRangeLookup('116.40000,39.88999', PoiType.scenic);
    // FlutterQweather.instance.getWeatherMinuteLy(_location);
    // FlutterQweather.instance.geoPoiRangeLookup('116.40000,39.88999', PoiType.scenic);
    // FlutterQweather.instance.getIndices1Day('116.40000,39.88999',indicesTypes: {IndicesType.TRAV});
    // FlutterQweather.instance.getWarning('116.40000,39.88999');
    // FlutterQweather.instance.getWarningList(range: 'cn');
    // FlutterQweather.instance.getSun('116.40000,39.88999', '20220419');
    // FlutterQweather.instance.getMoon('116.40000,39.88999', '20220419');
    // FlutterQweather.instance.getSolarElevationAngle(
    //     location: '116.40000,39.88999', date: '20220419',
    //     time: "1230", tz: "0800",  alt: "430");
    // FlutterQweather.instance.getHistoricalWeather('116.40000,39.88999', '20220419');
    // FlutterQweather.instance.getHistoricalAir('116.40000,39.88999', '20220419');
  }

  // 查询实时天气
  Future<void> queryWeatherNow() async {
    setState(() => _weatherNowResp = null);
    // await Qweather.instance.getWeatherNow("101010100");
    _weatherNowResp = await FlutterQweather.instance.getWeatherNow(_location, lang: 'en');
    setState(() {});
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await FlutterQweather.instance.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() => _platformVersion = platformVersion);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('QWeather example app')),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onChanged: (v) => _location = v,
                        decoration: InputDecoration(
                          hintText: "请输入LocationID 或者 经纬度",
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: Text("查询天气"),
                      onPressed:
                          _weatherNowResp == null || _location.trim().isEmpty
                              ? null
                              : queryWeatherNow,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: _weatherNowResp == null
                  ? Center(child: Text("loading..."))
                  : _weatherNowWidget,
            ),
            Container(
              padding: EdgeInsets.all(64),
              child: Text('Running on: $_platformVersion\n'),
            )
          ],
        ),
      ),
    );
  }

  Widget get _weatherNowWidget {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      alignment: Alignment.center,
      child: ListView(
        children: [
          Text(
              "原始数据来源：             ${_weatherNowResp?.refer.sources.join(",")}"),
          Text(
              "使用许可：                ${_weatherNowResp?.refer.license.join(",")}"),
          Divider(),
          Text("接口更新时间：            ${_weatherNowResp?.basic.updateTime}"),
          Text("所查询城市的天气预报网页：   ${_weatherNowResp?.basic.fxLink}"),
          Divider(),
          Text("实况观测时间：            ${_weatherNowResp?.now.obsTime}"),
          Text("体感温度，默认单位：摄氏度： ${_weatherNowResp?.now.feelsLike}"),
          Text("温度，默认单位：摄氏度：    ${_weatherNowResp?.now.temp}"),
          Text("实况天气状况代码：         ${_weatherNowResp?.now.icon}"),
          Text("实况天气状况：             ${_weatherNowResp?.now.text}"),
          Text("风向360角度：             ${_weatherNowResp?.now.wind360}"),
          Text("风向：                   ${_weatherNowResp?.now.windDir}"),
          Text("风力：                   ${_weatherNowResp?.now.windScale}"),
          Text("风速，公里/小时：          ${_weatherNowResp?.now.windSpeed}"),
          Text("相对湿度：                ${_weatherNowResp?.now.humidity}"),
          Text("降水量：                  ${_weatherNowResp?.now.precip}"),
          Text("大气压强：                 ${_weatherNowResp?.now.pressure}"),
          Text("能见度，默认单位：公里：     ${_weatherNowResp?.now.vis}"),
          Text("云量：                    ${_weatherNowResp?.now.cloud}"),
          Text("实况云量：                 ${_weatherNowResp?.now.dew}"),
        ],
      ),
    );
  }
}
