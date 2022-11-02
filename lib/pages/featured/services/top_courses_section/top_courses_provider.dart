import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nuox_project/pages/featured/sections/top_courses_section/top_courses_section.dart';
import 'package:nuox_project/pages/featured/services/top_courses_section/banner_model.dart';
import 'package:nuox_project/pages/featured/services/top_courses_section/top_courses_model.dart';

class TopCoursesProvider with ChangeNotifier {
  BannerModel? banner;
  TopCoursesModel? topCoursesList;
  bool isLoading = false;
  Future<void> getAll() async {
    isLoading = true;
    Response response = await get(
        Uri.parse("http://learningapp.e8demo.com/api/top_course_list/"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      topCoursesList = TopCoursesModel.fromJson(data);
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> bannerList() async {
    Response response =
        await get(Uri.parse("http://learningapp.e8demo.com/api/banner/"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      banner = BannerModel.fromJson(data);
      notifyListeners();
      //  print(banner!.data!.first.bannerImg!.first.bannerImage!.fullSize);
    }
  }
}
