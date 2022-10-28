import 'package:flutter/material.dart';
import 'package:nuox_project/pages/featured/services/catagories_section/catagories_provider.dart';
import 'package:nuox_project/widgets/catagories_list_tile.dart';
import 'package:provider/provider.dart';

class SeeAllCatagories extends StatelessWidget {
  SeeAllCatagories({super.key});
  final List<Map<String, dynamic>> _tileDetailes = [
    {"title": "Development", "icon": Icons.person},
    {"title": "Business", "icon": Icons.business},
    {"title": "Photography", "icon": Icons.photo_camera},
    {"title": "IT & Software", "icon": Icons.computer_outlined},
    {"title": "Office Productivity", "icon": Icons.build},
  ];
  @override
  Widget build(BuildContext context) {
    final catagoriesProvider =
        Provider.of<CatagoriesProvider>(context).catagoriesList!.data;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        physics: const BouncingScrollPhysics(),
        children: [
          const Text(
            "Categories",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: catagoriesProvider!.length,
            itemBuilder: (context, index) {
              var datas = catagoriesProvider[index];
              return CatagoriesListTile(
                icon: Icons.computer_outlined,
                title: datas.categoryName.toString(),
                id: datas.id!,
              );
            },
          )
        ],
      ),
    );
  }
}
