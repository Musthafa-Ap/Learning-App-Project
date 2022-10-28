import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nuox_project/pages/course_detailed_page/recomendations_services/recomendations_model.dart';

class RecomendationsProvider with ChangeNotifier {
  RecomendationsModel? recomendationsCourses;
  Future<void> getAll() async {
    var api = "http://learningapp.e8demo.com/api/recommended_courses/";
    Response response = await get(Uri.parse(api));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      recomendationsCourses = RecomendationsModel.fromJson(data);
      notifyListeners();
    }
  }
}
