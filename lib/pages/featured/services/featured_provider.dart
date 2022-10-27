import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'featured_model.dart';

class FeaturedProvider with ChangeNotifier {
  List<Autogenerated?> auto = [];
  bool isLoading = false;
  Future<void> sample() async {
    isLoading = true;
    Response response = await get(
        Uri.parse("http://learningapp.e8demo.com/api/featured-course/"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      auto = (data['data'] as List)
          .map((e) => Autogenerated.fromJson(
                e,
              ))
          .toList();
      //print(auto[0]!.courseName);
      // print(auto.last!.introVideo);
    }
    isLoading = false;
    notifyListeners();
  }
}
