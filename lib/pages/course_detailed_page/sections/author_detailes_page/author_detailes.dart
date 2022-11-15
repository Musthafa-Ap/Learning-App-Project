import 'package:flutter/material.dart';
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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text("Author Detailes"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        child: ListView(padding: const EdgeInsets.all(10), children: [
          kHeight15,
          const CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 80,
            backgroundImage: NetworkImage(
              "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg",
            ),
          ),
          kHeight15,
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
          kHeight5,
          Center(
            child: Text(
              courseDeailedProvider
                  .courseDetailes!.data!.first.instructor!.email
                  .toString(),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          kHeight5,
          Center(
            child: Text(
              courseDeailedProvider
                  .courseDetailes!.data!.first.instructor!.phone
                  .toString(),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          kHeight,
          const Divider(
            color: Colors.grey,
          ),
          kHeight,
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
