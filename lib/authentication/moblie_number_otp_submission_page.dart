import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nuox_project/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';

class MobileNumberOTPSubmissionPage extends StatelessWidget {
  final String number;
  MobileNumberOTPSubmissionPage({super.key, required this.number});
  final _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("OTP Submission"),
        ),
        body: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(15),
            children: [
              SizedBox(
                height: size * .3,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black),
                controller: _otpController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Enter OTP ",
                    hintStyle: TextStyle(color: Colors.black)),
              ),
              KHeight20,
              KHeight,
              ElevatedButton.icon(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 15)),
                      backgroundColor: const MaterialStatePropertyAll(
                        Colors.purple,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      )),
                  onPressed: () {
                    authProvider.numberOTPSubmission(
                        number: number,
                        context: context,
                        OTP: _otpController.text.toString());
                  },
                  icon: const Icon(
                    Icons.mobile_friendly,
                    size: 25,
                  ),
                  label: const Text("Submit",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
            ]));
  }
}
