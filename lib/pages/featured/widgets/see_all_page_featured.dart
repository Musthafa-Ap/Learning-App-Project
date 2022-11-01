import 'package:flutter/material.dart';
import 'package:nuox_project/pages/featured/services/featured_model.dart';
import 'package:nuox_project/pages/featured/services/featured_provider.dart';
import 'package:nuox_project/widgets/course_detailes_list_tile.dart';
import 'package:provider/provider.dart';

class SeeAllPageFeatured extends StatelessWidget {
  final bool fromSubCatagories;
  const SeeAllPageFeatured({super.key, this.fromSubCatagories = false});

  @override
  Widget build(BuildContext context) {
    final featuredProvider = Provider.of<FeaturedProvider>(context).auto;
    return Scaffold(
      appBar: AppBar(
        title: fromSubCatagories ? null : Text("Featured"),
        centerTitle: true,
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        physics: const BouncingScrollPhysics(),
        itemCount: featuredProvider.length,
        itemBuilder: (context, index) {
          final data = featuredProvider[index];
          return CourseDetailesListTile(
            authorName: data!.instructor.toString(),
            courseName: data.courseName.toString(),
            image: data.thumbnail!.full_size.toString(),
            coursePrice: data.price!,
            id: data.id!,
            rating: data.rating!.toDouble(),
            isRecomended: data.recommendedCourse!,
          );
        },
      ),
    );
  }
}
