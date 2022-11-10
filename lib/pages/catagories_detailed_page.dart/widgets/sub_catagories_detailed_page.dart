import 'package:flutter/material.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/services/catagories_detailed_provider.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../widgets/course_detailes_list_tile.dart';

class SubCatagoriesDetailedPage extends StatelessWidget {
  const SubCatagoriesDetailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final catagoriesProvider = Provider.of<CatagoriesDetailedProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subcategories"),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        children: [
          kHeight5,
          const Text(
            "Courses to get you started",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          kHeight15,
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: catagoriesProvider.subCatagoriesDetailes!.data!.length,
            itemBuilder: (context, index) {
              final datas =
                  catagoriesProvider.subCatagoriesDetailes?.data?[index];
              return CourseDetailesListTile(
                authorName: datas?.instructor?.name.toString(),
                courseName: datas?.courseName.toString(),
                coursePrice: datas?.price?.toDouble(),
                id: datas?.id?.toInt(),
                ratingCount: datas?.ratingCount,
                image: datas?.thumbnail?.fullSize.toString(),
                rating: datas?.rating?.toDouble(),
                isRecomended: datas?.recommendedCourse,
              );
            },
          ),
        ],
      ),
    );
  }
}
