import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nuox_project/pages/featured/services/top_courses_section/banner_model.dart';
import 'package:nuox_project/pages/featured/services/top_courses_section/top_courses_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopCoursesProvider with ChangeNotifier {
  BannerModel? banner;
  TopCoursesModel? topCoursesList;
  bool isLoading = false;
  Future<void> getAll() async {
    isLoading = true;
    SharedPreferences shared = await SharedPreferences.getInstance();
    Response response;
    String? token = shared.getString("access_token");
    if (token == null) {
      response = await get(
          Uri.parse("http://learningapp.e8demo.com/api/top_course_list/"));
    } else {
      response = await get(Uri.parse(
          "http://learningapp.e8demo.com/api/top_course_list/?auth_token=$token"));
    }
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
    }
  }
}
