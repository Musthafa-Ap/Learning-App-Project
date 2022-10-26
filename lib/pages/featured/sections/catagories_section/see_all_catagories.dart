import 'package:flutter/material.dart';
import 'package:nuox_project/widgets/catagories_list_tile.dart';

class SeeAllCatagories extends StatelessWidget {
  SeeAllCatagories({super.key});
  final List<Map<String, dynamic>> _tileDetailes = [
    {"title": "Development", "icon": Icons.developer_mode},
    {"title": "Business", "icon": Icons.business},
    {"title": "Photography", "icon": Icons.photo_camera},
    {"title": "IT & Software", "icon": Icons.computer_outlined},
    {"title": "Office Productivity", "icon": Icons.build},
  ];
  @override
  Widget build(BuildContext context) {
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
            itemCount: _tileDetailes.length,
            itemBuilder: (context, index) {
              final data = _tileDetailes[index];
              return CatagoriesListTile(
                  title: data["title"], icon: data["icon"]);
            },
          )
        ],
      ),
    );
  }
}
