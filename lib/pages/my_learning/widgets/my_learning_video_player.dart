import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyLearningVideoPlayer extends StatefulWidget {
  const MyLearningVideoPlayer({super.key});

  @override
  State<MyLearningVideoPlayer> createState() => _MyLearningVideoPlayerState();
}

class _MyLearningVideoPlayerState extends State<MyLearningVideoPlayer> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        _controller.play();
        _controller.setLooping(false);
        _controller.setVolume(1);
      });
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = _controller.value.volume == 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Learning"),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15),
        children: [
          GestureDetector(
            // behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: SizedBox(
              height: 200,
              child: _controller.value.isInitialized
                  ? Stack(
                      children: [
                        AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller)),
                        _controller.value.isPlaying
                            ? const SizedBox()
                            : Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _controller.play();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 45,
                                    )),
                              ),
                        Positioned(
                          right: 10,
                          bottom: 5,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _controller.setVolume(isMuted ? 1 : 0);
                                  });
                                },
                                icon: Icon(
                                  isMuted ? Icons.volume_off : Icons.volume_up,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: VideoProgressIndicator(_controller,
                                  allowScrubbing: true)),
                        )
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ),
          // IconButton(
          //     onPressed: () {
          //       setState(() {
          //         _controller.value.isPlaying
          //             ? _controller.pause()
          //             : _controller.play();
          //       });
          //     },
          //     icon: Icon(
          //       _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          //       color: Colors.white,
          //       size: 45,
          //     ))
        ],
      ),
    );
  }
}
