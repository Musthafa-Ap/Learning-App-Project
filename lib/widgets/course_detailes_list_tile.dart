import 'package:flutter/material.dart';
import 'package:nuox_project/pages/course_detailed_page/course_detailed_page.dart';
import 'package:nuox_project/pages/featured/widgets/featured_item_card.dart';
import 'package:nuox_project/widgets/bestseller.dart';

import '../constants/constants.dart';
import 'big_cart_icon_button.dart';

class CourseDetailesListTile extends StatelessWidget {
  const CourseDetailesListTile({
    this.isCartItem = false,
    Key? key,
  }) : super(key: key);
  final bool isCartItem;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
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
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://ipb.ac.id/media/images/news/tanggapan-dosen-dan-mahasiswa-terkait-kuliah-online-ipb-university-news.png"))),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Complete Guitar Lessons System - Beginner to Advanced",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        KHeight5,
                        Text(
                          "Erich Andreas",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[300]),
                        ),
                        KHeight5,
                        Text(
                          "4.6 ***** (36,907)",
                          style: TextStyle(fontSize: 12, color: Colors.yellow),
                        ),
                        KHeight5,
                        Text(
                          "₹3,499",
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
