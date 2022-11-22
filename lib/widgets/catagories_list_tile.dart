import 'package:flutter/material.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/catagories_detailed_page.dart';

class CatagoriesListTile extends StatelessWidget {
  final int id;
  final String title;
  final String? iconImage;
  final Widget? navigatorpage;
  const CatagoriesListTile(
      {super.key,
      this.navigatorpage,
      required this.title,
      required this.iconImage,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CatagoriesDetailedPage()));
      },
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(iconImage ??
                    "https://static.vecteezy.com/system/resources/previews/002/363/076/original/computer-icon-free-vector.jpg"))),
      ),
      //Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
