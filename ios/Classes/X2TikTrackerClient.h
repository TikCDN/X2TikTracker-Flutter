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

@property (strong, nonatomic) FlutterEventSink eventSink;

- (instancetype)initWithChannel:(FlutterMethodChannel *)channel;

- (void)createWithAppid:(NSString *)appId;

- (void)releases;

- (NSInteger)startPlay:(NSString *)url share:(BOOL)share;

- (NSInteger)stopPlay;

- (NSInteger)startShare;

- (NSInteger)stopShare;

- (NSString *)getExUrl;

- (void)registerListener;

- (void)removeListener;

@end

NS_ASSUME_NONNULL_END
