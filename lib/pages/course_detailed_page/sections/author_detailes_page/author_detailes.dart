import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_provider.dart';
import 'package:provider/provider.dart';

class AuthorDetailesPage extends StatelessWidget {
  const AuthorDetailesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseDeailedProvider = Provider.of<CourseDetailedProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Author Detailes"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        child: ListView(padding: EdgeInsets.all(10), children: [
          KHeight15,
          CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 80,
              backgroundImage: NetworkImage(
                  "https://images.ctfassets.net/kvf8rpi09wgk/2FAVdt4PCl8SMmd6PFD9yR/69937dcdf4032e741307878928d3198f/Phil_Kulp_Headshot.jpg?w=400&q=50&h=400&fit=thumb")),
          KHeight15,
          Center(
            child: Text(
              courseDeailedProvider.courseDetailes!.data!.first.instructor!.name
                  .toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          KHeight5,
          Center(
            child: Text(
              courseDeailedProvider
                  .courseDetailes!.data!.first.instructor!.email
                  .toString(),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          KHeight5,
          Center(
            child: Text(
              courseDeailedProvider
                  .courseDetailes!.data!.first.instructor!.phone
                  .toString(),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          KHeight20,
          Text(
            courseDeailedProvider
                .courseDetailes!.data!.first.instructor!.details
                .toString(),
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
        ]),
      ),
    );
  }
}
