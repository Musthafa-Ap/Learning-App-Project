import 'package:flutter/material.dart';
import 'package:nuox_project/pages/account/account_services/account_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/constants.dart';

class ReportPage extends StatelessWidget {
  ReportPage({super.key});
  final TextEditingController _reportController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text("Report a problem"),
      ),
      body: ListView(padding: const EdgeInsets.all(15), children: [
        SizedBox(
          height: size * .2,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black,
              border: Border.all(color: Colors.white)),
          child: TextField(
            controller: _reportController,
            style: const TextStyle(color: Colors.white),
            maxLines: 6,
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Report a problem...",
                hintStyle: TextStyle(color: Colors.white)),
          ),
        ),
        kheight20,
        SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple)),
            onPressed: () async {
              SharedPreferences shared = await SharedPreferences.getInstance();
              var email = shared.getString("email");
              var report = _reportController.text;
              if (email == null || email.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                        "Email id is not available.Please update your profile")));
                return;
              }
              if (report.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Please type your problem")));
                return;
              }
              accountProvider.report(
                  email: email, problem: report, context: context);
            },
            child: const Text("Submit"),
          ),
        ),
      ]),
    );
  }
}
