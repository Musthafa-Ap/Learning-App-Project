import 'package:flutter/material.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/catagories_detailed_page.dart';
import 'package:nuox_project/pages/featured/sections/catagories_section/see_all_catagories.dart';

import '../../../../widgets/bold_heading.dart';
import '../../../../widgets/see_all_widget.dart';
import '../../widgets/catagories_button.dart';

class CatagoriesSection extends StatelessWidget {
  CatagoriesSection({super.key});
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BoldHeading(heading: "Catagories"),
            GestureDetector(
              child: SeeAllWidget(),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SeeAllCatagories()));
              },
            )
          ],
        ),
        SizedBox(
          height: 60,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _catagoryButtonTitle.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final data = _catagoryButtonTitle[index];
              return CatagoriesButton(
                title: data,
                navigatepage: CatagoriesDetailedPage(),
              );
            },
          ),
        )
      ],
    );
  }
}
