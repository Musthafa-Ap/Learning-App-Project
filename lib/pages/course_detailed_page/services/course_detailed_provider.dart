import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nuox_project/pages/course_detailed_page/sections/review_page/review_model.dart';
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_model.dart';
import 'package:nuox_project/pages/course_detailed_page/services/recently_viewed_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseDetailedProvider with ChangeNotifier {
  bool? isRecentEmpty;
  RecentlyViewedModel? recentlyViewedList;
  bool isReviewLoading = false;
  ReviewModel? getReviewList;
  CourseDetailedModel? courseDetailes;
  bool isCourseLoading = false;
  Future<void> getAll({required courseID}) async {
    isCourseLoading = true;
    SharedPreferences shared = await SharedPreferences.getInstance();
    var token = shared.getString("access_token");
    String auth = "Bearer $token";
    http.Response response;
    if (token == null) {
      response = await http.get(Uri.parse(
          "http://learningapp.e8demo.com/api/user-coursedetail/?coursedetail_id=$courseID"));
    } else {
      response = await http.get(
          Uri.parse(
              "http://learningapp.e8demo.com/api/user-coursedetail/?coursedetail_id=$courseID&auth_token=$token"),
          headers: {"Authorization": auth});
    }
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
      required String token,
      bool mounted = true}) async {
    try {
      String auth = "Bearer $token";
      var response = await http.post(
          Uri.parse("http://learningapp.e8demo.com/api/add_to_cart/"),
          headers: {"Authorization": auth, "Content-Type": "application/json"},
          body: jsonEncode(
              {"course": courseID, "variant": variantID, "price": price}));
      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Item added to the bag",
              style: TextStyle(fontWeight: FontWeight.bold),
            )));
      } else if (data["message"] == "Course is Already Purchased") {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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

  Future<void> getReview({required courseID}) async {
    try {
      isReviewLoading = true;
      SharedPreferences shared = await SharedPreferences.getInstance();
      var token = shared.getString("access_token");
      String auth = "Bearer $token";
      var api =
          "http://learningapp.e8demo.com/api/user-review/get_review/?course_id=$courseID";
      var response =
          await http.get(Uri.parse(api), headers: {"Authorization": auth});
      if (response.statusCode == 200) {
        isReviewLoading = false;
        var data = jsonDecode(response.body);
        getReviewList = ReviewModel.fromJson(data);
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      isReviewLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }

  Future<void> addRatingWithoutReview(
      {required rating, required id, required context}) async {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      var token = shared.getString("access_token");
      String auth = "Bearer $token";
      var api = "http://learningapp.e8demo.com/api/user-review/add_review/";
      var response = await http.post(Uri.parse(api),
          headers: {"Authorization": auth},
          body: {"rating": rating.toString(), "course_id": id.toString()});
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data["status_code"] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Rating added successfully",
              style: TextStyle(color: Colors.white),
            )));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addRatingWithReview(
      {required rating, required id, required context, required review}) async {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      var token = shared.getString("access_token");
      String auth = "Bearer $token";
      var api = "http://learningapp.e8demo.com/api/user-review/add_review/";
      var response = await http.post(Uri.parse(api), headers: {
        "Authorization": auth
      }, body: {
        "rating": rating.toString(),
        "course_id": id.toString(),
        "review": review
      });
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data["status_code"] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Review added successfully",
              style: TextStyle(color: Colors.white),
            )));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getRecentlyViewed() async {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      var token = shared.getString("access_token");
      String auth = "Bearer $token";
      var response = await http.get(
          Uri.parse(
              "http://learningapp.e8demo.com/api/recent-courses/?auth_token=$token"),
          headers: {"Authorization": auth});

      var data = jsonDecode(response.body);

      notifyListeners();
      if (response.statusCode == 200) {
        recentlyViewedList = RecentlyViewedModel.fromJson(data);
      } else {
        isRecentEmpty = true;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
