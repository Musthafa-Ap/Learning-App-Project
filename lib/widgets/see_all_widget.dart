import 'package:flutter/material.dart';

class SeeAllWidget extends StatelessWidget {
  const SeeAllWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "See all",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.purple,
      ),
    );
  }
}
