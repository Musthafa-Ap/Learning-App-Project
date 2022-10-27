import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:nuox_project/pages/featured/services/catagories_section/catagories_model.dart';

class CatagoriesProvider with ChangeNotifier {
  CatagoriesModel? catagoriesList;
  Future<void> getAll() async {
    Response response = await get(
        Uri.parse("http://learningapp.e8demo.com/api/category_list/"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      catagoriesList = CatagoriesModel.fromJson(data);
      notifyListeners();
      //print(catagoriesList!.data![1].categoryName);
    }
  }
}
