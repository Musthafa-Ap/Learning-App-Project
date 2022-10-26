import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../widgets/bold_heading.dart';
import '../../../widgets/course_detailes_list_tile.dart';
import 'catagory_detailed_page_item_card.dart';

class SubCatagoriesDetailedPage extends StatelessWidget {
  const SubCatagoriesDetailedPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: 320,
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
