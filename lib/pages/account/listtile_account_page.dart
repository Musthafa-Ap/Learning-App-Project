import 'package:flutter/material.dart';
import 'package:nuox_project/authentication/login_page.dart';
import 'package:nuox_project/authentication/providers/auth_provider.dart';
import 'package:nuox_project/pages/account/sections/support/about_app_page.dart';
import 'package:nuox_project/pages/account/sections/support/change_password.dart';
import 'package:nuox_project/pages/account/sections/support/faq_page.dart';
import 'package:nuox_project/pages/account/sections/support/report_page.dart';
import 'package:nuox_project/pages/featured/services/featured_section/featured_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../my_home_page.dart';
import 'account_services/account_provider.dart';
import 'sections/whishlist/whishlist_page.dart';

class ListTileAccountPage extends StatelessWidget {
  final int index;
  final String tiletitle;
  const ListTileAccountPage(
      {super.key, required this.tiletitle, required this.index});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return SizedBox(
      height: 40,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () async {
          if (index == 0) {
            await Provider.of<AccountProvider>(context, listen: false).getFAQ();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const FAQPage()));
          } else if (index == 1) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AboutAppPage()));
          } else if (index == 5) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ReportPage()));
          } else if (index == 2) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ChangePasswordPage()));
          } else if (index == 6) {
            await Provider.of<FeaturedProvider>(context, listen: false)
                .getWhishlist();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const WhichlistPage()));
          } else if (index == 3) {
            await Share.share(
                "https://i.guim.co.uk/img/media/71dd7c5b208e464995de3467caf9671dc86fcfd4/1176_345_3557_2135/master/3557.jpg?width=620&quality=45&dpr=2&s=none");
          } else if (index == 4) {
            showDialog(
                barrierColor: Colors.black.withOpacity(.5),
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    backgroundColor: Colors.black,
                    title: const Text(
                      "Delete Account",
                      style: TextStyle(color: Colors.white),
                    ),
                    content: const Text(
                      "Do you want to delete the account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("No"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            authProvider.deleteAccount(context);
                            selectedIndex.value = 0;
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                              (route) => false,
                            );
                          },
                          child: const Text("Yes"))
                    ],
                  );
                });
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tiletitle,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const Icon(
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
