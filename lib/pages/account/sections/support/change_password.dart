import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:nuox_project/pages/account/account_services/account_provider.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _retypeNewPasswordController = TextEditingController();
  TextEditingController _oldPasswordController = TextEditingController();
  bool _obscureText = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Change password"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (password) => password != null && password.length < 8
                  ? "Enter min. 8 characters"
                  : null,
              controller: _oldPasswordController,
              obscureText: _obscureText2,
              decoration: InputDecoration(
                errorText: accountProvider.old_pass_error,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText2 = !_obscureText2;
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
                hintText: "Old Password",
              ),
            ),
            KHeight,
            TextFormField(
              style: const TextStyle(color: Colors.black),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (password) => password != null && password.length < 8
                  ? "Enter min. 8 characters"
                  : null,
              controller: _newPasswordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                errorText: accountProvider.new_pass_error,
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
            KHeight,
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
            KHeight,
            FlutterPwValidator(
              controller: _newPasswordController,
              minLength: 8,
              uppercaseCharCount: 1,
              numericCharCount: 1,
              specialCharCount: 1,
              width: 400,
              height: 150,
              onSuccess: () {
                print("matched");
              },
              // onFail: yourCallbackFunction),
            ),
            KHeight15,
            KHeight20,
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
                  if (_formKey.currentState!.validate()) {
                    final old_pass = _oldPasswordController.text;
                    final new_pass = _newPasswordController.text;
                    final retype_new = _retypeNewPasswordController.text;
                    accountProvider.changePassword(
                        oldPass: old_pass,
                        newPass: new_pass,
                        retypeNewPass: retype_new,
                        context: context);
                  }
                  ;
                },
                child: accountProvider.isChangePassLoading
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
