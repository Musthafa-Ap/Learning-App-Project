import 'package:flutter/material.dart';
import 'package:nuox_project/my_home_page.dart';
import 'package:nuox_project/providers/auth_provider.dart';
import 'package:nuox_project/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication/login_page.dart';
import 'providers/auth_provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
          )),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? MyHomePage() : LoginPage(),
    );
  }

  Future<void> checkUserLoggedIn() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    bool? userLoggedIn = sharedPrefs.getBool("isLogged");

    if (userLoggedIn == null || userLoggedIn == false) {
      setState(() {
        isLoggedIn = false;
      });
    } else {
      setState(() {
        isLoggedIn = true;
      });
    }
  }
}
