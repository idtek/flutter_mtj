#import "FluttermtjPlugin.h"
#if __has_include(<fluttermtj/fluttermtj-Swift.h>)
#import <fluttermtj/fluttermtj-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fluttermtj-Swift.h"
#endif

@implementation FluttermtjPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFluttermtjPlugin registerWithRegistrar:registrar];
}
@end
