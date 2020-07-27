import 'dart:async';

import 'package:flutter/services.dart';

class Fluttermtj {
  static bool isRelease = false;
  static const MethodChannel _channel =
      const MethodChannel('fluttermtj');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  // 初始化百度移动统计平台 
  static void StartBaiduMobileStat(String appId, bool currentEnv) {
    assert(appId != null);
    isRelease = currentEnv;
    if (!currentEnv) return; 
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
    if (!isRelease) return;
    assert(eventId != null);
    List<dynamic> params = [eventId];
    _channel.invokeMethod('LogEvent', params);
  }

  //需要在开始和结束时都调用
  static void LogEventWithDurationTime(String eventId) {
    if (!isRelease) return;
    assert(eventId != null);
    List<dynamic> params = [eventId];
    _channel.invokeMethod('LogEventWithDurationTime', params);
  }

  // 指定事件触发次数
  static void LogEventWithNumberOfTime(String eventId, int time) {
    if (!isRelease) return;
    assert(eventId != null);
    List<dynamic> params = [eventId, time];
    _channel.invokeMethod('LogEventWithNumberOfTime', params);
  }
  
  static void LogEventWithOneSecond(String eventId) {
    if (!isRelease) return;
    assert(eventId != null);
    List<dynamic> params = [eventId];
    _channel.invokeMethod('LogEventWithOneSecond', params);
  }

  static void LogEventWithAttribute(String eventId, Map<String, String> map) {
    if (!isRelease) return;
    assert(eventId != null);
    List<dynamic> params = [eventId, map];
    _channel.invokeMethod('LogEventWithAttribute', params);
  }

  static void LogEventWithOneSecondAndAttributes(String eventId, Map<String, String> map) {
    if (!isRelease) return;
    assert(eventId != null);
    List<dynamic> params = [eventId, map];
    _channel.invokeMethod('LogEventWithOneSecondAndAttributes', params);
  }

  //需要在开始和结束时都调用
  static void LogEventWithDurationTimeAndAttributes(String eventId, {Map<String, String> map}) {
    if (!isRelease) return;
    assert(eventId != null);
    List<dynamic> params = [eventId, map];
    _channel.invokeMethod('LogEventWithDurationTimeAndAttributes', params);
  }

  static void PageviewStartWithName(String pageName) {
    if (!isRelease) return;
    assert(pageName != null);
    List<dynamic> params = [pageName];
    _channel.invokeMethod('PageviewStartWithName', params);
  }

  static void PageviewEndWithName(String pageName) {
    if (!isRelease) return;
    assert(pageName != null);
    List<dynamic> params = [pageName];
    _channel.invokeMethod('PageviewEndWithName', params);
  }
}
