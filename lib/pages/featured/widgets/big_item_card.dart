import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nuox_project/pages/featured/services/featured_section/featured_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/constants.dart';
import '../../../my_home_page.dart';
import '../../../widgets/bestseller.dart';
import '../../../widgets/big_cart_icon_button.dart';
import '../../course_detailed_page/course_detailed_page.dart';
import '../../course_detailed_page/services/course_detailed_provider.dart';

class BigItemCard extends StatelessWidget {
  final int? ratingCount;
  final bool? isRecomended;
  final int? id;
  final String? courseName;
  final String? authorName;
  final int? coursePrice;
  final double? rating;
  final String? image;
  const BigItemCard({
    Key? key,
    required this.courseName,
    required this.authorName,
    required this.coursePrice,
    required this.rating,
    required this.image,
    required this.id,
    this.isRecomended = true,
    required this.ratingCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final featuredProvider = Provider.of<FeaturedProvider>(context);
    var size = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        if (id != null) {
          await Provider.of<CourseDetailedProvider>(context, listen: false)
              .getAll(courseID: id);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CourseDetailedPage()));
        }
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: size * .73,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size * .375,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(image ??
                                "http://learningapp.e8demo.com/media/thumbnail_img/5-chemistry.jpeg"))),
                  ),
                  kHeight5,
                  Text(
                    courseName ?? "Course name",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  kHeight5,
                  Text(
                    authorName ?? "Instructor",
                    style: TextStyle(fontSize: 12, color: Colors.grey[300]),
                  ),
                  kHeight5,
                  Row(
                    children: [
                      Text(
                        "${rating ?? "4"} ",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.yellow),
                      ),
                      RatingBarIndicator(
                        unratedColor: Colors.grey,
                        rating: rating ?? 3,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        itemCount: 5,
                        itemSize: 10.0,
                        direction: Axis.horizontal,
                      ),
                      Text(
                        ratingCount != null ? " ($ratingCount)" : " (36,000)",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.yellow),
                      ),
                    ],
                  ),
                  kHeight5,
                  Text(
                    "₹ ${coursePrice ?? "Course price"}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  kHeight5,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // isRecomended! ? BestsellerWidget() : SizedBox(),
                      const BestsellerWidget(),
                      id != null
                          ? BigCartIconButton(
                              id: id!.toInt(),
                              price: coursePrice!.toInt(),
                            )
                          : const SizedBox()
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              right: 10,
              top: 8,
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    //color: Color.fromARGB(255, 194, 193, 192),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: GestureDetector(
                  onTap: () async {
                    SharedPreferences shared =
                        await SharedPreferences.getInstance();
                    var token = shared.getString("access_token");
                    if (token == null) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const Test()),
                        (route) => false,
                      );
                    } else {
                      featuredProvider.addToWhishlist(
                          id: id,
                          variant: 1,
                          context: context,
                          price: coursePrice);
                    }
                  },
                  child: const Icon(
                    Icons.favorite_border,
                    size: 25,
                    color: Colors.white,
                  ),
                )),
              )),
        ],
      ),
    );
  }
}
