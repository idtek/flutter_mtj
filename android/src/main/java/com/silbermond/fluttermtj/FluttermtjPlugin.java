package com.silbermond.fluttermtj;

import android.content.Context;
import android.util.Log;

import com.baidu.mobstat.SendStrategyEnum;
import com.baidu.mobstat.StatService;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;

/** FluttermtjPlugin */
public class FluttermtjPlugin implements FlutterPlugin, MethodCallHandler {

  private static String BAIDU_APPKEY = "fd5c11abc0";
  static String TAG = "====baidu mjt ===";
  private boolean eventState = false;
  private boolean eventAttributeState = false;
  private Context mContext;

  @Override
  public void onAttachedToEngine( FlutterPluginBinding flutterPluginBinding) {
    final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "fluttermtj");
    channel.setMethodCallHandler(new FluttermtjPlugin());
    mContext = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onDetachedFromEngine(FlutterPluginBinding flutterPluginBinding) {

  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "fluttermtj");
    channel.setMethodCallHandler(new FluttermtjPlugin());
  }

  @Override
  public void onMethodCall( MethodCall call, Result result) {
    HashMap<String, Object> map = call.arguments();
    switch (call.method) {
      case "getPlatformVersion":
        result.success("Android " + android.os.Build.VERSION.RELEASE);
        break;
      case "StartBaiduMobileStat":
        String appId = (String) map.get("appId");
        appId = appId == null ? "" : appId;
        StatService.setAppKey(appId);
        break;
      case "SetDebug":
        // Log.d(TAG,"setup :" + call.arguments);
        boolean debug = (boolean)map.get("debug");
        StatService.setDebugOn(debug);
        break;
      case "LogEvent": {
        String eventId = (String) map.get("eventId");
        eventId = eventId == null ? "" : eventId;
        StatService.onEvent(mContext, eventId, "LogEvent");
        break;
      }
      case "LogEventWithDurationTime": {
        String eventId = (String) map.get("eventId");
        eventId = eventId == null ? "" : eventId;
        if (!eventState) {
          eventState = true;
          StatService.onEventStart(mContext, eventId, "LogEventWithDurationTime");
        } else {
          eventState = false;
          StatService.onEventEnd(mContext, eventId, "LogEventWithDurationTime");
        }}
      break;
      case "LogEventWithOneSecond": {
        String eventId = (String) map.get("eventId");
        eventId = eventId == null ? "" : eventId;
        StatService.onEventDuration(mContext,eventId, "LogEventWithOneSecond", 1000);
      }
      break;
      case "LogEventWithAttribute":
      {
        String eventId = (String) map.get("eventId");
        eventId = eventId == null ? "" : eventId;
        Map<String, String> attr = (Map<String, String>) map.get("attributes");
        attr = attr == null ? new HashMap<String, String>() : attr;
        StatService.onEvent(mContext, eventId, "LogEventWithOneSecondAndAttributes",1,attr );
      }
      break;
      case "LogEventWithOneSecondAndAttributes": {
        String eventId = (String) map.get("eventId");
        eventId = eventId == null ? "" : eventId;
        Map<String, String> attr = (Map<String, String>) map.get("attributes");
        attr = attr == null ? new HashMap<String, String>() : attr;
        StatService.onEventDuration(mContext, eventId, "LogEventWithDurationTimeAndAttributes", 1000, attr);
      }
      case "LogEventWithDurationTimeAndAttributes":
      {
        String eventId = (String) map.get("eventId");
        eventId = eventId == null ? "" : eventId;
        Map<String, String> attr = (Map<String, String>) map.get("attributes");
        attr = attr == null ? new HashMap<String, String>() : attr;
        if (!eventAttributeState) {
          eventAttributeState = true;
          StatService.onEventStart(mContext, eventId, "LogEventWithDurationTimeAndAttributes");
        } else {
          eventAttributeState = false;
          StatService.onEventEnd(mContext, eventId, "LogEventWithDurationTimeAndAttributes", attr);
        }
      }
      break;
      case "PageviewStartWithName":
      {
        String pageName = (String) map.get("pageName");
        pageName = pageName == null ? "" : pageName;
        StatService.onPageStart(mContext, pageName);
      }
      break;
      case "PageviewEndWithName":
      {
        String pageName = (String) map.get("pageName");
        pageName = pageName == null ? "" : pageName;
        StatService.onPageEnd(mContext, pageName);
      }
      break;
      default:
        result.notImplemented();
        break;
    }
  }
}