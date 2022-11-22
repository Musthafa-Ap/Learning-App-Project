import 'package:flutter/material.dart';
import 'package:nuox_project/authentication/providers/auth_provider.dart';
import 'package:nuox_project/authentication/providers/widgets/top_image.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';

class RegistrationOTPSubmissionPage extends StatelessWidget {
  final bool instructor;
  final _formKey = GlobalKey<FormState>();
  final String email;
  RegistrationOTPSubmissionPage(
      {super.key, required this.email, this.instructor = false});
  final _otpController = TextEditingController();
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
          title: const Text("OTP Submission"),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(15),
              children: [
                SizedBox(
                  height: size * .15,
                ),
                const TopImage(),
                SizedBox(
                  height: size * .2,
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
                      hintStyle: const TextStyle(color: Colors.black)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter OTP"
                      : null,
                ),
                kheight20,
                kHeight,
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
                        authProvider.registrationOTPSubmission(
                            instructor: instructor,
                            email: email,
                            otp: _otpController.text,
                            context: context);
                      }
                    },
                    icon: const Icon(
                      Icons.email,
                      size: 25,
                    ),
                    label: const Text("Submit",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)))
              ]),
        ));
  }
}
