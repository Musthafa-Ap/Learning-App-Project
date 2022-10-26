import 'package:flutter/material.dart';
import 'package:nuox_project/pages/featured/widgets/small_item_card.dart';
import 'package:nuox_project/widgets/see_all_widget.dart';
import '../../../../constants/constants.dart';
import '../../../../widgets/bold_heading.dart';
import '../top_courses_section/top_courses_section.dart';
import '../catagories_section/catagories_section.dart';
import '../../widgets/featured_item_card.dart';
import '../../widgets/see_all_page_featured.dart';

final List courseDetailes = [
  {
    "name": "Complete Guitar Lessons System - Beginner to Advanced",
    "author": "Erich Andreas",
    "price": 3499
  },
  {
    "name": "Excel Deep Dive: Pivot Tables Workshop",
    "author": "Alex Mozes",
    "price": 1499
  },
  {
    "name": "How to create an Awesome Online Courses",
    "author": "Miguel Hernandez",
    "price": 2499
  },
  {
    "name": "Art History Prehistory to the Renaissance",
    "author": "Kenney Mencher",
    "price": 499
  },
  {
    "name": "Pitch Yourself! Learn to Ignite Curiosity + Inspire Action.",
    "author": "Alex Fischer",
    "price": 2499
  },
  {
    "name": "Java Swing (GUI) Programming:From Beginner to Expert",
    "author": "John Purcell",
    "price": 1499
  }
];

class FeaturedSection extends StatelessWidget {
  FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KHeight15,
        const BoldHeading(
          heading: "Featured",
        ),
        SizedBox(
          height: size * .68,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final data = courseDetailes[index];
                    return SmallItemCard();
                  },
                ),
                KWidth30,
                GestureDetector(
                  child: const SeeAllWidget(),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SeeAllPageFeatured()));
                  },
                ),
                KWidth30
              ],
            ),
          ),
        ),
        KHeight20,
        CatagoriesSection(),
        KHeight20,
        TopCoursesSection(),
      ],
    );
  }
}
