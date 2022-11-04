import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/my_home_page.dart';

class ConformPurchasePage extends StatelessWidget {
  const ConformPurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            "Order ID : 32532542352",
            style: TextStyle(fontSize: 18),
          )),
          SizedBox(
            height: size * .25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple)),
                onPressed: () {
                  selectedIndex.value = 0;
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
