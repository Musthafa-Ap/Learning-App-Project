import 'package:flutter/material.dart';
import 'package:nuox_project/widgets/course_detailes_list_tile.dart';

class SeeAllPageTopCourses extends StatelessWidget {
  SeeAllPageTopCourses({super.key});

  @override
  Widget build(BuildContext context) {
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
        itemCount: 15,
        itemBuilder: (context, index) {
          return CourseDetailesListTile();
        },
      ),
    );
  }
}
