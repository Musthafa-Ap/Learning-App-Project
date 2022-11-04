import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nuox_project/pages/account/account.dart';
import 'package:nuox_project/pages/account/account_services/about_app_model.dart';
import 'package:nuox_project/pages/account/account_services/faq_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountProvider with ChangeNotifier {
  AboutAppModel? aboutApp;
  String? new_pass_error;
  String? old_pass_error;
  bool isLoading = false;
  bool isChangePassLoading = false;
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
          if (image != null) {
            _shared.setString("image", msg['data']['profile_pic']);
          }
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

  void changePassword(
      {required oldPass,
      required newPass,
      required retypeNewPass,
      required context}) async {
    try {
      isChangePassLoading = true;
      new_pass_error = null;
      old_pass_error = null;
      notifyListeners();
      SharedPreferences _shared = await SharedPreferences.getInstance();
      String? token = _shared.getString("access_token");
      String auth = "Bearer $token";
      var response = await http.put(
          Uri.parse("http://learningapp.e8demo.com/api/change-password/"),
          headers: {
            "Authorization": auth
          },
          body: {
            'old_password': oldPass,
            'new_password': newPass,
            'retype_password': retypeNewPass
          });
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      if (data['result'] == "success") {
        isChangePassLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green, content: Text(data["message"])));
        Navigator.of(context).pop();
      }
      if (data['result'] == 'failure') {
        isChangePassLoading = false;
        if (data['message']['message'] == "Old password is not correct.") {
          old_pass_error = "Old password is not correct";
          notifyListeners();
        }
        if (data['message']['message'] ==
            "You used this password recently. Please choose a different one.") {
          isChangePassLoading = false;
          new_pass_error =
              "You used this password recently. Please choose a different one";
          notifyListeners();
        }
      }
      notifyListeners();
    } catch (e) {
      isChangePassLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }

  void getAboutApp() async {
    try {
      var response = await http
          .get(Uri.parse("http://learningapp.e8demo.com/api/about-app/"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        aboutApp = AboutAppModel.fromJson(data);
        print(aboutApp!.data!.first.aboutApp);
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
