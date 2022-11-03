import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuox_project/authentication/login_page.dart';
import 'package:nuox_project/authentication/providers/auth_provider.dart';
import 'package:nuox_project/my_home_page.dart';
import 'package:nuox_project/pages/account/account_services/account_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPageButton extends StatelessWidget {
  final buttontitle;
  AccountPageButton({required this.buttontitle});
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return ElevatedButton(
        style: ButtonStyle(
            overlayColor:
                MaterialStateProperty.all(Color.fromARGB(255, 51, 50, 50)),
            backgroundColor:
                MaterialStateProperty.all(Color.fromARGB(0, 40, 39, 39))),
        onPressed: () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => LoginPage()));
          authProvider.logOut(context);
        },
        child: Text(
          buttontitle,
          style: const TextStyle(
            color: Colors.purple,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
