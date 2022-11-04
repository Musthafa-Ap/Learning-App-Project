import 'package:flutter/material.dart';
import 'package:nuox_project/authentication/login_page.dart';
import 'package:nuox_project/authentication/providers/auth_provider.dart';
import 'package:nuox_project/pages/account/sections/support/about_app_page.dart';
import 'package:nuox_project/pages/account/sections/support/change_password.dart';
import 'package:nuox_project/pages/account/sections/support/faq_page.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ListTileAccountPage extends StatelessWidget {
  final int index;
  final String tiletitle;
  ListTileAccountPage({required this.tiletitle, required this.index});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return SizedBox(
      height: 40,
      child: GestureDetector(
        onTap: () async {
          if (index == 0) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => FAQPage()));
          } else if (index == 1) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AboutAppPage()));
          } else if (index == 2) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ChangePasswordPage()));
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
                    title: Text(
                      "Delete Account",
                      style: TextStyle(color: Colors.white),
                    ),
                    content: Text(
                      "Do you want to delete the account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("No"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            authProvider.deleteAccount(context);
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (route) => false,
                            );
                          },
                          child: Text("Yes"))
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
