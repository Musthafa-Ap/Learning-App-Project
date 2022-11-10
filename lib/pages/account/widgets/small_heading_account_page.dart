import 'package:flutter/material.dart';

class SmallHeading extends StatelessWidget {
  final String heading;
  const SmallHeading({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: const TextStyle(color: Colors.grey, fontSize: 14),
    );
  }
}
