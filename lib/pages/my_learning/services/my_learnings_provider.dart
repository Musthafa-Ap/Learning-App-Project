import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:nuox_project/pages/my_learning/services/course_video_model.dart';
import 'package:nuox_project/pages/my_learning/services/my_learnings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../widgets/course_videos_page.dart';

class MyLearningsProvider with ChangeNotifier {
  MyLearningsModel? myLearningsList;
  CourseVideoModel? courseVideoList;
  bool isCourseLoading = false;
  bool isLoading = false;
  Future<void> getMyLearnings() async {
    try {
      isLoading = true;
      SharedPreferences shared = await SharedPreferences.getInstance();
      var token = shared.getString("access_token");
      String auth = "Bearer $token";
      var api = "http://learningapp.e8demo.com/api/my-courses/";
      var response = await http.get(
        Uri.parse(api),
        headers: {"Authorization": auth},
      );
      Map<String, dynamic> data = jsonDecode(response.body);
      myLearningsList = MyLearningsModel.fromJson(data);
      isLoading = false;
    } catch (e) {
      isLoading = false;
    }
  }

  Future<void> getCourseDetailes({required courseID, context}) async {
    try {
      isCourseLoading = true;
      SharedPreferences shared = await SharedPreferences.getInstance();
      var token = shared.getString("access_token");
      String auth = "Bearer $token";
      var api =
          "http://learningapp.e8demo.com/api/topic_list/?course_id=$courseID";
      var response = await http.get(
        Uri.parse(api),
        headers: {"Authorization": auth},
      );
      Map<String, dynamic> data = jsonDecode(response.body);
      courseVideoList = CourseVideoModel.fromJson(data);
      if (response.statusCode == 200) {
        isCourseLoading = false;
        if (context != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CourseVideosPage()));
        }
      } else {
        isCourseLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(milliseconds: 600),
            backgroundColor: Colors.red,
            content: Text(
              courseVideoList!.status.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            )));
        // print(courseVideoList!.status);
      }
    } catch (e) {
      isCourseLoading = false;
    }
  }

  Future<void> addWatchedDuration(
      {required courseId,
      required topicId,
      required String watchedDuration}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    var token = shared.getString("access_token");
    String auth = "Bearer $token";
    try {
      var response = await http.post(
          Uri.parse("http://learningapp.e8demo.com/api/topic_list/"),
          headers: {
            "Authorization": auth
          },
          body: {
            "courseid": courseId.toString(),
            "topicid": topicId.toString(),
            "watch_duration": watchedDuration
          });
    } catch (e) {
      print(e.toString());
    }
  }
}
