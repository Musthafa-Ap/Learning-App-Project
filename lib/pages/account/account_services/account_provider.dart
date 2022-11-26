import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nuox_project/my_home_page.dart';
import 'package:nuox_project/pages/account/account_services/about_app_model.dart';
import 'package:nuox_project/pages/account/account_services/faq_model.dart';
import 'package:nuox_project/pages/account/account_services/order_detailes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountProvider with ChangeNotifier {
  bool isDocumentUploadLoading = false;
  String? document;
  bool noOrders = false;
  OrderDetailesModel? orderDetailes;
  AboutAppModel? aboutApp;
  String? new_pass_error;
  String? old_pass_error;
  bool isLoading = false;
  bool isChangePassLoading = false;
  FAQModel? faqList;
  Future<bool> getFAQ() async {
    var response = await http
        .get(Uri.parse("http://learningapp.e8demo.com/api/faq_list/"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      faqList = FAQModel.fromJson(data);
      notifyListeners();
      return true;
    } else {
      return false;
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
    SharedPreferences shared = await SharedPreferences.getInstance();
    String? token = shared.getString("access_token");
    String auth = "Bearer $token";
    try {
      isLoading = true;
      var response = http.MultipartRequest(
        "PUT",
        Uri.parse("http://learningapp.e8demo.com/api/user-edit/"),
      );
      response.headers["Authorization"] = auth.toString();
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
        // print("value == ${value.stream}");
        var data = await value.stream.toBytes();
        var body = String.fromCharCodes(data);
        Map<String, dynamic> msg = jsonDecode(body);

        if (msg.containsKey("non_field_errors")) {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(milliseconds: 600),
              backgroundColor: Colors.red,
              content: Text(msg["non_field_errors"][0])));
          notifyListeners();
        }
        if (msg["status_code"] == 200) {
          isLoading = false;
          SharedPreferences shared = await SharedPreferences.getInstance();
          shared.setString("name", name);
          shared.setString("email", email);
          shared.setString("number", mobile);
          shared.setString("dob", dob);
          shared.setString("address", address);
          shared.setString("gender", gender);
          notifyListeners();
          if (image != null) {
            shared.setString("image", msg['data']['profile_pic'].toString());
          }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(milliseconds: 600),
              backgroundColor: Colors.green,
              content: Text(msg["status"])));

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ),
            (route) => false,
          );
          selectedIndex.value = 4;
        } else {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 600),
              backgroundColor: Colors.red,
              content: Text("Please select a image below 2 MB")));
          notifyListeners();
        }
      });
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
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
      SharedPreferences shared = await SharedPreferences.getInstance();
      String? token = shared.getString("access_token");
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
      if (data['result'] == "success") {
        isChangePassLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(milliseconds: 600),
            backgroundColor: Colors.green,
            content: Text(data["message"])));
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
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void report({required email, required problem, required context}) async {
    try {
      var response = await http.post(
          Uri.parse("http://learningapp.e8demo.com/api/report-issue/"),
          body: {"email": email, "report_issue": problem});
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(milliseconds: 600),
            backgroundColor: Colors.green,
            content: Text("Successfully submitted")));
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getOrderDetailes() async {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      String? token = shared.getString("access_token");
      String auth = "Bearer $token";
      var response = await http.get(
          Uri.parse("http://learningapp.e8demo.com/api/order_history/"),
          headers: {"Authorization": auth});
      if (response.statusCode == 200) {
        noOrders = false;
        var data = jsonDecode(response.body);
        orderDetailes = OrderDetailesModel.fromJson(data);
        notifyListeners();
      }
      if (response.statusCode == 400) {
        noOrders = true;
        notifyListeners();
      }
      if (response.statusCode == 401) {
        print("authentication problem");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getDocument() async {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      String? token = shared.getString("access_token");
      String auth = "Bearer $token";
      var response = await http.get(
          Uri.parse("http://learningapp.e8demo.com/api/instructor-document/"),
          headers: {"Authorization": auth});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        document = data['data'].first["instructor_docs"];
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> replaceDocument({required File? image, required context}) async {
    try {
      isDocumentUploadLoading = true;
      notifyListeners();
      SharedPreferences shared = await SharedPreferences.getInstance();
      String? token = shared.getString("access_token");
      String auth = "Bearer $token";
      var response = http.MultipartRequest(
        "PUT",
        Uri.parse("http://learningapp.e8demo.com/api/instructor-document/"),
      );
      response.headers["Authorization"] = auth.toString();
      if (image != null) {
        response.files.add(
            await http.MultipartFile.fromPath('instructor_docs', image.path));
      }
      response.send().then((value) async {
        var data = await value.stream.toBytes();
        var body = String.fromCharCodes(data);
        Map<String, dynamic> msg = jsonDecode(body);
        if (msg["status_code"] == 200) {
          document = msg['data']['instructor_docs'];
          isDocumentUploadLoading = false;
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 600),
              backgroundColor: Colors.green,
              content: Text(
                'Document replaced successfully',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )));
        }
        if (msg["status_code"] == 400) {
          isDocumentUploadLoading = false;
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 600),
              backgroundColor: Colors.green,
              content: Text(
                '"Only images files allowed"',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              )));
        }
      });
    } catch (e) {
      isDocumentUploadLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
