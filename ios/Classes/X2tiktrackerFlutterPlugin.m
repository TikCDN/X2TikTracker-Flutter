#import "X2tiktrackerFlutterPlugin.h"
#if __has_include(<x2tiktracker_flutter/x2tiktracker_flutter-Swift.h>)
#import <x2tiktracker_flutter/x2tiktracker_flutter-Swift.h>
#else
#import "x2tiktracker_flutter-Swift.h"
#endif
#import "X2TikTrackerClient.h"

@interface X2tiktrackerFlutterPlugin ()
@property (nonatomic, strong) X2TikTrackerClient *x2TikTracker;
@property (nonatomic, strong) FlutterMethodChannel *channel;
@end

@implementation X2tiktrackerFlutterPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    X2tiktrackerFlutterPlugin *instance = [[X2tiktrackerFlutterPlugin alloc] init];
    instance.channel = [FlutterMethodChannel methodChannelWithName:@"x2tiktracker_flutter"
                                               binaryMessenger:[registrar messenger]];
    [registrar addMethodCallDelegate:instance channel:instance.channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([@"create" isEqualToString:call.method]) {
        NSString *appId = call.arguments[@"appId"];
        if (appId) {
            if (!self.x2TikTracker) {
                self.x2TikTracker = [[X2TikTrackerClient alloc] initWithChannel:self.channel];
            }
            [self.x2TikTracker createWithAppid:appId];
            result(@(0));
        } else {
            result([FlutterError errorWithCode:@"INVALID_ARGUMENT"
                                       message:@"appId is required"
                                       details:nil]);
        }
    } else if ([@"release" isEqualToString:call.method]) {
        [self.x2TikTracker releases];
        self.x2TikTracker = nil;
        result(@(0));
    } else if ([@"startPlay" isEqualToString:call.method]) {
        NSString *url = call.arguments[@"url"];
        BOOL share = [call.arguments[@"share"] boolValue];
        if (url) {
            NSInteger resultCode = [self.x2TikTracker startPlay:url share:share];
            result(@(resultCode));
        } else {
            result([FlutterError errorWithCode:@"INVALID_ARGUMENT"
                                       message:@"url is required"
                                       details:nil]);
        }
    } else if ([@"stopPlay" isEqualToString:call.method]) {
        NSInteger resultCode = [self.x2TikTracker stopPlay];
        result(@(resultCode));
    } else if ([@"startShare" isEqualToString:call.method]) {
        NSInteger resultCode = [self.x2TikTracker startShare];
        result(@(resultCode));
    } else if ([@"stopShare" isEqualToString:call.method]) {
        NSInteger resultCode = [self.x2TikTracker stopShare];
        result(@(resultCode));
    } else if ([@"getExUrl" isEqualToString:call.method]) {
        NSString *exUrl = [self.x2TikTracker getExUrl] ?: @"";
        result(exUrl);
    } else if ([@"registerListener" isEqualToString:call.method]) {
        [self.x2TikTracker registerListener];
        result(@"Listener Registered");
    } else if ([@"removeListener" isEqualToString:call.method]) {
        [self.x2TikTracker removeListener];
        result(@"Listener Removed");
    }  else if ([@"getVersion" isEqualToString:call.method]) {
        NSString *version = [self.x2TikTracker getVersion];
        result(version);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
