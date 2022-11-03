import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nuox_project/pages/cart/cart_services/cart_model.dart';
import 'package:nuox_project/pages/cart/cart_services/checkout_model.dart';
import 'package:nuox_project/pages/cart/cart_services/coupen_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../buy_all_page/buy_all_page.dart';

class CartProvider with ChangeNotifier {
  String? promo_code;
  bool isCoupenSuccess = false;
  bool isLoading = false;
  CartModel? cartItems;
  CheckoutModel? checkoutDetailes;
  CoupencodeModel? coupenDetailes;
  Future<void> getAllCartItems() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var token = _shared.getString("access_token");
    // print(token);
    String auth = "Bearer $token";
    var api = "http://learningapp.e8demo.com/api/add_to_cart/";
    var response = await http.get(
      Uri.parse(api),
      headers: {"Authorization": auth},
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      cartItems = CartModel.fromJson(data);

      notifyListeners();
    }
  }

  Future<void> deleteCartItem(
      {required courseID,
      required variantID,
      required BuildContext context}) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var token = _shared.getString("access_token");
    String auth = "Bearer $token";

    try {
      var response = await http.put(
          Uri.parse("http://learningapp.e8demo.com/api/add_to_cart/"),
          headers: {"Authorization": auth, "Content-Type": "application/json"},
          body: jsonEncode({"course": courseID, "section": variantID}));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("Item removed from Bag")));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getCheckout(context) async {
    isLoading = true;
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var token = _shared.getString("access_token");
    print(token);
    String auth = "Bearer $token";
    var api = "http://learningapp.e8demo.com/api/confirm_purchase/";
    var response = await http.get(
      Uri.parse(api),
      headers: {"Authorization": auth},
    );
    if (response.statusCode == 200) {
      isLoading = false;
      var data = jsonDecode(response.body);
      checkoutDetailes = CheckoutModel.fromJson(data);
      notifyListeners();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => BuyAllPage()));
      print(checkoutDetailes!.data!.paymentMethod.toString());
    }
  }

  void coupenApply({required String coupen, context}) async {
    isLoading = true;
    try {
      SharedPreferences _shared = await SharedPreferences.getInstance();
      var token = _shared.getString("access_token");
      String auth = "Bearer $token";
      var api = "http://learningapp.e8demo.com/api/apply_offer/";
      var response = await http.post(Uri.parse(api),
          headers: {"Authorization": auth}, body: {"promo_code": coupen});
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        promo_code = data["promo_code"];
        isLoading = false;
        coupenDetailes = CoupencodeModel.fromJson(data);
        isCoupenSuccess = true;
      } else {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              "Invalid coupen code",
              style: TextStyle(color: Colors.black),
            )));
      }
    } catch (e) {
      isLoading = false;
      print(e.toString());
    }
  }

  void chackOut({required String paymentMode, String? coupenCode}) {}
}
