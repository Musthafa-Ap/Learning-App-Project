import 'package:flutter/material.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'listtile_account_page.dart';
import 'widgets/account_page_button.dart';
import 'widgets/small_heading_account_page.dart';
import 'sections/profile/user_detailes_section.dart';

class Account extends StatefulWidget {
  Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  DateTime dateTime = DateTime.now();
  bool? isChangePass = false;
  @override
  void initState() {
    get();
    super.initState();
  }

  void get() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    setState(() {
      isChangePass = _shared.getBool("changepass");
    });
  }

  @override
  Widget build(BuildContext context) {
    var formate1 = "${dateTime.day}.${dateTime.month}.${dateTime.year}";
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
            tiletitle: "Whishlist",
            index: 6,
          ),
          KHeight,
          ListTileAccountPage(
            tiletitle: "FAQ",
            index: 0,
          ),
          KHeight15,
          ListTileAccountPage(
            tiletitle: "About App",
            index: 1,
          ),
          KHeight15,
          ListTileAccountPage(
            tiletitle: "Share the app",
            index: 3,
          ),
          KHeight15,
          ListTileAccountPage(
            tiletitle: "Report a problem",
            index: 5,
          ),
          KHeight15,
          ListTileAccountPage(
            tiletitle: "Delete Account",
            index: 4,
          ),
          KHeight15,
          isChangePass == true
              ? ListTileAccountPage(
                  tiletitle: "Change Password",
                  index: 2,
                )
              : const SizedBox(),
          KHeight20,
          AccountPageButton(buttontitle: "Sign out"),
          KHeight,
          Center(
            child: Text(
              "Tutorial App $formate1 V1",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
