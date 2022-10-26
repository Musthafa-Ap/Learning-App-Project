import 'package:flutter/material.dart';
import 'package:nuox_project/pages/featured/featured.dart';
import 'package:nuox_project/pages/my_learning/myLearning.dart';
import 'package:nuox_project/pages/cart/cart.dart';
import 'pages/account/account.dart';
import 'pages/search/search.dart';
import 'widgets/bottomNavBar.dart';

ValueNotifier selectedIndex = ValueNotifier(0);

class MyHomePage extends StatelessWidget {
  final _pages = [Featured(), Search(), MyLearning(), Cart(), Account()];

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
