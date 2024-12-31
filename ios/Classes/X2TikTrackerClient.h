//
//  X2TikTrackerClient.h
//  x2tiktracker_flutter
//
//  Created by 余生 on 2024/12/22.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface X2TikTrackerClient : NSObject

// Flutter 事件接收器，用于发送事件到 Flutter
@property (strong, nonatomic) FlutterEventSink eventSink;

// 初始化方法，接收一个 Flutter 方法通道
- (instancetype)initWithChannel:(FlutterMethodChannel *)channel;

// 初始化
- (void)createWithAppid:(NSString *)appId;

// 释放资源的方法
- (void)releases;

// 开始播放指定 URL 的媒体，返回状态码；share 表示是否共享
- (NSInteger)startPlay:(NSString *)url share:(BOOL)share;

// 停止播放媒体
- (NSInteger)stopPlay;

// 开始共享媒体
- (NSInteger)startShare;

// 停止共享媒体
- (NSInteger)stopShare;

// 获取扩展 URL
- (NSString *)getExUrl;

// 注册监听器
- (void)registerListener;

// 移除监听器
- (void)removeListener;

// 获取版本信息
- (NSString *)getVersion;

@end

NS_ASSUME_NONNULL_END
