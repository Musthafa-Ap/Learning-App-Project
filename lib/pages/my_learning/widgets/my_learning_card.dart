import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nuox_project/pages/my_learning/services/my_learnings_provider.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';

class MyLearningCard extends StatelessWidget {
  final int? rating;
  final int? ratingCount;
  final String? variant;
  final int? id;
  final String? courseName;
  final String? author;
  final String? img;
  const MyLearningCard({
    Key? key,
    required this.id,
    required this.courseName,
    required this.author,
    required this.img,
    required this.variant,
    required this.rating,
    required this.ratingCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final myLearningsProvider = Provider.of<MyLearningsProvider>(context);
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () async {
        if (id != null) {
          await myLearningsProvider.getCourseDetailes(
              courseID: id, context: context);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        height: size * .3,
        // color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size * .3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(img ??
                            "https://www.chegg.com/play/wp-content/uploads/sites/3/2020/05/7-Tips-and-Tricks-to-Boost-Your-Learning-During-Online-Lectures_featuredimage.jpg"))),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseName ??
                            "Comeplete Guitar Lessons System - Beginner to Advanced",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      // kHeight5,
                      Text(
                        author ?? "Erich Andreas",
                        style: TextStyle(fontSize: 13, color: Colors.grey[300]),
                      ),
                      // kHeight5,
                      Text(
                        variant ?? "Beginner",
                        style: TextStyle(fontSize: 13, color: Colors.grey[300]),
                      ),
                      // kHeight5,
                      Row(
                        children: [
                          Text(
                            rating.toString(),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.yellow),
                          ),
                          RatingBarIndicator(
                            unratedColor: Colors.grey,
                            rating: rating?.toDouble() ?? 4,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            itemCount: 5,
                            itemSize: 10.0,
                            direction: Axis.horizontal,
                          ),
                          Text(
                            ratingCount != null ? " ($ratingCount)" : " (7)",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.yellow),
                          ),
                        ],
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
