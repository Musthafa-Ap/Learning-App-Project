import 'package:flutter/material.dart';
import 'package:nuox_project/pages/cart/buy_all_page/buy_all_page.dart';
import 'package:nuox_project/pages/featured/sections/catagories_section/see_all_catagories.dart';

import '../../constants/constants.dart';
import '../../widgets/course_detailes_list_tile.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Course cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return SizedBox();
                  // return CourseDetailesListTile(
                  //   isCartItem: true,
                  // );
                },
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BuyAllPage()));
                },
                child: Text(
                  "Buy All",
                  style: TextStyle(fontSize: 20),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
              ),
            ),
            KHeight
          ],
        ),
      ),
    );
  }
}
