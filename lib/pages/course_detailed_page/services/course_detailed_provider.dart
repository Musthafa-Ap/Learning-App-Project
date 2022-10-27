import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_model.dart';

class CourseDetailedProvider with ChangeNotifier {
  CourseDetailedModel? courseDetailes;
  Future<void> getAll({required courseID}) async {
    var api =
        "http://learningapp.e8demo.com/api/user-coursedetail/?coursedetail_id=$courseID";
    Response response = await get(Uri.parse(api));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      courseDetailes = CourseDetailedModel.fromJson(data);
      notifyListeners();
    }
  }
}
