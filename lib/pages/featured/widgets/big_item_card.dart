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
import '../services/top_courses_section/top_courses_provider.dart';

class BigItemCard extends StatefulWidget {
  final bool? isWishList;
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
    this.isWishList,
  }) : super(key: key);

  @override
  State<BigItemCard> createState() => _BigItemCardState();
}

class _BigItemCardState extends State<BigItemCard> {
  @override
  void initState() {
    get();
    super.initState();
  }

  String? token;
  void get() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    setState(() {
      token = shared.getString("access_token");
    });
  }

  @override
  Widget build(BuildContext context) {
    final featuredProvider = Provider.of<FeaturedProvider>(context);
    var size = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        if (widget.id != null) {
          await Provider.of<CourseDetailedProvider>(context, listen: false)
              .getAll(courseID: widget.id);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CourseDetailedPage(
                    refesh: true,
                    id: widget.id,
                  )));
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
                            image: NetworkImage(widget.image ??
                                "http://learningapp.e8demo.com/media/thumbnail_img/5-chemistry.jpeg"))),
                  ),
                  kHeight5,
                  Text(
                    widget.courseName ?? "Course name",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  kHeight5,
                  Text(
                    widget.authorName ?? "Instructor",
                    style: TextStyle(fontSize: 12, color: Colors.grey[300]),
                  ),
                  kHeight5,
                  Row(
                    children: [
                      Text(
                        "${widget.rating ?? "4"} ",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.yellow),
                      ),
                      RatingBarIndicator(
                        unratedColor: Colors.grey,
                        rating: widget.rating ?? 3,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        itemCount: 5,
                        itemSize: 10.0,
                        direction: Axis.horizontal,
                      ),
                      Text(
                        widget.ratingCount != null
                            ? " (${widget.ratingCount})"
                            : " (36,000)",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.yellow),
                      ),
                    ],
                  ),
                  kHeight5,
                  Text(
                    "₹ ${widget.coursePrice ?? "Course price"}",
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
                      widget.id != null
                          ? BigCartIconButton(
                              id: widget.id!.toInt(),
                              price: widget.coursePrice!.toInt(),
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
                          id: widget.id,
                          variant: 1,
                          context: context,
                          price: widget.coursePrice);
                      Provider.of<TopCoursesProvider>(context, listen: false)
                          .getAll();
                    }
                  },
                  child: token != null
                      ? Icon(
                          widget.isWishList == true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 25,
                          color: widget.isWishList == true
                              ? Colors.red
                              : Colors.white,
                        )
                      : const SizedBox(),
                )),
              )),
        ],
      ),
    );
  }
}
