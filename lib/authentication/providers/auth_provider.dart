import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nuox_project/authentication/moblie_number_otp_submission_page.dart';
import 'package:nuox_project/authentication/otp_verification_page.dart';
import 'package:nuox_project/authentication/registration_otp_submission_page.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login_page.dart';
import '../../my_home_page.dart';

class AuthProvider with ChangeNotifier {
  bool emailotpLoading = false;
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
      required String email,
      required String? image,
      bool mounted = true}) async {
    try {
      var response = await http.post(
          Uri.parse("http://learningapp.e8demo.com/api/social_login/"),
          body: {'email': email, 'name': name, 'user_social_id': id});
      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data['result'] == "success") {
          final sharedPrefs = await SharedPreferences.getInstance();
          notifyListeners();
          var token = data['token']['access_token'];
          var refreshToken = data['token']['refresh_token'].toString();
          await sharedPrefs.setString("refresh_token", refreshToken);
          await sharedPrefs.setBool("isLogged", true);
          await sharedPrefs.setBool('instructor', false);
          await sharedPrefs.setString("name", name);
          await sharedPrefs.setString("email", email);
          await sharedPrefs.setString("access_token", token);
          if (image != null) {
            await sharedPrefs.setString("image", image);
          }
          await sharedPrefs.setBool("changepass", false);
          notifyListeners();
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Successfully logged in',
                style: TextStyle(fontWeight: FontWeight.bold),
              )));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MyHomePage()),
              (route) => false);
        }
      }
      if (data["result"] == "failure") {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Your account blocked, please send enquiry to support",
              style: TextStyle(fontWeight: FontWeight.bold),
            )));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void numberOTPSubmission(
      {required number, required context, required otp}) async {
    try {
      setLoading(true);
      var response = await http.post(
          Uri.parse(
              "http://learningapp.e8demo.com/api/user-mobileotp/MobileNumberOtpVerification/"),
          body: {'mobile': number, 'otp': otp});
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == false) {
        setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              data['message'].toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            )));
      } else if (data.containsKey("token")) {
        bool instructor = data['is_instructor'];
        setLoading(false);
        var image = data['profile_pic'];
        String name = data["name"];
        String token = data['token']['access_token'];
        final sharedPrefs = await SharedPreferences.getInstance();
        await sharedPrefs.setBool('instructor', instructor);
        var email = data['email'];
        await sharedPrefs.setBool("isLogged", true);
        var refreshToken = data['token']['refresh_token'].toString();
        await sharedPrefs.setString("refresh_token", refreshToken);
        await sharedPrefs.setString("access_token", token);
        await sharedPrefs.setString("number", number);
        await sharedPrefs.setString("image", image);
        await sharedPrefs.setBool("changepass", false);
        await sharedPrefs.setString("email", email);
        await sharedPrefs.setString("name", name);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text('OTP submitted successfully')));
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MyHomePage()),
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
      if (data['status'] == 200) {
        setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green, content: Text(data['message'])));
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MobileNumberOTPSubmissionPage(
                  number: num,
                )));
      } else {
        setLoading(false);
        number_error = data['message'];
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              data['message'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            )));
      }
    } catch (e) {
      setLoading(false);
      print(e.toString());
    }
  }

  void emailOTPSubmission(
      {required otp, context, required email, required newPassword}) async {
    try {
      setLoading(true);
      var response = await http.post(
          Uri.parse(
              "http://learningapp.e8demo.com/api/user-forgotpassword/forgot_password_otp_verification/"),
          body: {'email': email, 'otp': otp, 'new_password': newPassword});
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == true) {
        setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green, content: Text(data['message'])));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } else if (data['status'] == false) {
        setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              data['message'],
              style: const TextStyle(fontWeight: FontWeight.bold),
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
              style: const TextStyle(fontWeight: FontWeight.bold),
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
      required String password,
      bool mounted = true}) async {
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

        if (data['result'] == "success") {
          bool instructor = data["is_instructor"];
          var mobile = data["mobile"];

          final sharedPrefs = await SharedPreferences.getInstance();
          var image = data['profile_pic'];
          String name = data["name"];
          //  await sharedPrefs!.clear();
          await sharedPrefs.setBool("isLogged", true);
          await sharedPrefs.setString("image", image);
          await sharedPrefs.setString("name", name);
          await sharedPrefs.setBool('instructor', instructor);
          await sharedPrefs.setString("number", mobile);
          await sharedPrefs.setString("email", email);
          var accessToken = data['token']['access_token'].toString();
          var refreshToken = data['token']['refresh_token'].toString();
          await sharedPrefs.setString("refresh_token", refreshToken);
          await sharedPrefs.setString("access_token", accessToken);

          await sharedPrefs.setBool("changepass", true);
          // await sharedPrefs.setString("name", '');

          notifyListeners();
          if (!mounted) return;
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MyHomePage()),
            (route) => false,
          );
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "Successfully logged in",
                style: TextStyle(fontWeight: FontWeight.bold),
              )));
          setLoading(false);
        } else if (data['result'] == "failure") {
          Map<String, dynamic> error = data['errors'];
          if (error.containsKey('email')) {
            login_email_error = error['email'];
            notifyListeners();
          } else {
            login_email_error = null;
            notifyListeners();
          }
          if (error.containsKey("message")) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  error["message"],
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
      print(response.body);
      if (data['status_code'] == 200) {
        email_error = null;
        mobile_error = null;

        setLoading(false);
        notifyListeners();
        final sharedPrefs = await SharedPreferences.getInstance();

        await sharedPrefs.setString("name", name);

        notifyListeners();

        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  RegistrationOTPSubmissionPage(email: email)),
        );
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
      print(e.toString());
    }
  }

  void registrationOTPSubmission(
      {required email,
      required otp,
      required context,
      bool instructor = false}) async {
    try {
      emailotpLoading = true;
      var response = await http.post(
          Uri.parse(
              "http://learningapp.e8demo.com/api/user-email-verification/"),
          body: {"email": email, "otp": otp});
      print(response.body);
      var data = jsonDecode(response.body);
      if (data["status"] == "failure") {
        emailotpLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              data["message"],
              style: const TextStyle(fontWeight: FontWeight.bold),
            )));
        print(data["message"]);
      }
      if (data['result'] == "success") {
        emailotpLoading = false;
        var mobile = data["mobile"];
        var email = data["email"];
        var token = data["token"]["access_token"];
        final sharedPrefs = await SharedPreferences.getInstance();
        await sharedPrefs.setString("email", email);
        if (instructor == true) {
          await sharedPrefs.setBool('instructor', true);
        } else {
          await sharedPrefs.setBool('instructor', false);
        }
        await sharedPrefs.setString("number", mobile);
        await sharedPrefs.setBool("changepass", true);
        await sharedPrefs.setBool("isLogged", true);
        var refreshToken = data['token']['refresh_token'].toString();
        await sharedPrefs.setString("refresh_token", refreshToken);
        await sharedPrefs.setString("access_token", token);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MyHomePage()),
            (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Successfully registered",
              style: TextStyle(fontWeight: FontWeight.bold),
            )));
      }
    } catch (e) {
      emailotpLoading = false;
      print(e.toString());
    }
  }

  void instructorRegistration(
      {required BuildContext context,
      required String email,
      required String number,
      required String name,
      required String password,
      required bool isInstructor,
      bool mounted = true,
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
        print(body);
        if (msg["status_code"] == 200) {
          email_error = null;
          mobile_error = null;
          setLoading(false);
          notifyListeners();
          final sharedPrefs = await SharedPreferences.getInstance();
          //   await sharedPrefs!.clear();
          await sharedPrefs.setString("name", name);
          notifyListeners();
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => RegistrationOTPSubmissionPage(
                      email: email,
                      instructor: true,
                    )),
          );
        } else if (msg["status_code"] == 400) {
          Map<String, dynamic> error_message = msg['message'];
          if (error_message.containsKey("email")) {
            email_error = "Email already exist";
            notifyListeners();
          } else {
            email_error = null;
            notifyListeners();
          }
          if (error_message.containsKey("non_field_errors")) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  "Only images and PDF files allowed",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )));
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
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      var token = shared.getString("access_token");
      String auth = "Bearer $token";
      var api = "http://learningapp.e8demo.com/api/logout/";
      var response = await http.get(
        Uri.parse(api),
        headers: {"Authorization": auth},
      );
      print(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Successfully logged out",
              style: TextStyle(fontWeight: FontWeight.bold),
            )));
        shared.clear();
        selectedIndex.value = 0;

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
            (route) => false);
      } else {
        print("status code oth400");
      }
      if (response.statusCode == 401) {
        SharedPreferences shared = await SharedPreferences.getInstance();
        var refreshToken = shared.getString("refresh_token");
        var responses = await http.get(
          Uri.parse(
              "http://learningapp.e8demo.com/api/refresh-token/?refresh_token=$refreshToken"),
        );
        if (responses.statusCode == 200) {
          Map<String, dynamic> datas = jsonDecode(responses.body);
          var access = datas["token"]["access_token"].toString();
          var refresh = datas["token"]["refresh_token"].toString();
          shared.setString("refresh_token", refresh);
          shared.setString("access_token", access);
          log("expired token is updated");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteAccount(context) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    String? token = shared.getString("access_token");
    String auth = "Bearer $token";
    var response = await http.delete(
        Uri.parse("http://learningapp.e8demo.com/api/delete-profile/"),
        headers: {"Authorization": auth});
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Account deleted",
            style: TextStyle(fontWeight: FontWeight.bold),
          )));
      selectedIndex.value = 0;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
    }
  }
}
