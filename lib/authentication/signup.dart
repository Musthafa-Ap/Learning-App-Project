import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuox_project/authentication/login_page.dart';
import 'package:nuox_project/authentication/mobile_number_verification_page.dart';
import '../providers/auth_provider.dart';
import '../constants/constants.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _nameController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  errorText: authProvider.name_error,
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: ((value) => value == null || value.isEmpty
                    ? "Please enter your name"
                    : null),
              ),
              KHeight,
              TextFormField(
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                keyboardType: TextInputType.number,
                controller: _numberController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  errorText: authProvider.mobile_error,
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Mobile Number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: ((value) => value == null || value.length < 10
                    ? "Enter a valid mobile number"
                    : null),
              ),
              KHeight,
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      errorText: authProvider.email_error,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Email"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? "Enter a valid email"
                          : null),
              KHeight,
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Password"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) => password != null && password.length < 8
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
                    final istrue = _formKey.currentState!.validate();
                    if (istrue) {
                      authProvider.registration(
                          context: context,
                          email: _emailController.text.toString().toLowerCase(),
                          number: _numberController.text.toString(),
                          name: _nameController.text.toString(),
                          password: _passwordController.text.toString());
                    }
                  },
                  child: authProvider.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : Text("Sign up",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),

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
                            color: Colors.white, fontWeight: FontWeight.bold)),
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
                            color: Colors.white, fontWeight: FontWeight.bold)),
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
                        builder: (context) => MobileNumberverificationPage()));
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
                    "Already Registered?",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  KWidth5,
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: const Text(
                      "Sign in",
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
      ),
    );
  }

  void onsingupButtonPressed() {}
}
