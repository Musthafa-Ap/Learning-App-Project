import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nuox_project/pages/course_detailed_page/recomendations_services/recomendations_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecomendationsProvider with ChangeNotifier {
  RecomendationsModel? recomendationsCourses;
  Future<void> getAll() async {
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
      var data = jsonDecode(response.body);
      recomendationsCourses = RecomendationsModel.fromJson(data);
      notifyListeners();
    }
  }
}
