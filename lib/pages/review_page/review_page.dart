import 'package:flutter/material.dart';
import 'package:nuox_project/constants/constants.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Review"),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(15),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black,
                border: Border.all(color: Colors.white)),
            child: TextField(
              style: TextStyle(color: Colors.white),
              maxLines: 6,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Any suggestions...",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
          ),
          KHeight20,
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Submit"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple)),
            ),
          ),
        ],
      ),
    );
  }
}
