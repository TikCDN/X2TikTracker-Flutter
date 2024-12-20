import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:x2tiktracker_flutter/x2tiktracker_flutter.dart';
import 'package:video_player/video_player.dart';


void main() => runApp(const VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Video Player Demo',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  StreamSubscription? _eventSubscription;

  // 使用Map存储每种事件和所有参数的最新状态
  final Map<String, String> _eventStatus = {
    'exUrl': '-',
    'allPeers': '-',
    'connectedPeers': '-',
    'allHttpDownload': '-',
    'allShareDownload': '-',
    'allShareUpload': '-',
    'speedHttpDownload': '-',
    'speedShareDownload': '-',
    'speedShareUpload': '-',
    'onPeerOff': '-',
    'onPeerOn': '-',
    'onRenewTokenResult': '-',
    'onShareResult': '-',
    'onTokenExpired': '-',
    'onTokenWillExpire': '-',
  };
  @override
  void initState() {
    super.initState();
    _initializeVideoPlayerFuture = _initializePlayer();
  }


  Future<void> _initializePlayer() async {
    await _initVideo();
    _setupEventListener();
  }

  void _setupEventListener() {
    if (_controller.value.isInitialized) {
      _eventSubscription = X2tiktrackerFlutter.eventStream.listen((event) {
        if (!mounted) return;

        setState(() {
          switch (event['event']) {
            case 'onLoadDataStats':
              _eventStatus['allPeers'] = '${event['data']['allPeers']}';
              _eventStatus['connectedPeers'] = '${event['data']['connectedPeers']}';
              _eventStatus['allHttpDownload'] = '${event['data']['allHttpDownload']}';
              _eventStatus['allShareDownload'] = '${event['data']['allShareDownload']}';
              _eventStatus['allShareUpload'] = '${event['data']['allShareUpload']}';
              _eventStatus['speedHttpDownload'] = '${event['data']['speedHttpDownload']}';
              _eventStatus['speedShareDownload'] = '${event['data']['speedShareDownload']}';
              _eventStatus['speedShareUpload'] = '${event['data']['speedShareUpload']}';
              break;
            case 'onPeerOff':
              _eventStatus['onPeerOff'] = '${event['peerId']}, ${event['peerData']}';
              break;
            case 'onPeerOn':
              _eventStatus['onPeerOn'] = '${event['peerId']}, ${event['peerData']}';
              break;
            case 'onRenewTokenResult':
              _eventStatus['onRenewTokenResult'] = '${event['token']}, ${event['errorCode']}';
              break;
            case 'onShareResult':
              _eventStatus['onShareResult'] = '${event['code']}';
              break;
            case 'onTokenExpired':
              _eventStatus['onTokenExpired'] = 'Expired';
              break;
            case 'onTokenWillExpire':
              _eventStatus['onTokenWillExpire'] = 'Will Expire';
              break;
          }
        });
      });
    }
  }

  Future<void> _initVideo() async {
    String? exUrl;
    final tracker = X2tiktrackerFlutter();
    await tracker.create('your-app-id');
    await tracker.registerListener();
    await tracker.startPlay('https://gcalic.v.myalicdn.com/gc/zyqcdx01_1/index.m3u8?contentid=2820180516001&useLivePlayer=true', share: true);
    exUrl = await tracker.getExUrl();
    setState(() {
      _eventStatus['exUrl'] = exUrl ?? '-'; // 更新 exUrl
    });
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        exUrl??"",
      ),
    );
    await _controller.initialize();
    _controller.setLooping(true);

  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('X2TikTrackerDemo'),
      ),
      body: Column(
        children: [
          // 视频播放区域
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          // 事件状态显示区域
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.grey[100],
              child: ListView(
                children: _eventStatus.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        // 事件名称
                        SizedBox(
                          width: 150,
                          child: Text(
                            entry.key,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Text(': '),
                        // 事件状态
                        Expanded(
                          child: Text(
                            entry.value,
                            style: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}