# x2tiktracker_flutter

P2P Streaming Engine for Flutter.

# Installation
To use the x2tiktracker_flutter plugin in your Flutter app, follow these steps:

Add the x2tiktracker_flutter dependency in your pubspec.yaml file:

```yaml 
dependencies:
  x2tiktracker_flutter: ^3.0.0
```

## Import it

Now in your Dart code, you can use:

```dart
import 'package:x2tiktracker_flutter/x2tiktracker_flutter.dart';
```

## Usage

```dart
    String? exUrl;
    final tracker = X2tiktrackerFlutter();
    await tracker.create('your-app-id');
    await tracker.registerListener();
    await tracker.startPlay('https://gcalic.v.myalicdn.com/gc/zyqcdx01_1/index.m3u8?contentid=2820180516001&useLivePlayer=true', share: true);
    exUrl = await tracker.getExUrl();
    
```

#  [API DOC](https://www.tikcdn.cc/docs/intro)