import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nuox_project/pages/account/account_services/account_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/constants.dart';

class ReportPage extends StatelessWidget {
  ReportPage({super.key});
  TextEditingController _reportController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Report a problem"),
      ),
      body: ListView(padding: EdgeInsets.all(15), children: [
        SizedBox(
          height: size * .2,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black,
              border: Border.all(color: Colors.white)),
          child: TextField(
            controller: _reportController,
            style: TextStyle(color: Colors.white),
            maxLines: 6,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Report a problem...",
                hintStyle: TextStyle(color: Colors.white)),
          ),
        ),
        KHeight20,
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              SharedPreferences _shared = await SharedPreferences.getInstance();
              var email = _shared.getString("email");
              var report = _reportController.text;
              if (email == null || email.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                        "Email id is not available.Please update your profile")));
                return;
              }
              if (report == null || report.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Please type your problem")));
                return;
              }
              accountProvider.report(
                  email: email, problem: report, context: context);
            },
            child: Text("Submit"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple)),
          ),
        ),
      ]),
    );
  }
}
