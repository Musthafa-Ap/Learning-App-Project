import 'package:flutter/material.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/widgets/sub_catagories_detailed_page.dart';
import 'package:nuox_project/pages/course_detailed_page/course_detailed_page.dart';
import 'package:nuox_project/pages/featured/widgets/catagories_button.dart';
import 'package:nuox_project/pages/featured/widgets/see_all_page_featured.dart';
import 'package:nuox_project/widgets/bold_heading.dart';
import '../../widgets/course_detailes_list_tile.dart';
import 'widgets/catagory_detailed_page_item_card.dart';

class CatagoriesDetailedPage extends StatelessWidget {
  CatagoriesDetailedPage({super.key});
  final List _catagoryButtonTitle = [
    "Development",
    "Business",
    "Office Productivity",
    "Design",
    "Lifestyle",
    "Health & Fitness"
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.sort))],
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
          SizedBox(
            height: size * .76,
            child: ListView.builder(
              itemCount: 3,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CatagoryDetailedPageItemCard();
              },
            ),
          ),
          KHeight15,
          const BoldHeading(heading: "Subcategories"),
          KHeight,
          SizedBox(
            height: 60,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _catagoryButtonTitle.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final data = _catagoryButtonTitle[index];
                return CatagoriesButton(
                    title: data,
                    navigatepage: SeeAllPageFeatured(
                      fromSubCatagories: true,
                    ));
                //  CatagoriesDetailedPage();
              },
            ),
          ),
          KHeight15,
          const BoldHeading(heading: "Recommendations"),
          ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: 8,
            itemBuilder: (context, index) {
              return CourseDetailesListTile();
            },
          ),
        ],
      ),
    );
  }
}
