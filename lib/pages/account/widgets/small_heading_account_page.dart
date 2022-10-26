import 'package:flutter/material.dart';

class SmallHeading extends StatelessWidget {
  final heading;
  const SmallHeading({required this.heading});

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: TextStyle(color: Colors.grey, fontSize: 14),
    );
  }
}
