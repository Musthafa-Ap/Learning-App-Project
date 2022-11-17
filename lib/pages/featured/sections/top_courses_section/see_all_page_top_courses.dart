import 'package:flutter/material.dart';
import 'package:nuox_project/pages/featured/services/featured_section/featured_provider.dart';
import 'package:nuox_project/pages/featured/services/top_courses_section/top_courses_provider.dart';
import 'package:nuox_project/widgets/course_detailes_list_tile.dart';
import 'package:provider/provider.dart';

import '../../../../my_home_page.dart';
import '../../widgets/see_all_page_featured.dart';

class SeeAllPageTopCourses extends StatelessWidget {
  const SeeAllPageTopCourses({super.key});

  @override
  Widget build(BuildContext context) {
    final featuredProviders = Provider.of<FeaturedProvider>(context);
    final topCoursesProvider =
        Provider.of<TopCoursesProvider>(context).topCoursesList;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top courses in mobile development"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                  (route) => false);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        automaticallyImplyLeading: false,
        actions: [
          featuredProviders.sortedCourses == null ||
                  featuredProviders.sortedCourses!.data!.isEmpty
              ? IconButton(
                  onPressed: () async {
                    showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (BuildContext context) {
                        return const RangeClass();
                      },
                    );
                  },
                  icon: const Icon(Icons.sort, size: 28))
              : const SizedBox()
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        physics: const BouncingScrollPhysics(),
        itemCount: topCoursesProvider!.data!.length,
        itemBuilder: (context, index) {
          final datas = topCoursesProvider.data![index];
          return CourseDetailesListTile(
            authorName: datas.instructor!.name.toString(),
            courseName: datas.courseName.toString(),
            isWishlist: datas.isWishList,
            coursePrice: datas.price!.toDouble(),
            image: datas.thumbnail!.fullSize.toString(),
            ratingCount: datas.ratingCount,
            id: datas.id!.toInt(),
            rating: datas.rating!.toDouble(),
            isRecomended: datas.recommendedCourse,
          );
        },
      ),
    );
  }
}
