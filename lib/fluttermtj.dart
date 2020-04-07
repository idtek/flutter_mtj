import 'dart:async';

import 'package:flutter/services.dart';

class Fluttermtj {
  static const MethodChannel _channel =
      const MethodChannel('flutter_mtj');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  // 初始化百度移动统计平台 
  static void StartBaiduMobileStat(String appId) {
    assert(appId != null);
    List<dynamic> params = [appId];
    _channel.invokeMethod('StartBaiduMobileStat', params);
  }

  // 
  static void SetDebug(bool debug) {
    assert(debug != null);
    List<dynamic> params = [debug];
    _channel.invokeMethod('SetDebug', params);
  }

  static void LogEvent(String eventId) {
    assert(eventId != null);
    List<dynamic> params = [eventId];
    _channel.invokeMethod('LogEvent', params);
  }

  //需要在开始和结束时都调用
  static void LogEventWithDurationTime(String eventId) {
    assert(eventId != null);
    List<dynamic> params = [eventId];
    _channel.invokeMethod('LogEventWithDurationTime', params);
  }
  
  static void LogEventWithOneSecond(String eventId) {
    assert(eventId != null);
    List<dynamic> params = [eventId];
    _channel.invokeMethod('LogEventWithOneSecond', params);
  }

  static void LogEventWithAttribute(String eventId, Map<String, String> map) {
    assert(eventId != null);
    List<dynamic> params = [eventId, map];
    _channel.invokeMethod('LogEventWithAttribute', params);
  }

  static void LogEventWithOneSecondAndAttributes(String eventId, Map<String, String> map) {
    assert(eventId != null);
    List<dynamic> params = [eventId, map];
    _channel.invokeMethod('LogEventWithOneSecondAndAttributes', params);
  }

  //需要在开始和结束时都调用
  static void LogEventWithDurationTimeAndAttributes(String eventId, {Map<String, String> map}) {
    assert(eventId != null);
    List<dynamic> params = [eventId, map];
    _channel.invokeMethod('LogEventWithDurationTimeAndAttributes', params);
  }

  static void PageviewStartWithName(String pageName) {
    assert(pageName != null);
    List<dynamic> params = [pageName];
    _channel.invokeMethod('PageviewStartWithName', params);
  }

  static void PageviewEndWithName(String pageName) {
    assert(pageName != null);
    List<dynamic> params = [pageName];
    _channel.invokeMethod('PageviewEndWithName', params);
  }
}
