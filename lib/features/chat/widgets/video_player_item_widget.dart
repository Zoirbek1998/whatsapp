import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoPlayerItem extends ConsumerStatefulWidget {
  final String videoUrl;

  const VideoPlayerItem({super.key, required this.videoUrl});

  @override
  ConsumerState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends ConsumerState<VideoPlayerItem> {
  late CachedVideoPlayerController videoPlayerController;
  bool isPlay = false;

  @override
  void initState() {
    videoPlayerController = CachedVideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        videoPlayerController.setVolume(1);
      });
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 15 / 20,
      child: Stack(
        children: [
          CachedVideoPlayer(videoPlayerController),
          Align(
              alignment: Alignment.center,
              child: IconButton(
                  onPressed: () {
                    if(isPlay){
                      videoPlayerController.pause();
                    }else{
                      videoPlayerController.play();
                    }
                    setState(() {
                      isPlay = !isPlay;
                    });
                  },
                  icon: Icon(isPlay ? Icons.pause_circle : Icons.play_circle)))
        ],
      ),
    );
  }
}
