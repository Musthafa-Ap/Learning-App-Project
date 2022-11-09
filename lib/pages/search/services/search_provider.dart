import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nuox_project/pages/search/services/search_model.dart';
import 'package:http/http.dart' as http;

class SearchProvider with ChangeNotifier {
  String? notFound;
  SearchModel? searchList;
  void getSearchItems({required String key}) async {
    try {
      notFound = null;
      searchList = null;
      var response = await http.get(
        Uri.parse(
            "http://learningapp.e8demo.com/api/course_search/?search_key=$key"),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        searchList = SearchModel.fromJson(data);
        notifyListeners();
      } else {
        searchList = null;
        notFound = "Course not found";
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
