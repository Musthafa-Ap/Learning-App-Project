import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nuox_project/my_home_page.dart';
import 'package:nuox_project/pages/course_detailed_page/recomendations_services/recomendations_provider.dart';
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_provider.dart';
import 'package:nuox_project/pages/featured/services/featured_section/featured_provider.dart';
import 'package:nuox_project/widgets/bestseller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/constants.dart';
import '../../course_detailed_page/course_detailed_page.dart';

class SmallItemCard extends StatefulWidget {
  final bool? isWishlist;
  final bool? isBestSeller;
  final int? id;
  final String? courseName;
  final String? authorName;
  final double? coursePrice;
  final String? image;
  final double? rating;
  final int? ratingCount;
  const SmallItemCard({
    Key? key,
    this.isWishlist,
    required this.courseName,
    required this.authorName,
    required this.coursePrice,
    required this.image,
    required this.rating,
    required this.id,
    this.isBestSeller = true,
    required this.ratingCount,
  }) : super(key: key);

  @override
  State<SmallItemCard> createState() => _SmallItemCardState();
}

class _SmallItemCardState extends State<SmallItemCard> {
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
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final featuredProvider = Provider.of<FeaturedProvider>(context);
    final courseDetailedProvider = Provider.of<CourseDetailedProvider>(context);
    var size = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        await Provider.of<CourseDetailedProvider>(context, listen: false)
            .getAll(courseID: widget.id);
        await Provider.of<RecomendationsProvider>(context, listen: false)
            .getAll();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CourseDetailedPage(
                  refesh: true,
                  id: widget.id,
                )));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: size * .365,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size * .185,
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  kHeight5,
                  Text(
                    widget.authorName ?? "Author name",
                    style: TextStyle(fontSize: 12, color: Colors.grey[300]),
                  ),
                  kHeight5,
                  Row(
                    children: [
                      Text(
                        "${widget.rating ?? "2"} ",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.yellow),
                      ),
                      RatingBarIndicator(
                        unratedColor: Colors.grey,
                        rating: widget.rating ?? 4,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        itemCount: 5,
                        itemSize: 10.0,
                        direction: Axis.horizontal,
                      ),
                      Text(
                        " (${widget.ratingCount})",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.yellow),
                      ),
                    ],
                  ),
                  kHeight5,
                  Text(
                    "₹ ${widget.coursePrice}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  kHeight5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      widget.isBestSeller == true
                          ? const BestsellerWidget()
                          : const SizedBox(),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5)),
                          //  margin: const EdgeInsets.only(right: 5),
                          height: 30,
                          width: 50,
                          child: IconButton(
                              onPressed: () async {
                                SharedPreferences sharedpref =
                                    await SharedPreferences.getInstance();
                                var token =
                                    sharedpref.getString("access_token");
                                if (token != null) {
                                  courseDetailedProvider.addToCart(
                                      courseID: widget.id ?? 1,
                                      context: context,
                                      variantID: 1,
                                      price: widget.coursePrice!.toInt(),
                                      token: token);
                                } else {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => const Test()),
                                    (route) => false,
                                  );
                                }
                              },
                              icon: Icon(
                                Icons.shopping_bag,
                                color: Colors.white,
                                size: 28,
                              )))
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              right: 8,
              top: 5,
              child: Container(
                height: 35,
                width: 35,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: GestureDetector(
                        onTap: () async {
                          SharedPreferences shared =
                              await SharedPreferences.getInstance();
                          var token = shared.getString("access_token");
                          if (token == null) {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const Test()),
                              (route) => false,
                            );
                          } else {
                            if (widget.isWishlist == false) {
                              featuredProvider.addToWhishlist(
                                id: widget.id,
                                variant: 1,
                                context: context,
                                price: widget.coursePrice!.toInt(),
                              );
                            }
                            if (widget.isWishlist == true) {
                              await featuredProvider.deleteFromWhishlist(
                                  variant: 1,
                                  id: widget.id.toString(),
                                  context: context);
                              //  await featuredProvider.getWhishlist();
                            }
                            await Provider.of<FeaturedProvider>(context,
                                    listen: false)
                                .sample();
                            await Provider.of<FeaturedProvider>(context,
                                    listen: false)
                                .samples();
                            await Provider.of<CourseDetailedProvider>(context,
                                    listen: false)
                                .getRecentlyViewed();
                            await Provider.of<RecomendationsProvider>(context,
                                    listen: false)
                                .getAll();
                            // await Provider.of<CourseDetailedProvider>(context,
                            //         listen: false)
                            //     .getAll(courseID: widget.id);
                          }
                        },
                        child: token != null
                            ? Icon(
                                widget.isWishlist == true
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 20,
                                color: widget.isWishlist == true
                                    ? Colors.red
                                    : Colors.white,
                              )
                            : const SizedBox())),
              )),
        ],
      ),
    );
  }
}
