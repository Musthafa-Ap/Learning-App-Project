import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuox_project/authentication/forgot.dart';
import 'package:nuox_project/authentication/providers/widgets/top_image.dart';
import 'package:nuox_project/authentication/signup.dart';
import 'package:nuox_project/my_home_page.dart';
import 'package:nuox_project/authentication/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import 'mobile_number_verification_page.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignInAccount? _currentUser;
  bool _obscureText = true;
  final _globalKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthProvider>(context);
    Future<void> signIn() async {
      try {
        print("Entered");
        await _googleSignIn.signOut();
        print("logout");
        _currentUser = await _googleSignIn.signIn();
        if (_currentUser != null) {
          print("current user not null");
          authProvider.socialLogin(
              name: _currentUser!.displayName.toString(),
              context: context,
              id: _currentUser!.id.toString(),
              email: _currentUser!.email.toString());
        }
        if (_currentUser == null) {
          return;
        }
      } catch (e) {
        print(e.toString());
      }
    }

    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Form(
            key: _globalKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              children: [
                SizedBox(height: size * .15),
                const TopImage(),
                SizedBox(height: size * .1),
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
                kHeight,
                TextFormField(
                  obscureText: _obscureText,
                  controller: _passwordController,
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
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        : const Text("Login",
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
                kHeight,
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
                kHeight,
                SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              MobileNumberverificationPage()));
                    },
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Colors.white))),
                    child: Row(
                      children: [
                        const Spacer(),
                        SizedBox(
                          width: 45,
                          child: Image.network(
                              "https://cdn5.vectorstock.com/i/1000x1000/93/64/telephone-receiver-line-icon-on-black-background-vector-26849364.jpg"),
                        ),
                        const Text(
                          "Log in with Mobile number",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const Spacer()
                      ],
                    ),
                  ),
                ),
                kheight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        signIn();
                      },
                      child: SizedBox(
                        width: 25,
                        child: Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png"),
                      ),
                    ),
                  ],
                ),
                kHeight15,
                kheight20,
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignUpWidget()));
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                    )
                  ],
                ),
                kheight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Join as a ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences sharedPref =
                            await SharedPreferences.getInstance();
                        sharedPref.setBool("isLogged", true);
                        sharedPref.setBool("guest", true);
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('Joined as a guest')));
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage()),
                            (route) => false);
                      },
                      child: const Text(
                        "Guest",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
