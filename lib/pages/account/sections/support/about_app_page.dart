import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/pages/account/account_services/account_provider.dart';
import 'package:provider/provider.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("About App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              KHeight20,
              Text(
                accountProvider.aboutApp!.data!.first.title.toString(),
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              KHeight15,
              Expanded(
                child: Text(
                  accountProvider.aboutApp!.data!.first.aboutApp.toString(),
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, wordSpacing: 3),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
