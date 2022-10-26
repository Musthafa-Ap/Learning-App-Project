import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/widgets/bold_heading.dart';
import 'package:nuox_project/widgets/catagories_list_tile.dart';

class Search extends StatefulWidget {
  Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final List<Map<String, dynamic>> _tileDetailes = [
    {"title": "Development", "icon": Icons.developer_mode},
    {"title": "Business", "icon": Icons.business},
    {"title": "Photography", "icon": Icons.photo_camera},
    {"title": "IT & Software", "icon": Icons.computer_outlined},
    {"title": "Office Productivity", "icon": Icons.build},
  ];

  List<Map<String, dynamic>> _foundItems = [];
  @override
  void initState() {
    _foundItems = _tileDetailes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoSearchTextField(
              onChanged: (value) {
                _runFilter(value);
              },
              backgroundColor: Colors.grey.withOpacity(.4),
              prefixIcon: const Icon(
                CupertinoIcons.search,
                color: Colors.grey,
              ),
              suffixIcon: const Icon(
                CupertinoIcons.xmark,
                color: Colors.white,
              ),
              style: const TextStyle(color: Colors.white),
            ),
            KHeight,
            const BoldHeading(heading: "Browse Catagories"),
            KHeight,
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _foundItems.length,
                itemBuilder: (context, index) {
                  final data = _foundItems[index];
                  return CatagoriesListTile(
                      title: data["title"], icon: data["icon"]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _tileDetailes;
    } else {
      results = _tileDetailes
          .where((item) => item["title"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundItems = results;
    });
  }
}
