import 'package:flutter/material.dart';
import 'package:nuox_project/pages/account/sections/support/faq_page.dart';

class ListTileAccountPage extends StatelessWidget {
  final Widget navigatorPage;
  final String tiletitle;
  ListTileAccountPage(
      {required this.tiletitle, this.navigatorPage = const SizedBox()});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => navigatorPage));
      },
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tiletitle,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
