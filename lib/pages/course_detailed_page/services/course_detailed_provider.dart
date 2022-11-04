import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nuox_project/pages/course_detailed_page/sections/review_page/review_model.dart';
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseDetailedProvider with ChangeNotifier {
  bool isReviewLoading = false;
  ReviewModel? getReviewList;
  CourseDetailedModel? courseDetailes;
  bool isCourseLoading = false;
  Future<void> getAll({required courseID}) async {
    isCourseLoading = true;
    var api =
        "http://learningapp.e8demo.com/api/user-coursedetail/?coursedetail_id=$courseID";
    var response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      courseDetailes = CourseDetailedModel.fromJson(data);
      isCourseLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToCart(
      {required int courseID,
      required BuildContext context,
      required int variantID,
      required int price,
      required String token}) async {
    try {
      String auth = "Bearer $token";
      var response = await http.post(
          Uri.parse("http://learningapp.e8demo.com/api/add_to_cart/"),
          headers: {"Authorization": auth, "Content-Type": "application/json"},
          body: jsonEncode(
              {"course": courseID, "variant": variantID, "price": price}));
      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Item added to the bag",
              style: TextStyle(fontWeight: FontWeight.bold),
            )));
        print("Add to cart successfully");
      } else if (data["message"] == "Course is Already Purchased") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              "Course is already purchased",
              style: TextStyle(color: Colors.black),
            )));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getReview({required courseID}) async {
    try {
      isReviewLoading = true;
      SharedPreferences _shared = await SharedPreferences.getInstance();
      var token = _shared.getString("access_token");
      String auth = "Bearer $token";
      var api =
          "http://learningapp.e8demo.com/api/user-review/get_review/?course_id=$courseID";
      var response =
          await http.get(Uri.parse(api), headers: {"Authorization": auth});
      if (response.statusCode == 200) {
        isReviewLoading = false;
        var data = jsonDecode(response.body);
        getReviewList = ReviewModel.fromJson(data);
        print(getReviewList!.data!.first.review);
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      isReviewLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
