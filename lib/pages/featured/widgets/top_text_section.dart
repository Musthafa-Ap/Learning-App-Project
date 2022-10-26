import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class TopTextSection extends StatelessWidget {
  const TopTextSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KHeight,
        const Text(
          "Learning that fits",
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "Skills for your present (and future)",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        KHeight,
        Container(
          width: double.infinity,
          height: 35,
          color: const Color.fromARGB(255, 235, 221, 100),
          child: const Align(
            alignment: Alignment.center,
            child: Text("Future-ready skills on your schedule"),
          ),
        )
      ],
    );
  }
}
