import 'package:flutter/material.dart';

class NoCourseFoundPage extends StatelessWidget {
  const NoCourseFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text("Featured"),
      ),
      body: const Center(
        child: Text(
          "No course found",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
