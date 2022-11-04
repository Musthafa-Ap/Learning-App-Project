import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nuox_project/authentication/moblie_number_otp_submission_page.dart';
import 'package:nuox_project/authentication/otp_verification_page.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login_page.dart';
import '../../my_home_page.dart';
import '../../pages/featured/services/featured_section/featured_model.dart';

class AuthProvider with ChangeNotifier {
  var mobile_error;
  var email_error;
  var name_error;
  var login_email_error;
  var login_pass_error;
  var number_error;

  bool isLoading = false;
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void socialLogin(
      {required String name,
      required BuildContext context,
      required String id,
      required String email}) async {
    try {
      var response = await http.post(
          Uri.parse("http://learningapp.e8demo.com/api/social_login/"),
          body: {'email': email, 'name': name, 'user_social_id': id});

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data['result'] == "success") {
          final sharedPrefs = await SharedPreferences.getInstance();
          notifyListeners();
          var token = data['token']['access_token'];
          await sharedPrefs.setBool("isLogged", true);
          await sharedPrefs.setString("name", name);
          await sharedPrefs.setString("email", email);
          await sharedPrefs.setString("access_token", token);
          await sharedPrefs.setBool("changepass", false);
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Successfully logged in',
                style: TextStyle(fontWeight: FontWeight.bold),
              )));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MyHomePage()),
              (route) => false);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void numberOTPSubmission(
      {required number, required context, required OTP}) async {
    try {
      setLoading(true);
      var response = await http.post(
          Uri.parse(
              "http://learningapp.e8demo.com/api/user-mobileotp/MobileNumberOtpVerification/"),
          body: {'mobile': number, 'otp': OTP});

      Map<String, dynamic> data = jsonDecode(response.body);
      print("datas=$data");
      if (data['status'] == false) {
        setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              data['message'].toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            )));
      } else if (data.containsKey("token")) {
        setLoading(false);
        String token = data['token']['access_token'];
        final sharedPrefs = await SharedPreferences.getInstance();
        //  await sharedPrefs!.clear();
        await sharedPrefs.setBool("isLogged", true);
        await sharedPrefs.setString("access_token", token);
        await sharedPrefs.setString("number", number);
        await sharedPrefs.setBool("changepass", false);
        print("token=$token");
        //  <String, dynamic> checking = data['token'];

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text('OTP submitted successfully')));
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MyHomePage()),
          (route) => false,
        );
      }
    } catch (e) {
      setLoading(false);
      print(e.toString());
    }
  }

  void numberVerification({required number, required context}) async {
    String num = countryCode + number;
    try {
      number_error = null;
      setLoading(true);
      var response = await http.post(
          Uri.parse(
              "http://learningapp.e8demo.com/api/user-mobileotp/MobileNumberOtp/"),
          body: {'mobile': num});
      Map<String, dynamic> data = jsonDecode(response.body);
      //  print(data.toString());
      if (data['status'] == 200) {
        setLoading(false);
        //  print("datas = $data");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green, content: Text(data['message'])));
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MobileNumberOTPSubmissionPage(
                  number: num,
                )));
      } else {
        setLoading(false);
        //  print(data['message']);
        number_error = data['message'];
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              data['message'],
              style: TextStyle(fontWeight: FontWeight.bold),
            )));
      }
    } catch (e) {
      setLoading(false);
      print(e.toString());
    }
  }

  void EmailOTPSubmission(
      {required OTP, context, required email, required newPassword}) async {
    try {
      setLoading(true);
      var response = await http.post(
          Uri.parse(
              "http://learningapp.e8demo.com/api/user-forgotpassword/forgot_password_otp_verification/"),
          body: {'email': email, 'otp': OTP, 'new_password': newPassword});
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == true) {
        setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green, content: Text(data['message'])));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      } else if (data['status'] == false) {
        setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              data['message'],
              style: TextStyle(fontWeight: FontWeight.bold),
            )));
      }
    } catch (e) {
      setLoading(false);
      print(e.toString());
    }
  }

  void forgotPassword({required emailforOTP, context}) async {
    try {
      setLoading(true);
      var response = await http.post(
          Uri.parse(
              "http://learningapp.e8demo.com/api/user-forgotpassword/forgot_password_otp/"),
          body: {'email': emailforOTP});
      Map<String, dynamic> data = jsonDecode(response.body);

      if (data['status'] == 200) {
        setLoading(false);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OTPVerificationPage(
                  mailid: emailforOTP,
                )));
      } else if (data['status'] == false) {
        setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              data['message'],
              style: TextStyle(fontWeight: FontWeight.bold),
            )));
      }
    } catch (e) {
      setLoading(false);
      print(e.toString());
    }
  }

  void login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    setLoading(true);
    try {
      login_email_error = null;
      login_pass_error = null;
      var response = await http.post(
          Uri.parse("http://learningapp.e8demo.com/api/user-login/"),
          body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        login_email_error = null;
        login_pass_error = null;
        notifyListeners();
        var data = jsonDecode(response.body);
        print(data);
        if (data['result'] == "success") {
          final sharedPrefs = await SharedPreferences.getInstance();
          //  await sharedPrefs!.clear();
          await sharedPrefs.setBool("isLogged", true);
          await sharedPrefs.setString("email", email);
          var accessToken = data['token']['access_token'].toString();
          await sharedPrefs.setString("access_token", accessToken);
          await sharedPrefs.setBool("changepass", true);
          print("Acess_token");
          // print(accessToken);
          notifyListeners();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MyHomePage()),
            (route) => false,
          );
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "Successfully logged in",
                style: TextStyle(fontWeight: FontWeight.bold),
              )));
          setLoading(false);
        } else if (data['result'] == "failure") {
          Map<String, dynamic> error = data['errors'];
          print(error);
          if (error.containsKey('email')) {
            login_email_error = error['email'];
            notifyListeners();
          } else {
            login_email_error = null;
            notifyListeners();
          }
          if (error.containsKey("message")) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  error["message"],
                  style: TextStyle(fontWeight: FontWeight.bold),
                )));
          }
          if (error.containsKey('password')) {
            login_pass_error = error['password'];
            notifyListeners();
          } else {
            login_pass_error = null;
            notifyListeners();
          }
          notifyListeners();
          setLoading(false);
          notifyListeners();
        }
      } else {
        print("failed");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "check your password",
              style: TextStyle(fontWeight: FontWeight.bold),
            )));
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      print(e.toString());
    }
  }

  void registration({
    required BuildContext context,
    required String email,
    required String number,
    required String name,
    required String password,
  }) async {
    String num = countryCode + number;

    setLoading(true);
    try {
      email_error = null;
      mobile_error = null;
      var response = await http.post(
          Uri.parse("http://learningapp.e8demo.com/api/user-register/"),
          body: {
            'email': email,
            'mobile': num,
            'password': password,
            'name': name,
          });
      var data = jsonDecode(response.body);
      if (data['status_code'] == 200) {
        email_error = null;
        mobile_error = null;

        setLoading(false);
        notifyListeners();
        final sharedPrefs = await SharedPreferences.getInstance();
        await sharedPrefs.setBool("isLogged", true);
        var accessToken = data["token"]["access_token"];
        await sharedPrefs.setString("name", name);
        await sharedPrefs.setString("email", email);
        await sharedPrefs.setString("access_token", accessToken);
        await sharedPrefs.setString("number", num);
        await sharedPrefs.setBool("changepass", true);
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "User created successfully",
              style: TextStyle(fontWeight: FontWeight.bold),
            )));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MyHomePage()),
            (route) => false);
      } else if (data['status_code'] == 400) {
        setLoading(false);
        Map<String, dynamic> error_message = data['message'];

        if (error_message.containsKey("email")) {
          email_error = "Email already exist";
          notifyListeners();
        } else {
          email_error = null;
          notifyListeners();
        }

        if (error_message.containsKey("mobile")) {
          mobile_error = "Mobile number already exist";
          notifyListeners();
        } else {
          mobile_error = null;
          notifyListeners();
        }
        if (error_message.containsKey('name')) {
          name_error = error_message['name'];
          notifyListeners();
        }
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      print("Some error");
      print(e.toString());
    }
  }

  instructorRegistration(
      {required BuildContext context,
      required String email,
      required String number,
      required String name,
      required String password,
      required bool isInstructor,
      File? document}) async {
    String num = countryCode + number;

    setLoading(true);
    try {
      email_error = null;
      mobile_error = null;
      var response = http.MultipartRequest(
        "POST",
        Uri.parse("http://learningapp.e8demo.com/api/user-register/"),
      );
      response.fields['email'] = email;
      response.fields['mobile'] = num;
      response.fields['password'] = password;
      response.fields['name'] = name;
      response.fields['is_instructor'] = isInstructor.toString();
      response.files.add(await http.MultipartFile.fromPath(
        "instructor_docs",
        document!.path,
      ));

      response.send().then((value) async {
        setLoading(false);
        var data = await value.stream.toBytes();
        var body = String.fromCharCodes(data);
        var msg = jsonDecode(body);
        var token = msg['token']['access_token'];
        if (msg["status_code"] == 200) {
          email_error = null;
          mobile_error = null;

          setLoading(false);
          notifyListeners();
          final sharedPrefs = await SharedPreferences.getInstance();
          //   await sharedPrefs!.clear();
          await sharedPrefs.setBool("isLogged", true);
          await sharedPrefs.setString("name", name);
          await sharedPrefs.setString("email", email);
          await sharedPrefs.setString("access_token", token);
          await sharedPrefs.setString("number", num);
          await sharedPrefs.setBool("changepass", true);
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "User created successfully",
                style: TextStyle(fontWeight: FontWeight.bold),
              )));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MyHomePage()),
              (route) => false);
        } else if (msg["status_code"] == 400) {
          Map<String, dynamic> error_message = msg['message'];
          if (error_message.containsKey("email")) {
            email_error = "Email already exist";
            notifyListeners();
          } else {
            email_error = null;
            notifyListeners();
          }

          if (error_message.containsKey("mobile")) {
            mobile_error = "Mobile number already exist";
            notifyListeners();
          } else {
            mobile_error = null;
            notifyListeners();
          }
          if (error_message.containsKey('name')) {
            name_error = error_message['name'];
            notifyListeners();
          }
          setLoading(false);
        }
      });
    } catch (e) {
      setLoading(false);
      print(e.toString());
    }
  }

  void logOut(context) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var token = _shared.getString("access_token");
    String auth = "Bearer $token";
    var api = "http://learningapp.e8demo.com/api/logout/";
    var response = await http.get(
      Uri.parse(api),
      headers: {"Authorization": auth},
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Successfully logged out",
            style: TextStyle(fontWeight: FontWeight.bold),
          )));
      _shared.clear();
      selectedIndex.value = 0;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
          (route) => false);
    } else {
      print("status code oth400");
    }
  }

  void deleteAccount(context) async {
    print("entered");
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? token = _shared.getString("access_token");
    String auth = "Bearer $token";
    var response = await http.delete(
        Uri.parse("http://learningapp.e8demo.com/api/delete-profile/"),
        headers: {"Authorization": auth});
    print(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Account deleted",
            style: TextStyle(fontWeight: FontWeight.bold),
          )));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false);
    }
  }
}
