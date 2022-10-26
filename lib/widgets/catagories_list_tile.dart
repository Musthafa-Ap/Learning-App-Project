import 'package:flutter/material.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/catagories_detailed_page.dart';

class CatagoriesListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? navigatorpage;
  CatagoriesListTile(
      {this.navigatorpage, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CatagoriesDetailedPage()));
      },
      leading: Icon(icon, color: Colors.white),
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
