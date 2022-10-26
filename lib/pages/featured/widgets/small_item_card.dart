import 'package:flutter/material.dart';
import 'package:nuox_project/widgets/bestseller.dart';

import '../../../constants/constants.dart';
import '../../course_detailed_page/course_detailed_page.dart';

class SmallItemCard extends StatelessWidget {
  const SmallItemCard({
    Key? key,
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
                        image: NetworkImage(
                            "https://hotmart.com/media/2018/10/BLOG_Como-funciona-palestra-online-670x4191.png"))),
              ),
              KHeight5,
              Text(
                "Comeplete Guitar Lessons System - Beginner to Advanced",
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              KHeight5,
              Text(
                "Erich Andreas",
                style: TextStyle(fontSize: 12, color: Colors.grey[300]),
              ),
              KHeight5,
              Text(
                "4.6 ***** (36,907)",
                style: TextStyle(fontSize: 12, color: Colors.yellow),
              ),
              KHeight5,
              Text(
                "₹3,499",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              KHeight5,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BestsellerWidget(),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5)),
                      margin: const EdgeInsets.only(right: 20),
                      height: 30,
                      width: 50,
                      child: IconButton(
                          onPressed: () {},
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
    );
  }
}
