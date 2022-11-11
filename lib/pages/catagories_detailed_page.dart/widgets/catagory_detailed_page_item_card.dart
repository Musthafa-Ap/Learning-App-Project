import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nuox_project/pages/featured/services/featured_section/featured_provider.dart';
import 'package:nuox_project/widgets/big_cart_icon_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/constants.dart';
import '../../../my_home_page.dart';
import '../../../widgets/bestseller.dart';
import '../../course_detailed_page/course_detailed_page.dart';
import '../../course_detailed_page/services/course_detailed_provider.dart';

class CatagoryDetailedPageItemCard extends StatelessWidget {
  final int id;
  final String? courseName;
  final int? rating;
  final int? price;
  final String? image;
  final int? ratingCount;
  const CatagoryDetailedPageItemCard({
    Key? key,
    required this.courseName,
    required this.rating,
    required this.price,
    required this.image,
    required this.id,
    required this.ratingCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final featuredProvider = Provider.of<FeaturedProvider>(context);
    final size = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        await Provider.of<CourseDetailedProvider>(context, listen: false)
            .getAll(courseID: id);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CourseDetailedPage()));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size * .4,
                  width: size * .83,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(image ??
                              "http://learningapp.e8demo.com/media/thumbnail_img/4-physics.jpeg"))),
                ),
                kHeight5,
                Text(
                  courseName ?? "Course name",
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                kHeight5,
                Row(
                  children: [
                    Text(
                      "$rating ",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.yellow),
                    ),
                    RatingBarIndicator(
                      unratedColor: Colors.grey,
                      rating: rating?.toDouble() ?? 4.toDouble(),
                      itemCount: 5,
                      itemSize: 10,
                      direction: Axis.horizontal,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                    ),
                    Text(
                      " ($ratingCount)",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.yellow),
                    ),
                  ],
                ),
                kHeight5,
                Row(
                  children: [
                    Text(
                      "₹$price",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    kWidth5,
                    const Text(
                      "₹10,000",
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.white),
                    ),
                  ],
                ),
                kHeight5,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const BestsellerWidget(),
                    SizedBox(
                      width: size * .436,
                    ),
                    BigCartIconButton(
                      id: id,
                      price: price!,
                    )
                  ],
                )
              ],
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
                          id: id, variant: 1, context: context, price: price);
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
