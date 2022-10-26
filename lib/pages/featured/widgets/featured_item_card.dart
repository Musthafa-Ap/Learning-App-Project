import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../widgets/bestseller.dart';
import '../../../widgets/big_cart_icon_button.dart';
import '../../course_detailed_page/course_detailed_page.dart';

class FeaturedItemCard extends StatelessWidget {
  final String courseName;
  final String authorName;
  final int coursePrice;

  const FeaturedItemCard({
    Key? key,
    required this.courseName,
    required this.authorName,
    required this.coursePrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CourseDetailedPage()));
      },
      child: Padding(
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
                        image: NetworkImage(
                            "https://i.guim.co.uk/img/media/71dd7c5b208e464995de3467caf9671dc86fcfd4/1176_345_3557_2135/master/3557.jpg?width=620&quality=45&dpr=2&s=none"))),
              ),
              KHeight5,
              Text(
                courseName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              KHeight5,
              Text(
                authorName,
                style: TextStyle(fontSize: 12, color: Colors.grey[300]),
              ),
              KHeight5,
              Text(
                "4.6 ***** (36,907)",
                style: TextStyle(fontSize: 12, color: Colors.yellow),
              ),
              KHeight5,
              Text(
                "₹${coursePrice}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              KHeight5,
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [BestsellerWidget(), BigCartIconButton()],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
