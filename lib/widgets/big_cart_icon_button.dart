import 'package:flutter/material.dart';

class BigCartIconButton extends StatelessWidget {
  const BigCartIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(5)),
        margin: const EdgeInsets.only(right: 20),
        height: 35,
        width: 70,
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_bag,
              color: Colors.white,
              size: 35,
            )));
  }
}
