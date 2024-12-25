//
//  X2TikTrackerClient.m
//  x2tiktracker_flutter
//
//  Created by 余生 on 2024/12/22.
//

#import "X2TikTrackerClient.h"
#import <x2tiktracker_flutter/x2tiktracker_flutter-Swift.h>
#import <X2TikTracker/X2TikTrackerEngine.h>

@interface X2TikDataStats()

- (NSDictionary *)toMap;

@end

@interface X2TikTrackerClient () <FlutterStreamHandler,X2TikTrackerDelegate>
@property (nonatomic, strong) X2TikTrackerEngine *x2TikTrackerEngine;
@property (nonatomic, strong) FlutterMethodChannel *channel;
@end

@implementation X2TikTrackerClient

- (instancetype)initWithChannel:(FlutterMethodChannel *)channel {
    self = [super init];
    if (self) {
        _channel = channel;
    }
    return self;
}

- (void)createWithAppid:(NSString *)appId {
    self.x2TikTrackerEngine = [[X2TikTrackerEngine alloc] initWithDelegate:self appId:appId];
}

- (void)releases {
    [self.x2TikTrackerEngine release:YES];
    self.x2TikTrackerEngine = nil;
}

- (NSInteger)startPlay:(NSString *)url share:(BOOL)share {
    return [self.x2TikTrackerEngine startPlay:url share:share];
}

- (NSInteger)stopPlay {
    return [self.x2TikTrackerEngine stopPlay];
}

- (NSInteger)startShare {
    return [self.x2TikTrackerEngine startShare];
}

- (NSInteger)stopShare {
    return [self.x2TikTrackerEngine stopShare];
}

- (NSString *)getExUrl {
    return self.x2TikTrackerEngine.getExPlayUrl;
}

- (void)registerListener {
    self.x2TikTrackerEngine.delegate = self;
}

- (void)removeListener {
    self.x2TikTrackerEngine.delegate = nil;
}

//MARK: - FlutterStreamHandler

- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)arguments {
  _eventSink = nil;
  return nil;
}

- (FlutterError * _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(nonnull FlutterEventSink)events {
  _eventSink = events;
  return nil;
}

- (void)sendClientEvent:(NSString *)name params:(NSDictionary*)params {
  if (_eventSink) {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:params];
    dict[@"event"] = name;
    _eventSink([dict copy]);
  }
}

//MARK: - X2TikTrackerDelegate methods

- (void)onShareResult:(X2TKTCode)nCode {
    /// 分享结果回调
    [self sendEvent:@{@"event": @"onShareResult", @"code": @(nCode)}];
}

- (void)onLoadDataStats:(X2TikDataStats *)stats {
    /// 数据统计加载回调
    [self sendEvent:@{@"event": @"onLoadDataStats", @"data": [stats toMap]}];
    NSLog(@"onLoadDataStats %@", stats.toMap);
}

- (void)onPeerOn:(NSString *)peerId peerData:(NSString *)peerData {
    /// 对等连接建立回调
    [self sendEvent:@{@"event": @"onPeerOn", @"peerId": peerId, @"peerData": peerData}];
}

- (void)onPeerOff:(NSString *)peerId peerData:(NSString *)peerData {
    /// 对等连接断开回调
    [self sendEvent:@{@"event": @"onPeerOff", @"peerId": peerId, @"peerData": peerData}];
}

- (void)onRenewTokenResult:(NSString *)token errorCode:(X2RenewTokenErrCode)errorCode {
    /// token 续期结果回调
    [self sendEvent:@{@"event": @"onRenewTokenResult", @"token": token, @"errorCode": @(errorCode)}];
}

- (void)onTokenWillExpired {
    /// token 即将过期回调
    [self sendEvent:@{@"event": @"onTokenWillExpire"}];
}

- (void)onTokenExpired {
    /// token 已过期回调
    [self sendEvent:@{@"event": @"onTokenExpired"}];
}

- (void)sendEvent:(NSDictionary *)eventData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.channel invokeMethod:@"onEvent" arguments:eventData];
    });
}

@end
