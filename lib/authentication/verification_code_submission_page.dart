import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class VerificationCodeSubmissionPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              "Submit the verification code recieved by your email",
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
              controller: _emailController,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Verification code",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (code) => code == null || code.isEmpty
                  ? "Enter valid verification code"
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
                onPressed: () {},
                icon: const Icon(
                  Icons.email_outlined,
                  size: 25,
                ),
                label: const Text("Submit",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
          ],
        ),
      )),
    );
  }
}
