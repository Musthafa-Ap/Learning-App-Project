import 'package:flutter/material.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/catagories_detailed_page.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/services/catagories_detailed_model.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/services/catagories_detailed_provider.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/widgets/sub_catagories_detailed_page.dart';
import 'package:provider/provider.dart';

class CatagoriesButton extends StatelessWidget {
  final int? id;
  final String? title;
  final String? navigatepage;
  const CatagoriesButton(
      {required this.navigatepage, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    final catagoiresdetailesProvider =
        Provider.of<CatagoriesDetailedProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 20)),
              backgroundColor: MaterialStateProperty.all(Colors.black),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.white)))),
          onPressed: () async {
            if (navigatepage == "sub_catagories_detailed") {
              await catagoiresdetailesProvider.getSubCatagoriesDetailes(
                  subCatagoriesID: id);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SubCatagoriesDetailedPage()));
            }
            if (navigatepage == "catagoriesDetailedPage") {
              await catagoiresdetailesProvider.getAll(
                catagoriesID: id,
              );
              await catagoiresdetailesProvider.getAllSub(catagoriesID: id);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CatagoriesDetailedPage()));
            }
          },
          child: Text(title ?? "Title of the course")),
    );
  }
}
