import 'package:flutter/material.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'listtile_account_page.dart';
import 'widgets/account_page_button.dart';
import 'sections/profile/user_detailes_section.dart';

class Account extends StatefulWidget {
  const Account({super.key});

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
    SharedPreferences shared = await SharedPreferences.getInstance();
    setState(() {
      isChangePass = shared.getBool("changepass");
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
          const UserDetailesSection(),
          kheight20,
          // const SmallHeading(heading: "Support"),
          //kHeight,
          const ListTileAccountPage(
            tiletitle: "Wishlist",
            index: 6,
          ),
          kHeight,
          const ListTileAccountPage(
            tiletitle: "Orders",
            index: 7,
          ),
          kHeight,
          const ListTileAccountPage(
            tiletitle: "FAQ",
            index: 0,
          ),
          kHeight15,
          const ListTileAccountPage(
            tiletitle: "About App",
            index: 1,
          ),
          kHeight15,
          isChangePass == true
              ? Column(
                  children: const [
                    ListTileAccountPage(
                      tiletitle: "Change Password",
                      index: 2,
                    ),
                    kHeight15,
                  ],
                )
              : Container(),

          const ListTileAccountPage(
            tiletitle: "Share the app",
            index: 3,
          ),
          kHeight15,
          const ListTileAccountPage(
            tiletitle: "Report a problem",
            index: 5,
          ),
          kHeight15,
          const ListTileAccountPage(
            tiletitle: "Delete Account",
            index: 4,
          ),
          kHeight15,

          //kheight20,
          const AccountPageButton(buttontitle: "Sign out"),
          kHeight,
          Center(
            child: Text(
              "Tutorial App $formate1 V1",
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
