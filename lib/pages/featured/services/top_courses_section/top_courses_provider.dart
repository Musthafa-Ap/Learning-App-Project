import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nuox_project/pages/featured/sections/top_courses_section/top_courses_section.dart';
import 'package:nuox_project/pages/featured/services/top_courses_section/top_courses_model.dart';

class TopCoursesProvider with ChangeNotifier {
  TopCoursesModel? topCoursesList;
  Future<void> getAll() async {
    Response response = await get(
        Uri.parse("http://learningapp.e8demo.com/api/top_course_list/"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      topCoursesList = TopCoursesModel.fromJson(data);
      notifyListeners();
    }
  }
}
