import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/services/catagories_detailed_model.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/services/sub_catagoies_model.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/services/sub_catagories_detailed_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatagoriesDetailedProvider with ChangeNotifier {
  CatagoriesDetailedModel? catagoriesDetailes;
  SubCatagoriesModel? subCatagories;
  SubCatagoriesDetailedModel? subCatagoriesDetailes;
  bool isCatagoryDetailedLoading = false;
  Future<void> getAll({required catagoriesID}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    var token = shared.getString("access_token");
    isCatagoryDetailedLoading = true;
    Response response;
    // var api =
    //     "http://learningapp.e8demo.com/api/course_list/?cate_id=$catagoriesID";
    if (token == null) {
      response = await get(Uri.parse(
          "http://learningapp.e8demo.com/api/course_list/?cate_id=$catagoriesID"));
    } else {
      print("--------------------");
      response = await get(Uri.parse(
          "http://learningapp.e8demo.com/api/course_list/?cate_id=$catagoriesID&auth_token=$token"));
    }
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      catagoriesDetailes = CatagoriesDetailedModel.fromJson(data);
      isCatagoryDetailedLoading = false;
      notifyListeners();
    }
  }

  Future<void> getAllSub({required catagoriesID}) async {
    var api =
        "http://learningapp.e8demo.com/api/subcategory_list/?cate_id=$catagoriesID";
    Response response = await get(Uri.parse(api));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      subCatagories = SubCatagoriesModel.fromJson(data);
      notifyListeners();
    }
  }

  Future<void> getSubCatagoriesDetailes({required subCatagoriesID}) async {
    var api =
        "http://learningapp.e8demo.com/api/course_list/?sub_cate_id=$subCatagoriesID";
    Response response = await get(Uri.parse(api));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      subCatagoriesDetailes = SubCatagoriesDetailedModel.fromJson(data);
      notifyListeners();
    }
  }
}
