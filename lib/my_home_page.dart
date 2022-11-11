import 'package:flutter/material.dart';
import 'package:nuox_project/authentication/login_page.dart';
import 'package:nuox_project/pages/featured/featured.dart';
import 'package:nuox_project/pages/my_learning/my_learning.dart';
import 'package:nuox_project/pages/cart/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/account/account.dart';
import 'pages/search/search.dart';
import 'widgets/bottom_nav_bar.dart';

ValueNotifier selectedIndex = ValueNotifier(0);

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isGuest = false;
  List<Widget> _pages = const [
    Featured(),
    Search(),
    MyLearning(),
    Cart(),
    Account()
  ];
  @override
  void initState() {
    get();
    super.initState();
  }

  void get() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    bool? guest = shared.getBool("guest");
    if (guest == true) {
      _pages = const [Featured(), Search(), Test(), Test(), Test()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: const BottomNavBar(),
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: selectedIndex,
            builder: (context, value, child) {
              return _pages[value];
            },
          ),
        ));
  }
}

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    get();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      selectedIndex.value = 0;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    });
    super.initState();
  }

  void get() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    await shared.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
