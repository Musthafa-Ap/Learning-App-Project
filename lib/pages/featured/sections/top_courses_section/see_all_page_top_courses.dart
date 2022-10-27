import 'package:flutter/material.dart';
import 'package:nuox_project/pages/featured/services/top_courses_section/top_courses_provider.dart';
import 'package:nuox_project/widgets/course_detailes_list_tile.dart';
import 'package:provider/provider.dart';

class SeeAllPageTopCourses extends StatelessWidget {
  SeeAllPageTopCourses({super.key});

  @override
  Widget build(BuildContext context) {
    final topCoursesProvider =
        Provider.of<TopCoursesProvider>(context).topCoursesList;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top courses in mobile development"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.sort, size: 28))
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15),
        physics: BouncingScrollPhysics(),
        itemCount: topCoursesProvider!.data!.length,
        itemBuilder: (context, index) {
          final datas = topCoursesProvider.data![index];
          return CourseDetailesListTile(
            authorName: datas.instructor.toString(),
            courseName: datas.courseName.toString(),
            coursePrice: datas.price!.toDouble(),
            image: datas.thumbnail!.fullSize.toString(),
            id: datas.id!.toInt(),
            rating: datas.rating!.toDouble(),
          );
        },
      ),
    );
  }
}
