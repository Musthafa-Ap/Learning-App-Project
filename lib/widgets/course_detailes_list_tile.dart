import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nuox_project/pages/cart/cart_services/cart_services.dart';
import 'package:nuox_project/pages/course_detailed_page/course_detailed_page.dart';
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_provider.dart';
import 'package:nuox_project/pages/featured/services/featured_section/featured_provider.dart';
import 'package:nuox_project/widgets/bestseller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../my_home_page.dart';
import 'big_cart_icon_button.dart';

class CourseDetailesListTile extends StatelessWidget {
  final int? ratingCount;
  bool? isRecomended;
  final int? id;
  final String? courseName;
  final String? authorName;
  final double? coursePrice;
  final String? image;
  final double? rating;
  final int? variantID;
  CourseDetailesListTile({
    Key? key,
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
  }) : super(key: key);
  final bool isCartItem;
  String? variant;
  @override
  Widget build(BuildContext context) {
    final featuredProvider = Provider.of<FeaturedProvider>(context);
    if (variantID == 1) {
      variant = "Beginner";
    } else if (variantID == 2) {
      variant = "Intermediate";
    } else {
      variant = "Expert";
    }
    final cartProvider = Provider.of<CartProvider>(context);
    final size = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        await Provider.of<CourseDetailedProvider>(context, listen: false)
            .getAll(courseID: id);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CourseDetailedPage()));
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
                  height: size * .192,
                  width: size * .192,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(image ??
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
                              courseName ?? "Course name",
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
                                    featuredProvider.addToWhishlist(
                                        id: id,
                                        variant: 1,
                                        context: context,
                                        price: coursePrice);
                                  }
                                },
                                child: const Icon(
                                  Icons.favorite_border,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        kHeight5,
                        Text(
                          authorName ?? "Author name",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[300]),
                        ),
                        kHeight5,
                        Row(
                          children: [
                            Text(
                              "$rating ",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.yellow),
                            ),
                            RatingBarIndicator(
                              unratedColor: Colors.grey,
                              rating: rating ?? 4,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              itemCount: 5,
                              itemSize: 10.0,
                              direction: Axis.horizontal,
                            ),
                            Text(
                              " ($ratingCount)",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.yellow),
                            ),
                          ],
                        ),
                        kHeight5,
                        isCartItem
                            ? Text(
                                variant!,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox(),
                        kHeight5,
                        Text(
                          "₹${coursePrice ?? "Course price"}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            isRecomended!
                                ? const BestsellerWidget()
                                : const SizedBox(),
                            isCartItem
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    margin: const EdgeInsets.only(right: 20),
                                    height: 35,
                                    width: 45,
                                    child: IconButton(
                                        onPressed: () {
                                          cartProvider.deleteCartItem(
                                              courseID: id,
                                              variantID: variantID,
                                              context: context);
                                        },
                                        icon: const Icon(Icons.delete)))
                                : BigCartIconButton(
                                    id: id!,
                                    price: coursePrice!.toInt(),
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
