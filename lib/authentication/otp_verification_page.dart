import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/my_home_page.dart';
import 'package:nuox_project/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/oulined_text_field_widget.dart';

class OTPVerificationPage extends StatelessWidget {
  final _globalKey = GlobalKey<FormState>();
  String mailid;
  OTPVerificationPage({super.key, required this.mailid});
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _retypeNewPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("OTP"),
      ),
      body: Form(
        key: _globalKey,
        child: ListView(
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
                  hintText: "ENTER OTP ",
                  hintStyle: TextStyle(color: Colors.black)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (otp) =>
                  otp == null || otp.isEmpty ? "Enter a valid OTP" : null,
            ),
            KHeight20,
            KHeight,
            TextFormField(
              style: const TextStyle(color: Colors.black),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (password) => password != null && password.length < 8
                  ? "Enter min. 8 characters"
                  : null,
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "New Password",
              ),
            ),
            KHeight20,
            TextFormField(
              obscureText: true,
              style: const TextStyle(color: Colors.black),
              controller: _retypeNewPasswordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "Re-type New Password",
              ),
              validator: ((value) => value == _newPasswordController.text
                  ? null
                  : "Password mismatch"),
            ),
            SizedBox(
              height: size * .1,
            ),
            ElevatedButton(
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
                  if (_globalKey.currentState!.validate()) {
                    authProvider.EmailOTPSubmission(
                        context: context,
                        OTP: _otpController.text.toString(),
                        email: mailid,
                        newPassword: _newPasswordController.text.toString());
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
