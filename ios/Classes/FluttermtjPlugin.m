#import "FluttermtjPlugin.h"
#import "BaiduMobStat.h"

static NSString* const StartBaiduMobileStat = @"startBaiduMobileStat";
static NSString* const SetDebug = @"setDebug";
static NSString* const LogEvent = @"logEvent";
static NSString* const LogEventWithDurationTime = @"logEventWithDurationTime";
static NSString* const LogEventWithOneSecond = @"logEventWithOneSecond";
static NSString* const LogEventWithAttribute = @"logEventWithAttribute";
static NSString* const LogEventWithOneSecondAndAttributes = @"logEventWithOneSecondAndAttributes";
static NSString* const LogEventWithDurationTimeAndAttributes = @"logEventWithDurationTimeAndAttributes";
static NSString* const PageviewStartWithName = @"pageviewStartWithName";
static NSString* const PageviewEndWithName = @"pageviewEndWithName";

@interface FlutterMtjPlugin () {
    BOOL eventState;
    BOOL eventAttributeState;
}
@end

@implementation FluttermtjPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"fluttermtj"
            binaryMessenger:[registrar messenger]];
  FluttermtjPlugin* instance = [[FluttermtjPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {

  NSString* method = call.method;
  NSArray* arguments = (NSArray *)call.arguments;
  BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
  
  if([method isEqualToString:StartBaiduMobileStat]){
    NSString* appId = arguments[0];
    argumentSetNSNullToNil(appId);
    [statTracker startWithAppId:appId];
    return (nil);
  } else if([method isEqualToString: SetDebug]) {
    BOOL isOn = arguments[0];
    argumentSetNSNullToNil(isOn);
    statTracker.enableDebugOn  = isOn;
    return (nil);
  } else if([method isEqualToString: LogEvent]){
    NSString * eventId = arguments[0];
    argumentSetNSNullToNil(eventId);
    [statTracker logEvent:eventId];
    return (nil);
  } else if([method isEqualToString: LogEventWithDurationTime]){
    NSString * eventId = arguments[0];
    argumentSetNSNullToNil(eventId);
    if(!eventState) {
        eventState = YES;
        [statTracker eventStart:eventId];
    } else {
        eventState = NO;
        [statTracker eventEnd:eventId];
    }
  } else if([method isEqualToString: LogEventWithOneSecond]){
    NSString * eventId = arguments[0];
    argumentSetNSNullToNil(eventId);
    [statTracker logEventWithDurationTime:eventId durationTime:1000];
    return (nil);
  } else if([method isEqualToString: LogEventWithAttribute]){
    NSString * eventId = arguments[0];
    NSDictionary* attribute = arguments[1];
    argumentSetNSNullToNil(eventId);
    argumentSetNSNullToNil(attribute);

    [statTracker logEvent:eventId attributes:attribute];
    return (nil);
  } else if([method isEqualToString: LogEventWithOneSecondAndAttributes]{
    NSString * eventId = arguments[0];
    NSDictionary* attribute = arguments[1];
    argumentSetNSNullToNil(eventId);
    argumentSetNSNullToNil(attribute);

    [statTracker logEventWithDurationTime:eventId durationTime:1000 attributes:attribute];
    return (nil);
  } else if([method isEqualToString: LogEventWithDurationTimeAndAttributes]{
    NSString * eventId = arguments[0];
    NSDictionary* attribute = arguments[1];

    argumentSetNSNullToNil(eventId);
    argumentSetNSNullToNil(attribute);

    if(!eventAttributeState) {
        eventAttributeState = YES;
        [statTracker eventStart:eventId];
    } else {
        eventAttributeState = NO;
        [statTracker eventEnd:eventId attributes:attribute];
    }
    return (nil);
  } else if([method isEqualToString:PageviewStartWithName]){
    NSString * pageName = arguments[0];
    argumentSetNSNullToNil(pageName);
    [statTracker pageviewStartWithName:pageName];

    return (nil);
  } else if([method isEqualToString:PageviewEndWithName]){
    NSString * pageName = arguments[0];
    argumentSetNSNullToNil(pageName);
    [statTracker pageviewEndWithName:pageName];
    return (nil);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

static inline void argumentSetNSNullToNil(id *arg){
    *arg = (*arg == NSNull.null) ? nil:*arg;
}


@end
