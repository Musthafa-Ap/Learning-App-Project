import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_model.dart';

class CourseDetailedProvider with ChangeNotifier {
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
      print("entrered");
      String auth = "Bearer $token";
      var response = await http.post(
          Uri.parse("http://learningapp.e8demo.com/api/add_to_cart/"),
          headers: {"Authorization": auth, "Content-Type": "application/json"},
          body: jsonEncode(
              {"course": courseID, "variant": variantID, "price": price}));
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("Item added to the bag")));
        print("Add to cart successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
