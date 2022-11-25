import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.all(15),
        children: [
          SizedBox(
            height: size * .2,
          ),
          // Align(
          //   child: CircleAvatar(
          //     backgroundColor: Colors.transparent,
          //     radius: size * .25,
          //     backgroundImage: const NetworkImage(
          //       "https://cdn.pixabay.com/photo/2012/04/24/13/49/tick-40143_640.png",
          //     ),
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: size * .5,
            decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image: NetworkImage(
                        "https://cdn.pixabay.com/photo/2012/04/24/13/49/tick-40143_640.png"))),
          ),
          kheight20,
          const Center(
            child: Text(
              "Congratulations",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          kHeight,
          const Center(
            child: Text(
              "Course successfully purchased",
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: size * .05,
          ),
          Center(
              child: Text(
            cartProvider.totalPrice == null
                ? "Total price : ₹5000"
                : "Total price : ₹${cartProvider.totalPrice}",
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          )),
          SizedBox(
            height: size * .05,
          ),
          Center(
              child: Text(
            cartProvider.orderID == null
                ? "Order ID : 32532542352"
                : "Order ID : ${cartProvider.orderID}",
            style: const TextStyle(fontSize: 16),
          )),
          SizedBox(
            height: size * .2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
            ),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple)),
                onPressed: () async {
                  await myLearningsProvider.getMyLearnings();
                  selectedIndex.value = 2;
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                    (route) => false,
                  );
                },
                child: const Text("Go to My Learnings")),
          ),
          SizedBox(
            height: size * .05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple)),
                onPressed: () async {
                  await myLearningsProvider.getMyLearnings();
                  selectedIndex.value = 0;
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                    (route) => false,
                  );
                },
                child: const Text("Back to Home")),
          )
        ],
      ),
    );
  }
}
