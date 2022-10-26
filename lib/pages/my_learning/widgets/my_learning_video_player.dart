import 'package:flutter/material.dart';

class MyLearningVideoPlayer extends StatefulWidget {
  const MyLearningVideoPlayer({super.key});

  @override
  State<MyLearningVideoPlayer> createState() => _MyLearningVideoPlayerState();
}

class _MyLearningVideoPlayerState extends State<MyLearningVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learning"),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15),
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
