import 'package:flutter/material.dart';
import 'package:nuox_project/widgets/big_cart_icon_button.dart';

import '../../../constants/constants.dart';
import '../../../widgets/bestseller.dart';
import '../../course_detailed_page/course_detailed_page.dart';

class CatagoryDetailedPageItemCard extends StatelessWidget {
  const CatagoryDetailedPageItemCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CourseDetailedPage()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size * .45,
              width: size * .83,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://upwisy.com/storage/file-1602-LzoD9XZfd9rw1kJt.jpg"))),
            ),
            KHeight5,
            Text(
              "Javascript for Beginners",
              maxLines: 2,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            KHeight5,
            Text(
              "4.6 ***** (36,907)",
              style: TextStyle(fontSize: 12, color: Colors.yellow),
            ),
            KHeight5,
            Row(
              children: [
                Text(
                  "₹449",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                KWidth5,
                Text(
                  "3,499",
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.white),
                ),
              ],
            ),
            KHeight5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BestsellerWidget(),
                SizedBox(
                  width: size * .436,
                ),
                BigCartIconButton()
              ],
            )
          ],
        ),
      ),
    );
  }
}
