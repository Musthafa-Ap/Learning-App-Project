import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nuox_project/authentication/moblie_number_otp_submission_page.dart';
import 'package:nuox_project/authentication/otp_verification_page.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authentication/login_page.dart';
import '../my_home_page.dart';

class AuthProvider with ChangeNotifier {
  var mobile_error;
  var email_error;
  var name_error;
  var login_email_error;
  var login_pass_error;

  bool isLoading = false;
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void numberOTPSubmission(
      {required number, required context, required OTP}) async {
    try {
      print("1");
      Response response = await post(
          Uri.parse(
              "http://learningapp.e8demo.com/api/user-mobileotp/MobileNumberOtpVerification/"),
          body: {'mobile': number, 'otp': OTP});
      print("2");
      Map<String, dynamic> data = jsonDecode(response.body);

      print(data.toString());
      if (data['status'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(data['message'].toString())));
      } else if (data.containsKey("token")) {
        //   Map<String, dynamic> checking = data['token'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text('OTP submitted successfully')));
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MyHomePage()),
          (route) => false,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void numberVerification({required number, required context}) async {
    String num = countryCode + number;
    try {
      Response response = await post(
          Uri.parse(
              "http://learningapp.e8demo.com/api/user-mobileotp/MobileNumberOtp/"),
          body: {'mobile': num});
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data.toString());
      if (data['status'] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green, content: Text(data['message'])));
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MobileNumberOTPSubmissionPage(
                  number: num,
                )));
      } else if (data['status_code' == 400]) {
        print(data['message']);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red, content: Text(data['message'])));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void EmailOTPSubmission(
      {required OTP, context, required email, required newPassword}) async {
    try {
      Response response = await post(
          Uri.parse(
              "http://learningapp.e8demo.com/api/user-forgotpassword/forgot_password_otp_verification/"),
          body: {'email': email, 'otp': OTP, 'new_password': newPassword});
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green, content: Text(data['message'])));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      } else if (data['status'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red, content: Text(data['message'])));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void forgotPassword({required emailforOTP, context}) async {
    try {
      Response response = await post(
          Uri.parse(
              "http://learningapp.e8demo.com/api/user-forgotpassword/forgot_password_otp/"),
          body: {'email': emailforOTP});
      Map<String, dynamic> data = jsonDecode(response.body);

      if (data['status'] == 200) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OTPVerificationPage(
                  mailid: emailforOTP,
                )));
      } else if (data['status'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red, content: Text(data['message'])));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    setLoading(true);
    try {
      Response response = await post(
          Uri.parse("http://learningapp.e8demo.com/api/user-login/"),
          body: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        login_email_error = null;
        login_pass_error = null;
        var data = jsonDecode(response.body);
        print(data['result'].toString());

        if (data['result'] == "success") {
          final sharedPrefs = await SharedPreferences.getInstance();
          await sharedPrefs.setBool("isLogged", true);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MyHomePage()),
            (route) => false,
          );
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green, content: Text(data['result'])));
          setLoading(false);
        } else if (data['result'] == "failure") {
          print(data.toString());
          Map<String, dynamic> error = data['errors'];
          if (error.containsKey('email')) {
            login_email_error = error['email'];
          } else {
            login_email_error = null;
          }
          if (error.containsKey('password')) {
            login_pass_error = error['password'];
          } else {
            login_pass_error = null;
          }

          setLoading(false);
        }
      } else {
        print("failed");
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      print(e.toString());
    }
  }

  void registration(
      {required BuildContext context,
      required String email,
      required String number,
      required String name,
      required String password}) async {
    String num = countryCode + number;

    setLoading(true);
    try {
      Response response = await post(
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
        final sharedPrefs = await SharedPreferences.getInstance();
        await sharedPrefs.clear();
        await sharedPrefs.setBool("isLogged", true);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("User created successfully")));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MyHomePage()),
            (route) => false);
      } else if (data['status_code'] == 400) {
        Map<String, dynamic> error_message = data['message'];

        if (error_message.containsKey("email")) {
          email_error = "Email already exist";
        } else {
          email_error = null;
        }

        if (error_message.containsKey("mobile")) {
          mobile_error = "Mobile number already exist";
        } else {
          mobile_error = null;
        }
        if (error_message.containsKey('name')) {
          name_error = error_message['name'];
        }
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      print(e.toString());
    }
  }
}
