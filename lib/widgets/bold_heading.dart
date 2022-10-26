import 'package:flutter/material.dart';

class BoldHeading extends StatelessWidget {
  final String heading;
  const BoldHeading({required this.heading});

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
    );
  }
}
