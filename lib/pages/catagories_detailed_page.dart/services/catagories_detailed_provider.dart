import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/services/catagories_detailed_model.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/services/sub_catagoies_model.dart';

class CatagoriesDetailedProvider with ChangeNotifier {
  CatagoriesDetailedModel? catagoriesDetailes;
  SubCatagoriesModel? subCatagories;
  Future<void> getAll({required catagoriesID}) async {
    var api =
        "http://learningapp.e8demo.com/api/course_list/?cate_id=$catagoriesID";
    Response response = await get(Uri.parse(api));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      catagoriesDetailes = CatagoriesDetailedModel.fromJson(data);
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
}
