import 'package:flutter/material.dart';
import 'package:nuox_project/pages/course_detailed_page/course_detailed_page.dart';
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_provider.dart';
import 'package:nuox_project/pages/featured/widgets/big_item_card.dart';
import 'package:nuox_project/widgets/bestseller.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import 'big_cart_icon_button.dart';

class CourseDetailesListTile extends StatelessWidget {
  final int id;
  final String courseName;
  final String authorName;
  final double coursePrice;
  final String image;
  final double rating;
  CourseDetailesListTile({
    this.isCartItem = false,
    Key? key,
    required this.courseName,
    required this.authorName,
    required this.coursePrice,
    required this.image,
    required this.rating,
    required this.id,
  }) : super(key: key);
  final bool isCartItem;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Provider.of<CourseDetailedProvider>(context, listen: false)
            .getAll(courseID: id);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CourseDetailedPage()));
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
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
                          fit: BoxFit.cover, image: NetworkImage(image))),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          courseName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        KHeight5,
                        Text(
                          authorName,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[300]),
                        ),
                        KHeight5,
                        Text(
                          "${rating} ***** (36,907)",
                          style: TextStyle(fontSize: 12, color: Colors.yellow),
                        ),
                        KHeight5,
                        Text(
                          coursePrice.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            BestsellerWidget(),
                            isCartItem
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    margin: const EdgeInsets.only(right: 20),
                                    height: 35,
                                    width: 45,
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.delete)))
                                : BigCartIconButton()
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
