import 'package:flutter/material.dart';
import 'package:nuox_project/pages/my_learning/widgets/my_learning_video_player.dart';

import '../../../constants/constants.dart';

class MyLearningCard extends StatelessWidget {
  const MyLearningCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MyLearningVideoPlayer()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://www.chegg.com/play/wp-content/uploads/sites/3/2020/05/7-Tips-and-Tricks-to-Boost-Your-Learning-During-Online-Lectures_featuredimage.jpg"))),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Comeplete Guitar Lessons System - Beginner to Advanced",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      KHeight5,
                      Text(
                        "Erich Andreas",
                        style: TextStyle(fontSize: 12, color: Colors.grey[300]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
