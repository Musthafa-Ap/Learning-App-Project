import 'package:flutter/material.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/catagories_detailed_page.dart';

class CatagoriesButton extends StatelessWidget {
  final String title;
  final Widget navigatepage;
  const CatagoriesButton({required this.navigatepage, required this.title});

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (Context) => navigatepage));
          },
          child: Text(title)),
    );
  }
}
