import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nuox_project/constants/constants.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("About App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: const [
              Text(
                "NUOX Learning App",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              KHeight15,
              Expanded(
                child: Text(
                  "Nuox Learning App is a leading destination for online courses that empowers you to grow professionally and personally.Get the app to explore our expansive library of thousands of topics with cutting-edge online video courses in Coding,Developemnt, Python, Java, Business, Marketing, SEO, SEM, Drawing, Photography and much more.",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, wordSpacing: 3),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
