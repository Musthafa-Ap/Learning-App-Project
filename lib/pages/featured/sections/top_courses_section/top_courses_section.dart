import 'package:flutter/material.dart';
import 'package:nuox_project/pages/featured/sections/top_courses_section/see_all_page_top_courses.dart';
import 'package:nuox_project/pages/featured/services/top_courses_section/top_courses_provider.dart';
import 'package:nuox_project/pages/featured/widgets/big_item_card.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../widgets/bold_heading.dart';
import '../../../../widgets/see_all_widget.dart';
import '../../widgets/small_item_card.dart';

class TopCoursesSection extends StatelessWidget {
  TopCoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final topCoursesProvider =
        Provider.of<TopCoursesProvider>(context).topCoursesList;
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
                    physics: const BouncingScrollPhysics(),
                    itemCount: 3,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final datas = topCoursesProvider?.data![index];
                      return BigItemCard(
                        id: datas!.id!.toInt(),
                        rating: datas.rating!.toDouble(),
                        image: datas.thumbnail!.fullSize.toString(),
                        courseName: datas.courseName.toString(),
                        coursePrice: datas.price!.toInt(),
                        authorName: datas.instructor!.name.toString(),
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
