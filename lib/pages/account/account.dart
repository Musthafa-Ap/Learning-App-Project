import 'package:flutter/material.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/pages/account/sections/support/faq_page.dart';
import 'listtile_account_page.dart';
import 'widgets/account_page_button.dart';
import 'widgets/small_heading_account_page.dart';
import 'sections/profile/user_detailes_section.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Account'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          UserDetailesSection(),
          KHeight20,
          const SmallHeading(heading: "Support"),
          KHeight,
          ListTileAccountPage(
            tiletitle: "FAQ",
            navigatorPage: FAQPage(),
          ),
          KHeight15,
          ListTileAccountPage(tiletitle: "About App"),
          KHeight15,
          ListTileAccountPage(tiletitle: "Change Password"),
          KHeight15,
          ListTileAccountPage(tiletitle: "About App Business"),
          KHeight15,
          ListTileAccountPage(tiletitle: "Help and Support"),
          KHeight15,
          ListTileAccountPage(tiletitle: "Share the app"),
          KHeight15,
          ListTileAccountPage(tiletitle: "Delete Account"),
          KHeight20,
          AccountPageButton(buttontitle: "Sign out"),
          KHeight,
          Center(
            child: Text(
              "Tutorial App v8.32.0.1745",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
