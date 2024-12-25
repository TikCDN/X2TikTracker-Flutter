//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<video_player_avfoundation/FVPVideoPlayerPlugin.h>)
#import <video_player_avfoundation/FVPVideoPlayerPlugin.h>
#else
@import video_player_avfoundation;
#endif

#if __has_include(<x2tiktracker_flutter/X2tiktrackerFlutterPlugin.h>)
#import <x2tiktracker_flutter/X2tiktrackerFlutterPlugin.h>
#else
@import x2tiktracker_flutter;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FVPVideoPlayerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FVPVideoPlayerPlugin"]];
  [X2tiktrackerFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"X2tiktrackerFlutterPlugin"]];
}

@end
