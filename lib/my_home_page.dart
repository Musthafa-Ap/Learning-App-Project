import 'package:flutter/material.dart';
import 'package:nuox_project/authentication/login_page.dart';
import 'package:nuox_project/pages/featured/featured.dart';
import 'package:nuox_project/pages/my_learning/myLearning.dart';
import 'package:nuox_project/pages/cart/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/account/account.dart';
import 'pages/search/search.dart';
import 'widgets/bottomNavBar.dart';

ValueNotifier selectedIndex = ValueNotifier(0);

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isGuest = false;
  List<Widget> _pages = [Featured(), Search(), MyLearning(), Cart(), Account()];
  @override
  void initState() {
    get();
    super.initState();
  }

  void get() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    bool? guest = _shared.getBool("guest");
    if (guest == true) {
      _pages = [Featured(), Search(), Test(), Test(), Test()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: BottomNavBar(),
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
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false,
      );
    });
    super.initState();
  }

  void get() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    await _shared.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
