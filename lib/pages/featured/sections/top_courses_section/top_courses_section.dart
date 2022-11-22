import 'package:flutter/material.dart';
import 'package:nuox_project/pages/featured/sections/top_courses_section/see_all_page_top_courses.dart';
import 'package:nuox_project/pages/featured/services/top_courses_section/top_courses_provider.dart';
import 'package:nuox_project/pages/featured/widgets/big_item_card.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants.dart';
import '../../../../widgets/bold_heading.dart';
import '../../../../widgets/see_all_widget.dart';
import '../../services/featured_section/featured_provider.dart';

class TopCoursesSection extends StatelessWidget {
  const TopCoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final topCoursesProvider = Provider.of<TopCoursesProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BoldHeading(heading: "Top Courses in Mobile\nDevelopment"),
        SizedBox(
          height: size * .8,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                topCoursesProvider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 3,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final datas =
                              topCoursesProvider.topCoursesList?.data?[index];

                          return BigItemCard(
                            id: datas?.id?.toInt(),
                            rating: datas?.rating?.toDouble(),
                            image: datas?.thumbnail?.fullSize.toString(),
                            isWishList: datas?.isWishList,
                            courseName: datas?.courseName.toString(),
                            ratingCount: datas?.ratingCount?.toInt(),
                            coursePrice: datas?.price?.toInt(),
                            authorName: datas?.instructor?.name.toString(),
                            isRecomended: datas?.bestSeller,
                          );
                        }),
                kWidth30,
                GestureDetector(
                  child: const SeeAllWidget(),
                  onTap: () {
                    Provider.of<FeaturedProvider>(context, listen: false)
                        .sortedCourses = null;
                    Provider.of<TopCoursesProvider>(context, listen: false)
                        .getAll();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SeeAllPageTopCourses()));
                  },
                ),
                kWidth30
              ],
            ),
          ),
        )
      ],
    );
  }
}
