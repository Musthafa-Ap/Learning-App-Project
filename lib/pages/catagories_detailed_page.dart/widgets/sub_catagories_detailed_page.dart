import 'package:flutter/material.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/services/catagories_detailed_provider.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../widgets/bold_heading.dart';
import '../../../widgets/course_detailes_list_tile.dart';
import 'catagory_detailed_page_item_card.dart';

class SubCatagoriesDetailedPage extends StatelessWidget {
  const SubCatagoriesDetailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final catagoriesProvider = Provider.of<CatagoriesDetailedProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Subcategories"),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        children: [
          Text(
            "Development",
            style: const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          KHeight15,
          Text(
            "Courses to get you started",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          // SizedBox(
          //   height: 320,
          //   child: ListView.builder(
          //     itemCount: 3,
          //     physics: const BouncingScrollPhysics(),
          //     shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, index) {
          //       return SizedBox(); //CatagoryDetailedPageItemCard();
          //     },
          //   ),
          // ),
          KHeight15,
          // KHeight15,
          // const BoldHeading(heading: "Recommendations"),
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: catagoriesProvider.subCatagoriesDetailes!.data!.length,
            itemBuilder: (context, index) {
              final datas =
                  catagoriesProvider.subCatagoriesDetailes!.data![index];
              return CourseDetailesListTile(
                authorName: datas.instructor!.name.toString(),
                courseName: datas.courseName.toString(),
                coursePrice: datas.price!.toDouble(),
                id: datas.id!.toInt(),
                image: datas.thumbnail!.fullSize.toString(),
                rating: datas.rating!.toDouble(),
              );
            },
          ),
        ],
      ),
    );
  }
}
