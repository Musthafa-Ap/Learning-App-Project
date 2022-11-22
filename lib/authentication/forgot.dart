import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:nuox_project/authentication/providers/widgets/top_image.dart';
import 'package:nuox_project/authentication/signup.dart';
import 'package:nuox_project/authentication/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';

class ForgotPassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.black,
        title: const Text("Reset password"),
      ),
      body: Center(
          child: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(height: size * .15),
            const TopImage(),
            SizedBox(
              height: size * .2,
            ),
            Center(
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter your email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) => email == null ||
                        email.isEmpty ||
                        !EmailValidator.validate(email)
                    ? "Enter a valid Email"
                    : null,
              ),
            ),
            const SizedBox(
              height: 30,
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
                  if (_formKey.currentState!.validate()) {
                    authProvider.forgotPassword(
                        context: context,
                        emailforOTP: _emailController.text.trim().toString());
                  }
                },
                child: authProvider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Text("Reset Password",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
            SizedBox(height: size * .4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "No account?",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                kWidth5,
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const SignUpWidget()),
                      (route) => false,
                    );
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
      )),
    );
  }
}
