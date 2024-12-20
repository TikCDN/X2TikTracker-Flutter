#import "X2tiktrackerFlutterPlugin.h"
#if __has_include(<x2tiktracker_flutter/x2tiktracker_flutter-Swift.h>)
#import <x2tiktracker_flutter/x2tiktracker_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "x2tiktracker_flutter-Swift.h"
#endif

@implementation X2tiktrackerFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftX2tiktrackerFlutterPlugin registerWithRegistrar:registrar];
}
@end
