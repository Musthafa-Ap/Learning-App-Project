import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import 'widgets/my_learning_card.dart';

class MyLearning extends StatelessWidget {
  const MyLearning({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("My learning"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 28,
              )),
          IconButton(onPressed: () {}, icon: const Icon(Icons.sort, size: 28))
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15),
        physics: const BouncingScrollPhysics(),
        itemCount: 7,
        itemBuilder: (context, index) {
          return MyLearningCard();
        },
      ),
    );
  }
}
