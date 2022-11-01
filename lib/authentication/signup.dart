import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuox_project/authentication/login_page.dart';
import 'package:nuox_project/authentication/mobile_number_verification_page.dart';
import 'providers/auth_provider.dart';
import '../constants/constants.dart';
import 'package:provider/provider.dart';

ValueNotifier<bool> isdocumentUploadedNotifier = ValueNotifier(false);
ValueNotifier<bool> instructorOptionNotifier = ValueNotifier(false);
final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class SignUpWidget extends StatefulWidget {
  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _nameController = TextEditingController();

  final _numberController = TextEditingController();

  GoogleSignInAccount? _currentUser;
  File? documentFile;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    Future<void> signIn() async {
      try {
        await _googleSignIn.signOut();
        _currentUser = await _googleSignIn.signIn();
        if (_currentUser != null) {
          authProvider.socialLogin(
              name: _currentUser!.displayName.toString(),
              context: context,
              id: _currentUser!.id.toString(),
              email: _currentUser!.email.toString());
        }
      } catch (e) {
        print("Error signing in $e");
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
                ],
                keyboardType: TextInputType.name,
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
                style: TextStyle(color: Colors.black),
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                keyboardType: TextInputType.number,
                controller: _numberController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(top: 11, left: 1),
                    child: Text(
                      "  +91",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  errorText: authProvider.mobile_error,
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Mobile Number",
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
                obscureText: _obscureText,
                controller: _passwordController,
                cursorColor: Colors.black,
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
              KHeight,
              FlutterPwValidator(
                controller: _passwordController,
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
              ValueListenableBuilder(
                valueListenable: instructorOptionNotifier,
                builder: (context, newvValue, child) {
                  return Row(
                    children: [
                      const Text(
                        "Are you an instructor ?",
                        style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      KWidth10,
                      const Text(
                        "Yes",
                        style: TextStyle(color: Colors.white),
                      ),
                      Radio(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                          value: true,
                          groupValue: newvValue,
                          onChanged: (value) {
                            instructorOptionNotifier.value = value!;
                          }),
                      const Text(
                        "No",
                        style: TextStyle(color: Colors.white),
                      ),
                      Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        value: false,
                        groupValue: newvValue,
                        onChanged: (value) {
                          instructorOptionNotifier.value = value!;
                        },
                      )
                    ],
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: instructorOptionNotifier,
                builder: (context, value, child) {
                  return value == true
                      ? GestureDetector(
                          onTap: () async {
                            FilePickerResult? resultFile =
                                await FilePicker.platform.pickFiles();
                            if (resultFile != null) {
                              PlatformFile file = resultFile.files.first;
                              print(file.path);
                              setState(() {
                                documentFile = File(file.path.toString());
                                print("document name :${documentFile}");
                              });

                              isdocumentUploadedNotifier.value = true;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                          'Document updoaded successfully')));
                            } else {
                              isdocumentUploadedNotifier.value = false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content:
                                          Text('Please upload a document')));
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 45),
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Center(
                                child: ValueListenableBuilder(
                              valueListenable: isdocumentUploadedNotifier,
                              builder: (context, value, child) {
                                return value == false
                                    ? const Text(
                                        "Upload a document",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    : const Text(
                                        "Document uploaded",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      );
                              },
                            )),
                          ),
                        )
                      : const SizedBox();
                },
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
                      if (instructorOptionNotifier.value == false) {
                        authProvider.registration(
                            context: context,
                            email:
                                _emailController.text.toString().toLowerCase(),
                            number: _numberController.text.toString(),
                            name: _nameController.text.toString(),
                            password: _passwordController.text.toString());
                      } else {
                        if (isdocumentUploadedNotifier.value == false) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Please upload a document')));
                        } else {
                          if (documentFile == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Please upload a document')));
                            print("document is null");
                          } else {
                            print("File is not null");
                            authProvider.instructorRegistration(
                                isInstructor: true,
                                document: documentFile,
                                context: context,
                                email: _emailController.text
                                    .toString()
                                    .toLowerCase(),
                                number: _numberController.text.toString(),
                                name: _nameController.text.toString(),
                                password: _passwordController.text.toString());
                          }
                          print("Logined with document");
                        }
                      }
                    }
                  },
                  child: authProvider.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : const Text("Sign up",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),

              KHeight20,
              Row(
                children: const [
                  Expanded(
                      child: Divider(
                    thickness: 1,
                    color: Colors.white,
                  )),
                  Padding(
                    padding: EdgeInsets.all(8.0),
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
                    signIn();
                  },
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
}
