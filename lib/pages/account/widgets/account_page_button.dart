import 'package:flutter/material.dart';
import 'package:nuox_project/authentication/providers/auth_provider.dart';
import 'package:nuox_project/authentication/signup.dart';
import 'package:provider/provider.dart';

class AccountPageButton extends StatelessWidget {
  final String buttontitle;
  const AccountPageButton({super.key, required this.buttontitle});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return ElevatedButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 51, 50, 50)),
            backgroundColor:
                MaterialStateProperty.all(const Color.fromARGB(0, 40, 39, 39))),
        onPressed: () {
          isdocumentUploadedNotifier.value = false;
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
