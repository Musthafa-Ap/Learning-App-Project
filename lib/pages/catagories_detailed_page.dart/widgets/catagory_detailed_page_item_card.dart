import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nuox_project/pages/featured/services/featured_section/featured_provider.dart';
import 'package:nuox_project/widgets/big_cart_icon_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/constants.dart';
import '../../../widgets/bestseller.dart';
import '../../course_detailed_page/course_detailed_page.dart';
import '../../course_detailed_page/services/course_detailed_provider.dart';
import '../services/catagories_detailed_provider.dart';

class CatagoryDetailedPageItemCard extends StatefulWidget {
  final bool? isWishlist;
  final int? id;
  final String? courseName;
  final int? rating;
  final int? price;
  final String? image;
  final int? ratingCount;
  final int? cataid;
  final bool? bestSeller;
  const CatagoryDetailedPageItemCard(
      {required this.bestSeller,
      Key? key,
      required this.courseName,
      required this.rating,
      required this.price,
      required this.image,
      required this.id,
      required this.ratingCount,
      required this.isWishlist,
      required this.cataid})
      : super(key: key);

  @override
  State<CatagoryDetailedPageItemCard> createState() =>
      _CatagoryDetailedPageItemCardState();
}

class _CatagoryDetailedPageItemCardState
    extends State<CatagoryDetailedPageItemCard> {
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
    final size = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        await Provider.of<CourseDetailedProvider>(context, listen: false)
            .getAll(courseID: widget.id);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CourseDetailedPage(
                  id: widget.id,
                )));
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
                          image: NetworkImage(widget.image ??
                              "http://learningapp.e8demo.com/media/thumbnail_img/4-physics.jpeg"))),
                ),
                kHeight5,
                Text(
                  widget.courseName ?? "Course name",
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
                      "${widget.rating} ",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.yellow),
                    ),
                    RatingBarIndicator(
                      unratedColor: Colors.grey,
                      rating: widget.rating?.toDouble() ?? 4.toDouble(),
                      itemCount: 5,
                      itemSize: 10,
                      direction: Axis.horizontal,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                    ),
                    Text(
                      " (${widget.ratingCount})",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.yellow),
                    ),
                  ],
                ),
                kHeight5,
                Row(
                  children: [
                    Text(
                      "₹${widget.price}",
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
                    widget.bestSeller == true
                        ? const BestsellerWidget()
                        : SizedBox(
                            width: size * .15,
                          ),
                    SizedBox(
                      width: size * .436,
                    ),
                    widget.id != null || widget.price != null
                        ? BigCartIconButton(
                            id: widget.id!,
                            price: widget.price!,
                          )
                        : const SizedBox()
                  ],
                )
              ],
            ),
          ),
          token == null
              ? const SizedBox() //: const SizedBox()
              //favoriteIcon thalkaalam disable cheythu.i know its a udayipp
              : Positioned(
                  right: 10,
                  top: 8,
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: GestureDetector(
                      onTap: () async {
                        featuredProvider.addToWhishlist(
                            id: widget.id,
                            variant: 1,
                            context: context,
                            price: widget.price);
                        await Provider.of<CatagoriesDetailedProvider>(context,
                                listen: false)
                            .getAll(catagoriesID: widget.cataid);
                      },
                      child: Icon(
                        widget.isWishlist == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 25,
                        color: widget.isWishlist == true
                            ? Colors.red
                            : Colors.white,
                      ),
                    )),
                  )),
        ],
      ),
    );
  }
}
