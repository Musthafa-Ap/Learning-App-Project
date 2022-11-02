import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/services/catagories_detailed_model.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/services/sub_catagoies_model.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/services/sub_catagories_detailed_model.dart';

class CatagoriesDetailedProvider with ChangeNotifier {
  CatagoriesDetailedModel? catagoriesDetailes;
  SubCatagoriesModel? subCatagories;
  SubCatagoriesDetailedModel? subCatagoriesDetailes;
  bool isCatagoryDetailedLoading = false;
  Future<void> getAll({required catagoriesID}) async {
    print("get all entered");
    isCatagoryDetailedLoading = true;
    var api =
        "http://learningapp.e8demo.com/api/course_list/?cate_id=$catagoriesID";
    Response response = await get(Uri.parse(api));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      catagoriesDetailes = CatagoriesDetailedModel.fromJson(data);
      isCatagoryDetailedLoading = false;
      print(data);
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
      // print(subCatagories!.data!.length.toString());
    }
  }

  Future<void> getSubCatagoriesDetailes({required subCatagoriesID}) async {
    var api =
        "http://learningapp.e8demo.com/api/course_list/?sub_cate_id=$subCatagoriesID";
    Response response = await get(Uri.parse(api));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //  print("hello ${data}");
      subCatagoriesDetailes = SubCatagoriesDetailedModel.fromJson(data);
      //  print(subCatagoriesDetailes!.data!.length.toString());
      notifyListeners();
    }
  }
}
