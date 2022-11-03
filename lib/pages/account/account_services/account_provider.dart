import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nuox_project/pages/account/account.dart';
import 'package:nuox_project/pages/account/account_services/faq_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountProvider with ChangeNotifier {
  bool isLoading = false;
  FAQModel? faqList;
  void getFAQ() async {
    var response = await http
        .get(Uri.parse("http://learningapp.e8demo.com/api/faq_list/"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      faqList = FAQModel.fromJson(data);
      notifyListeners();
    }
  }

  void editProfile(
      {required name,
      required email,
      required mobile,
      required gender,
      required dob,
      required address,
      context,
      File? image}) async {
    isLoading = true;
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? token = _shared.getString("access_token");
    String auth = "Bearer $token";
    try {
      var response = http.MultipartRequest(
        "PUT",
        Uri.parse("http://learningapp.e8demo.com/api/user-edit/"),
      );
      response.headers["Authorization"] = auth;
      response.fields['email'] = email;
      response.fields['mobile'] = mobile;
      response.fields['name'] = name;
      response.fields['gender'] = gender;
      response.fields['dob'] = dob;
      response.fields['address'] = address;
      if (image != null) {
        response.files
            .add(await http.MultipartFile.fromPath('profile_pic', image.path));
      }
      response.send().then((value) async {
        var data = await value.stream.toBytes();
        var body = String.fromCharCodes(data);
        Map<String, dynamic> msg = jsonDecode(body);
        if (msg.containsKey("non_field_errors")) {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(msg["non_field_errors"][0])));
        }
        if (msg["status_code"] == 200) {
          isLoading = false;
          SharedPreferences _shared = await SharedPreferences.getInstance();
          _shared.setString("name", name);
          _shared.setString("email", email);
          _shared.setString("number", mobile);
          _shared.setString("dob", dob);
          _shared.setString("address", address);
          _shared.setString("gender", gender);
          _shared.setString("image", msg['data']['profile_pic']);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green, content: Text(msg["status"])));
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => Account(),
            ),
            (route) => false,
          );
        }
        // print(msg["data"][0]);
        // print(msg["non_field_errors"][0]);
      });
    } catch (e) {
      isLoading = false;
      print(e.toString());
    }
  }
}
