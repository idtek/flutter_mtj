#import "FluttermtjPlugin.h"
#import "BaiduMobStat.h"

static NSString* const StartBaiduMobileStat = @"StartBaiduMobileStat";
static NSString* const SetDebug = @"SetDebug";
static NSString* const LogEvent = @"LogEvent";
static NSString* const LogEventWithDurationTime = @"LogEventWithDurationTime";
static NSString* const LogEventWithOneSecond = @"LogEventWithOneSecond";
static NSString* const LogEventWithAttribute = @"LogEventWithAttribute";
static NSString* const LogEventWithOneSecondAndAttributes = @"LogEventWithOneSecondAndAttributes";
static NSString* const LogEventWithDurationTimeAndAttributes = @"LogEventWithDurationTimeAndAttributes";
static NSString* const PageviewStartWithName = @"PageviewStartWithName";
static NSString* const PageviewEndWithName = @"PageviewEndWithName";

@interface FluttermtjPlugin () {
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
    //argumentSetNSNullToNil(appId);
    [statTracker startWithAppId:appId];
  } else if([method isEqualToString: SetDebug]) {
    BOOL isOn = arguments[0];
    //argumentSetNSNullToNil(isOn);
    statTracker.enableDebugOn  = isOn;
  } else if([method isEqualToString: LogEvent]){
    NSString * eventId = arguments[0];
    //argumentSetNSNullToNil(eventId);
    [statTracker logEvent:eventId];
  } else if([method isEqualToString: LogEventWithDurationTime]){
    NSString * eventId = arguments[0];
    //argumentSetNSNullToNil(eventId);
    if(!eventState) {
        eventState = YES;
        [statTracker eventStart:eventId];
    } else {
        eventState = NO;
        [statTracker eventEnd:eventId];
    }
  } else if([method isEqualToString: LogEventWithOneSecond]){
    NSString * eventId = arguments[0];
    //argumentSetNSNullToNil(eventId);
    [statTracker logEventWithDurationTime:eventId durationTime:1000];
  } else if([method isEqualToString: LogEventWithAttribute]){
    NSString * eventId = arguments[0];
    NSDictionary* attribute = arguments[1];
    //argumentSetNSNullToNil(eventId);
    //argumentSetNSNullToNil(attribute);

    [statTracker logEvent:eventId attributes:attribute];

  } else if([method isEqualToString: LogEventWithOneSecondAndAttributes]){
    NSString * eventId = arguments[0];
    NSDictionary* attribute = arguments[1];
    //argumentSetNSNullToNil(eventId);
    //argumentSetNSNullToNil(attribute);

    [statTracker logEventWithDurationTime:eventId durationTime:1000 attributes:attribute];
  } else if([method isEqualToString: LogEventWithDurationTimeAndAttributes]){
    NSString * eventId = arguments[0];
    NSDictionary* attribute = arguments[1];

    //argumentSetNSNullToNil(eventId);
    //argumentSetNSNullToNil(attribute);

    if(!eventAttributeState) {
        eventAttributeState = YES;
        [statTracker eventStart:eventId];
    } else {
        eventAttributeState = NO;
        [statTracker eventEnd:eventId attributes:attribute];
    }

  } else if([method isEqualToString:PageviewStartWithName]){
    NSString * pageName = arguments[0];
    //argumentSetNSNullToNil(pageName);
    [statTracker pageviewStartWithName:pageName];
  } else if([method isEqualToString:PageviewEndWithName]){
    NSString * pageName = arguments[0];
    //argumentSetNSNullToNil(pageName);
    [statTracker pageviewEndWithName:pageName];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

static inline void argumentSetNSNullToNil(id *arg){
    *arg = (*arg == NSNull.null) ? nil:*arg;
}


@end
