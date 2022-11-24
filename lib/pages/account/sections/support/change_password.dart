import 'package:flutter/material.dart';
import 'package:nuox_project/pages/account/account_services/account_provider.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _retypeNewPasswordController =
      TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  bool _obscureText = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  final _formKey = GlobalKey<FormState>();
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double password_strength = 0;
  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (_password.isEmpty) {
      setState(() {
        password_strength = 0;
      });
    } else if (_password.length < 6) {
      setState(() {
        password_strength = 1 / 4;
      });
    } else if (_password.length < 8) {
      setState(() {
        password_strength = 2 / 4;
      });
    } else {
      if (pass_valid.hasMatch(_password)) {
        setState(() {
          password_strength = 4 / 4;
        });
        return true;
      } else {
        setState(() {
          password_strength = 3 / 4;
        });
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text("Change password"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
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
                      color: _obscureText2 ? Colors.grey : Colors.black,
                    )),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Old Password",
              ),
            ),
            kHeight,
            TextFormField(
              onChanged: (value) {
                _formKey.currentState!.validate();
              },
              style: const TextStyle(color: Colors.black),
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (password) {
                if (password!.isEmpty) {
                  return "Please enter password";
                } else {
                  bool result = validatePassword(password);
                  if (result) {
                    //ceate account event
                    return null;
                  } else {
                    return "Password should contain Capital,small,number & special";
                  }
                }
              },
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
            kHeight,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: LinearProgressIndicator(
                value: password_strength,
                backgroundColor: Colors.grey,
                minHeight: 5,
                color: password_strength <= 1 / 4
                    ? Colors.red
                    : password_strength == 2 / 4
                        ? Colors.yellow
                        : password_strength == 3 / 4
                            ? Colors.blue
                            : Colors.green,
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(
            //       child: Container(
            //         margin: const EdgeInsets.symmetric(horizontal: 4),
            //         height: 8,
            //         child: LinearProgressIndicator(
            //             value: password_strength,
            //             backgroundColor: Colors.grey,
            //             minHeight: 5,
            //             color: password_strength <= 1 / 4
            //                 ? Colors.grey
            //                 : Colors.green),
            //       ),
            //     ),
            //     Expanded(
            //       child: Container(
            //         margin: const EdgeInsets.symmetric(horizontal: 4),
            //         height: 8,
            //         child: LinearProgressIndicator(
            //           value: password_strength,
            //           backgroundColor: Colors.grey,
            //           minHeight: 5,
            //           color: password_strength <= 1 / 4
            //               ? Colors.red
            //               : password_strength == 2 / 4
            //                   ? Colors.yellow
            //                   : password_strength == 3 / 4
            //                       ? Colors.blue
            //                       : Colors.green,
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: Container(
            //         margin: const EdgeInsets.symmetric(horizontal: 4),
            //         height: 8,
            //         child: LinearProgressIndicator(
            //           value: password_strength,
            //           backgroundColor: Colors.grey,
            //           minHeight: 5,
            //           color: password_strength <= 1 / 4
            //               ? Colors.red
            //               : password_strength == 2 / 4
            //                   ? Colors.yellow
            //                   : password_strength == 3 / 4
            //                       ? Colors.blue
            //                       : Colors.green,
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: Container(
            //         margin: const EdgeInsets.symmetric(horizontal: 4),
            //         height: 8,
            //         child: LinearProgressIndicator(
            //           value: password_strength,
            //           backgroundColor: Colors.grey,
            //           minHeight: 5,
            //           color: password_strength <= 1 / 4
            //               ? Colors.red
            //               : password_strength == 2 / 4
            //                   ? Colors.yellow
            //                   : password_strength == 3 / 4
            //                       ? Colors.blue
            //                       : Colors.green,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
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
                      color: _obscureText1 ? Colors.grey : Colors.black,
                    )),
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "Re-type New Password",
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: ((value) => value == _newPasswordController.text
                  ? null
                  : "Password mismatch"),
            ),
            const SizedBox(
              height: 50,
            ),
            // FlutterPwValidator(
            //   controller: _newPasswordController,
            //   minLength: 8,
            //   uppercaseCharCount: 1,
            //   numericCharCount: 1,
            //   specialCharCount: 1,
            //   width: 400,
            //   height: 150,
            //   onSuccess: () {},
            //   // onFail: yourCallbackFunction),
            // ),

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
