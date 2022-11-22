import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:nuox_project/authentication/providers/widgets/top_image.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/authentication/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class OTPVerificationPage extends StatefulWidget {
  String mailid;
  OTPVerificationPage({super.key, required this.mailid});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  bool _obscureText = true;
  bool _obscureText1 = true;
  final _globalKey = GlobalKey<FormState>();

  final _otpController = TextEditingController();

  final _newPasswordController = TextEditingController();

  final _retypeNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
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
              height: size * .15,
            ),
            const TopImage(),
            SizedBox(
              height: size * .1,
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
                  hintStyle: const TextStyle(color: Colors.black)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (otp) =>
                  otp == null || otp.isEmpty ? "Enter a valid OTP" : null,
            ),
            kHeight,
            TextFormField(
              style: const TextStyle(color: Colors.black),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (password) => password != null && password.length < 8
                  ? "Enter min. 8 characters"
                  : null,
              controller: _newPasswordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: _obscureText ? Colors.grey : Colors.black,
                    )),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "New Password",
              ),
            ),
            kHeight,
            TextFormField(
              obscureText: _obscureText1,
              style: const TextStyle(color: Colors.black),
              controller: _retypeNewPasswordController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText1 = !_obscureText1;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: _obscureText ? Colors.grey : Colors.black,
                    )),
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
            kHeight,
            FlutterPwValidator(
              controller: _newPasswordController,
              minLength: 8,
              uppercaseCharCount: 1,
              numericCharCount: 1,
              specialCharCount: 1,
              width: 400,
              height: 150,
              onSuccess: () {},
              // onFail: yourCallbackFunction),
            ),
            kHeight15,
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
                    authProvider.emailOTPSubmission(
                        context: context,
                        otp: _otpController.text.toString(),
                        email: widget.mailid,
                        newPassword: _newPasswordController.text.toString());
                  }
                },
                child: authProvider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
          ],
        ),
      ),
    );
  }
}
