import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:nuox_project/authentication/verification_code_submission_page.dart';
import 'package:nuox_project/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Reset password"),
      ),
      body: Center(
          child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Recieve an email to reset your password",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 70,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) => email == null ||
                      email.isEmpty ||
                      !EmailValidator.validate(email)
                  ? "Enter a valid Email"
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
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
                  if (_formKey.currentState!.validate()) {
                    authProvider.forgotPassword(
                        context: context,
                        emailforOTP: _emailController.text.trim().toString());
                  }
                },
                icon: const Icon(
                  Icons.email_outlined,
                  size: 25,
                ),
                label: const Text("Reset Password",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
          ],
        ),
      )),
    );
  }
}
