import 'package:flutter/material.dart';
import 'package:nuox_project/widgets/big_cart_icon_button.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../widgets/bestseller.dart';
import '../../course_detailed_page/course_detailed_page.dart';
import '../../course_detailed_page/services/course_detailed_provider.dart';

class CatagoryDetailedPageItemCard extends StatelessWidget {
  final int id;
  final String courseName;
  final int rating;
  final int price;
  final String image;
  const CatagoryDetailedPageItemCard({
    Key? key,
    required this.courseName,
    required this.rating,
    required this.price,
    required this.image,
    required this.id,
  }) : super(key: key);

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size * .4,
              width: size * .83,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: NetworkImage(image))),
            ),
            KHeight5,
            Text(
              courseName,
              maxLines: 2,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            KHeight5,
            Text(
              "${rating} ***** (36,907)",
              style: TextStyle(fontSize: 12, color: Colors.yellow),
            ),
            KHeight5,
            Row(
              children: [
                Text(
                  price.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                KWidth5,
                Text(
                  "7,499",
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
                BigCartIconButton(
                  id: id,
                  price: price,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
