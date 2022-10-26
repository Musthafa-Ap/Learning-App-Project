import 'package:flutter/material.dart';

class OutlinedTextFieldWidget extends StatelessWidget {
  final hintText;
  const OutlinedTextFieldWidget({required this.hintText});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black,
          border: Border.all(color: Colors.white)),
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white)),
      ),
    );
  }
}
