import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nuox_project/pages/course_detailed_page/recomendations_services/recomendations_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecomendationsProvider with ChangeNotifier {
  bool isRecLoading = false;
  RecomendationsModel? recomendationsCourses;
  Future<void> getAll() async {
    isRecLoading = true;
    SharedPreferences shared = await SharedPreferences.getInstance();
    Response response;
    String? token = shared.getString("access_token");

    if (token == null) {
      response = await get(
          Uri.parse("http://learningapp.e8demo.com/api/recommended_courses/"));
    } else {
      response = await get(Uri.parse(
          "http://learningapp.e8demo.com/api/recommended_courses/?auth_token=$token"));
    }
    if (response.statusCode == 200) {
      isRecLoading = false;
      var data = jsonDecode(response.body);
      recomendationsCourses = RecomendationsModel.fromJson(data);
      notifyListeners();
    } else {
      isRecLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> getAllRecFromCourse({required int courseId}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    Response response;
    String? token = shared.getString("access_token");

    if (token == null) {
      response = await get(Uri.parse(
          "http://learningapp.e8demo.com/api/recommended_courses/?course_id=$courseId"));
    } else {
      response = await get(Uri.parse(
          "http://learningapp.e8demo.com/api/recommended_courses/?course_id=$courseId&auth_token=$token"));
    }
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      recomendationsCourses = RecomendationsModel.fromJson(data);
      notifyListeners();
    }
  }

  Future<void> getAllRecFromCatagory({required int cataId}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    Response response;
    String? token = shared.getString("access_token");

    if (token == null) {
      response = await get(Uri.parse(
          "http://learningapp.e8demo.com/api/recommended_courses/?cate_id=$cataId"));
    } else {
      response = await get(Uri.parse(
          "http://learningapp.e8demo.com/api/recommended_courses/?cate_id=$cataId&auth_token=$token"));
    }

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      recomendationsCourses = RecomendationsModel.fromJson(data);
      notifyListeners();
    }
  }
}
