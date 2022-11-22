import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nuox_project/pages/cart/cart_services/cart_services.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/services/catagories_detailed_provider.dart';
import 'package:nuox_project/pages/course_detailed_page/course_detailed_page.dart';
import 'package:nuox_project/pages/course_detailed_page/recomendations_services/recomendations_provider.dart';
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_provider.dart';
import 'package:nuox_project/pages/featured/services/featured_section/featured_provider.dart';
import 'package:nuox_project/pages/featured/services/top_courses_section/top_courses_provider.dart';
import 'package:nuox_project/widgets/bestseller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../my_home_page.dart';
import 'big_cart_icon_button.dart';

// ignore: must_be_immutable
class CourseDetailesListTile extends StatefulWidget {
  final int? subCatid;
  final bool? isWishlist;
  final int? ratingCount;
  final bool? isRecomended;
  final int? id;
  final String? courseName;
  final String? authorName;
  final double? coursePrice;
  final String? image;
  final double? rating;
  final int? variantID;
  const CourseDetailesListTile({
    Key? key,
    this.subCatid,
    this.isCartItem = false,
    required this.courseName,
    required this.authorName,
    required this.coursePrice,
    required this.image,
    required this.rating,
    required this.id,
    this.variantID,
    this.isRecomended = false,
    required this.ratingCount,
    required this.isWishlist,
  }) : super(key: key);
  final bool isCartItem;

  @override
  State<CourseDetailesListTile> createState() => _CourseDetailesListTileState();
}

class _CourseDetailesListTileState extends State<CourseDetailesListTile> {
  @override
  void initState() {
    get();
    super.initState();
  }

  String? token;
  void get() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    token = shared.getString("access_token");
  }

  String? variant;

  @override
  Widget build(BuildContext context) {
    final featuredProvider = Provider.of<FeaturedProvider>(context);
    if (widget.variantID != null) {
      if (widget.variantID == 1) {
        variant = "Beginner";
      } else if (widget.variantID == 2) {
        variant = "Intermediate";
      } else {
        variant = "Expert";
      }
    }
    final cartProvider = Provider.of<CartProvider>(context);
    final size = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        if (widget.id != null) {
          await Provider.of<CourseDetailedProvider>(context, listen: false)
              .getAll(
            courseID: widget.id,
          );

          if (widget.subCatid != null) {
            // ignore: use_build_context_synchronously
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CourseDetailedPage(
                      id: widget.id,
                      subcatid: widget.subCatid,
                    )));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CourseDetailedPage(
                      id: widget.id,
                    )));
          }
        }
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          height: size * .425,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size * .3,
                  width: size * .270,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.image ??
                              "http://learningapp.e8demo.com/media/thumbnail_img/5-chemistry.jpeg"))),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.courseName ?? "Course name",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 26),
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
                                    if (widget.id != null ||
                                        widget.coursePrice != null) {
                                      featuredProvider.addToWhishlist(
                                          id: widget.id,
                                          variant: 1,
                                          context: context,
                                          price: widget.coursePrice);
                                      await Provider.of<FeaturedProvider>(
                                              context,
                                              listen: false)
                                          .samples();
                                      await Provider.of<FeaturedProvider>(
                                              context,
                                              listen: false)
                                          .sample();
                                      await Provider.of<TopCoursesProvider>(
                                              context,
                                              listen: false)
                                          .getAll();
                                      await Provider.of<RecomendationsProvider>(
                                              context,
                                              listen: false)
                                          .getAll();
                                      await Provider.of<CourseDetailedProvider>(
                                              context,
                                              listen: false)
                                          .getRecentlyViewed();
                                      if (widget.subCatid != null) {
                                        await Provider.of<
                                                    CatagoriesDetailedProvider>(
                                                context,
                                                listen: false)
                                            .getSubCatagoriesDetailes(
                                                subCatagoriesID:
                                                    widget.subCatid);
                                      }
                                    }
                                  }
                                },
                                child: token == null ||
                                        widget.isCartItem == true ||
                                        widget.isWishlist == null
                                    ? const SizedBox()
                                    : Icon(
                                        widget.isWishlist == true
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 20,
                                        color: widget.isWishlist == true
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                              ),
                            )
                          ],
                        ),
                        kHeight5,
                        Text(
                          widget.authorName ?? "Author name",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[300]),
                        ),
                        kHeight5,
                        Row(
                          children: [
                            Text(
                              "${widget.rating ?? "4"} ",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.yellow),
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
                              " (${widget.ratingCount ?? "0"})",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.yellow),
                            ),
                          ],
                        ),
                        kHeight5,
                        widget.isCartItem
                            ? Text(
                                variant.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox(),
                        kHeight5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "₹${widget.coursePrice ?? "Course price"}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            widget.isCartItem
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    margin: const EdgeInsets.only(right: 20),
                                    height: 35,
                                    width: 45,
                                    child: IconButton(
                                        onPressed: () {
                                          if (widget.id != null ||
                                              widget.variantID != null) {
                                            cartProvider.deleteCartItem(
                                                courseID: widget.id,
                                                variantID: widget.variantID,
                                                context: context);
                                          }
                                        },
                                        icon: const Icon(Icons.delete)))
                                : const SizedBox()
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            widget.isRecomended != false
                                ? const BestsellerWidget()
                                : const SizedBox(),
                            widget.isCartItem == true ||
                                    widget.id == null ||
                                    widget.coursePrice == null
                                ? const SizedBox()
                                // ? Container(
                                //     decoration: BoxDecoration(
                                //         color: Colors.white,
                                //         borderRadius: BorderRadius.circular(5)),
                                //     margin: const EdgeInsets.only(right: 20),
                                //     height: 35,
                                //     width: 45,
                                //     child: IconButton(
                                //         onPressed: () {
                                //           cartProvider.deleteCartItem(
                                //               courseID: widget.id,
                                //               variantID: widget.variantID,
                                //               context: context);
                                //         },
                                //         icon: const Icon(Icons.delete)))
                                : BigCartIconButton(
                                    id: widget.id!,
                                    price: widget.coursePrice!.toInt(),
                                  )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
