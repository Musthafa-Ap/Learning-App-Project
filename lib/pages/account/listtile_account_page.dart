import 'package:flutter/material.dart';
import 'package:nuox_project/pages/account/sections/support/about_app_page.dart';
import 'package:nuox_project/pages/account/sections/support/faq_page.dart';
import 'package:share_plus/share_plus.dart';

class ListTileAccountPage extends StatelessWidget {
  final int index;
  final String tiletitle;
  ListTileAccountPage({required this.tiletitle, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (index == 0) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FAQPage()));
        } else if (index == 1) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AboutAppPage()));
        } else if (index == 5) {
          await Share.share(
              "https://i.guim.co.uk/img/media/71dd7c5b208e464995de3467caf9671dc86fcfd4/1176_345_3557_2135/master/3557.jpg?width=620&quality=45&dpr=2&s=none");
        }
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
