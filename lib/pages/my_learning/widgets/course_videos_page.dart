import 'package:flutter/material.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/pages/my_learning/services/my_learnings_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class Video {
  final String name;
  final String url;
  final String thumbnail;

  Video({required this.name, required this.url, required this.thumbnail});
}

final videos = [
  Video(
      name: "Python",
      thumbnail:
          "http://learningapp.e8demo.com/media/thumbnail_img/5-chemistry.jpeg",
      url: "http://learningapp.e8demo.com/media/videos/1-python-basics.mp4"),
  Video(
      name: "Java",
      thumbnail:
          "http://learningapp.e8demo.com/media/thumbnail_img/5-chemistry.jpeg",
      url: "http://learningapp.e8demo.com/media/videos/1-python-basics.mp4")
];

class CourseVideosPage extends StatefulWidget {
  const CourseVideosPage({super.key});

  @override
  State<CourseVideosPage> createState() => _CourseVideosPageState();
}

class _CourseVideosPageState extends State<CourseVideosPage> {
  late MyLearningsProvider _myLearningsProvider;
  late VideoPlayerController _controller;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _myLearningsProvider =
        Provider.of<MyLearningsProvider>(context, listen: false);
    playVideo(init: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  playVideo({int index = 0, bool init = false}) {
    if (index < 0 ||
        index >= _myLearningsProvider.courseVideoList!.data!.length) return;
    if (!init) {
      _controller.pause();
    }
    setState(() {
      _currentIndex = index;
    });
    _controller = VideoPlayerController.network(_myLearningsProvider
        .courseVideoList!.data![_currentIndex].video
        .toString()
        .toString())
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((value) {
        _controller.play();
        _controller.setVolume(1);
      });
  }

  @override
  Widget build(BuildContext context) {
    final myLearningsProvider = Provider.of<MyLearningsProvider>(context);
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text("My Learnings"),
      ),
      body: myLearningsProvider.isCourseLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: size * .71,
                      child: _controller.value.isInitialized
                          ? Column(
                              children: [
                                SizedBox(
                                  height: size * .501,
                                  child: VideoPlayer(_controller),
                                ),
                                kHeight,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ValueListenableBuilder(
                                          valueListenable: _controller,
                                          builder: (context,
                                              VideoPlayerValue value, child) {
                                            return Text(
                                              _videoDuration(value.position),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17),
                                            );
                                          }),
                                      Expanded(
                                        child: VideoProgressIndicator(
                                            _controller,
                                            allowScrubbing: true,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 0)),
                                      ),
                                      Text(
                                        _videoDuration(
                                            _controller.value.duration),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      )
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _controller.value.isPlaying
                                          ? _controller.pause()
                                          : _controller.play();
                                    },
                                    icon: Icon(
                                      _controller.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.white,
                                      size: 40,
                                    ))
                              ],
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            )),
                  kHeight,
                  Text(
                    myLearningsProvider
                            .courseVideoList?.data?[_currentIndex].topicName
                            .toString() ??
                        "Introduction to Cloud computing on AWS for Beginners[2022])",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  kHeight5,
                  Text(
                    myLearningsProvider
                            .courseVideoList?.data?[_currentIndex].description
                            .toString() ??
                        "Introduction to Cloud computing on AWS for Beginners[2022])",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  kHeight,
                  Expanded(
                      child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        myLearningsProvider.courseVideoList?.data?.length,
                    itemBuilder: (context, index) {
                      final datas =
                          myLearningsProvider.courseVideoList?.data?[index];
                      return InkWell(
                        onTap: () => playVideo(index: index),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 8),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            datas!.thumbnail.toString()))),
                                height: size * .21,
                                width: size * .25,
                              ),
                              kWidth10,
                              Expanded(
                                child: Text(
                                  datas.topicName.toString(),
                                  style: const TextStyle(
                                      //overflow: TextOverflow.ellipsis,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ))
                ],
              ),
            ),
    );
  }
}
