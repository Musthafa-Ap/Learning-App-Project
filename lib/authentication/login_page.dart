import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:nuox_project/authentication/forgot.dart';
import 'package:nuox_project/authentication/signup.dart';
import 'package:nuox_project/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import 'mobile_number_verification_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  final _globalKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Form(
            key: _globalKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              children: [
                SizedBox(height: size * .3),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      errorText: authProvider.login_email_error,
                      hintText: "Email"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? "Enter a valid mail"
                          : null,
                ),
                KHeight,
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                      errorText: authProvider.login_pass_error,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Password"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) =>
                      password != null && password.length < 8
                          ? "Enter min. 8 characters"
                          : null,
                ),
                const SizedBox(
                  height: 25,
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
                        authProvider.login(
                            context: context,
                            email: _emailController.text
                                .trim()
                                .toString()
                                .toLowerCase(),
                            password: _passwordController.text.toString());
                      }
                    },
                    child: authProvider.isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        : Text("Login",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: GestureDetector(
                    child: const Text(
                      "Forgot password ?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotPassword()));
                    },
                  ),
                ),

                KHeight20,
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 1,
                      color: Colors.white,
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("OR",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                        child: Divider(
                      color: Colors.white,
                      thickness: 1,
                    ))
                  ],
                ),
                KHeight20,
                SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text(
                      "Log in with Google",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Colors.white))),
                  ),
                ),
                KHeight20,
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 1,
                      color: Colors.white,
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("OR",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                        child: Divider(
                      color: Colors.white,
                      thickness: 1,
                    ))
                  ],
                ),
                KHeight20,
                SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              MobileNumberverificationPage()));
                    },
                    child: const Text(
                      "Log in with Mobile number",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Colors.white))),
                  ),
                ),
                KHeight15,
                KHeight20,
                //////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "No account?",
                      style: const TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    KWidth5,
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpWidget()));
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
