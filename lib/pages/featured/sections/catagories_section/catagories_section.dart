import 'package:flutter/material.dart';
import 'package:nuox_project/pages/featured/sections/catagories_section/see_all_catagories.dart';
import 'package:nuox_project/pages/featured/services/catagories_section/catagories_provider.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/bold_heading.dart';
import '../../../../widgets/see_all_widget.dart';
import '../../widgets/catagories_button.dart';

class CatagoriesSection extends StatelessWidget {
  const CatagoriesSection({super.key});
  @override
  Widget build(BuildContext context) {
    final catagoriesProvider =
        Provider.of<CatagoriesProvider>(context).catagoriesList;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BoldHeading(heading: "Catagories"),
            GestureDetector(
              child: const SeeAllWidget(),
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
            physics: const BouncingScrollPhysics(),
            itemCount: 4,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final datas = catagoriesProvider!.data![index];
              return CatagoriesButton(
                title: datas.categoryName.toString(),
                navigatepage: "catagoriesDetailedPage",
                id: datas.id!,
              );
            },
          ),
        )
      ],
    );
  }
}
