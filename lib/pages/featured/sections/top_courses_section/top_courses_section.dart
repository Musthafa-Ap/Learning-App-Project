import 'package:flutter/material.dart';
import 'package:nuox_project/pages/featured/sections/top_courses_section/see_all_page_top_courses.dart';
import 'package:nuox_project/pages/featured/widgets/featured_item_card.dart';

import '../../../../constants/constants.dart';
import '../../../../widgets/bold_heading.dart';
import '../../../../widgets/see_all_widget.dart';
import '../../widgets/small_item_card.dart';

class TopCoursesSection extends StatelessWidget {
  TopCoursesSection({super.key});
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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BoldHeading(heading: "Top Courses in Mobile\nDevelopment"),
        SizedBox(
          height: size * .75,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: 3,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final data = courseDetailes[index];
                      return FeaturedItemCard(
                        courseName: data['name'],
                        coursePrice: data['price'],
                        authorName: data['author'],
                      );
                    }),
                KWidth30,
                GestureDetector(
                  child: SeeAllWidget(),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SeeAllPageTopCourses()));
                  },
                ),
                KWidth30
              ],
            ),
          ),
        )
      ],
    );
  }
}
