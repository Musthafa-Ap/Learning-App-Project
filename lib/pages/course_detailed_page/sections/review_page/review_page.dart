import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_provider.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatelessWidget {
  int id;
  ReviewPage({required this.id});
  ValueNotifier<int> _ratingNotifier = ValueNotifier(1);
  TextEditingController _reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final courseDetailedProvider = Provider.of<CourseDetailedProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Review"),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15),
        children: [
          ValueListenableBuilder(
            valueListenable: _ratingNotifier,
            builder: (context, value, child) {
              return Center(
                child: Column(
                  children: [
                    RatingBar.builder(
                        updateOnDrag: true,
                        unratedColor: Colors.grey,
                        initialRating: 1,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                        onRatingUpdate: (rating) {
                          _ratingNotifier.value = rating.toInt();
                        }),
                    Text(
                      _ratingNotifier.value.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              );
            },
          ),
          KHeight20,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black,
                border: Border.all(color: Colors.white)),
            child: TextField(
              controller: _reviewController,
              style: TextStyle(color: Colors.white),
              maxLines: 6,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Any suggestions...",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
          ),
          KHeight20,
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                var rating = _ratingNotifier.value;
                var review = _reviewController.text;
                print(review);
                print(rating);
                if (review == null || review.isEmpty) {
                  courseDetailedProvider.addRatingWithoutReview(
                      context: context, rating: rating, id: id);
                  print(rating.toString());
                  print("review is null");
                } else {
                  await courseDetailedProvider.addRatingWithReview(
                      rating: rating, id: id, review: review, context: context);
                  _reviewController.text = "";
                }
                //Navigator.of(context).pop();
              },
              child: Text("Submit"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple)),
            ),
          ),
          KHeight20,
          KHeight20,
          courseDetailedProvider.isReviewLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(5),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: courseDetailedProvider.getReviewList!.data!.length,
                  itemBuilder: (context, index) {
                    final datas =
                        courseDetailedProvider.getReviewList!.data![index];
                    return ReviewCard(
                      rating: datas.rating.toString(),
                      review: datas.review.toString(),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  String rating;
  String review;
  ReviewCard({required this.rating, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5)),
      child: Row(children: [
        Container(
          height: 22,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.green,
          ),
          child: Row(children: [
            Spacer(),
            Text(
              rating,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Icon(
              Icons.star,
              size: 14,
              color: Colors.white,
            ),
            Spacer(),
          ]),
        ),
        KWidth10,
        Expanded(
          child: Text(
            review,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
        )
      ]),
    );
  }
}
