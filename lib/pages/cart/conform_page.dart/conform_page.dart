import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/my_home_page.dart';
import 'package:nuox_project/pages/cart/cart_services/cart_services.dart';
import 'package:nuox_project/pages/my_learning/services/my_learnings_provider.dart';
import 'package:provider/provider.dart';

class ConformPurchasePage extends StatelessWidget {
  const ConformPurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final myLearningsProvider = Provider.of<MyLearningsProvider>(context);
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          SizedBox(
            height: size * .3,
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: size * .25,
            backgroundImage: NetworkImage(
                "https://static.vecteezy.com/system/resources/previews/006/900/704/original/green-tick-checkbox-illustration-isolated-on-white-background-free-vector.jpg"),
          ),
          Center(
            child: Text(
              "Congratulations",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          KHeight,
          Center(
            child: Text(
              "Course successfully purchased",
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: size * .1,
          ),
          Center(
              child: Text(
            cartProvider.orderID == null
                ? "Order ID : 32532542352"
                : "Order ID : ${cartProvider.orderID}",
            style: TextStyle(fontSize: 16),
          )),
          SizedBox(
            height: size * .2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple)),
                onPressed: () async {
                  await myLearningsProvider.getMyLearnings();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    (route) => false,
                  );
                },
                child: Text("Back to Home")),
          )
        ],
      ),
    );
  }
}
