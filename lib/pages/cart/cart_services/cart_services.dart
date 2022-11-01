import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nuox_project/pages/cart/cart_services/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  CartModel? cartItems;
  Future<void> getAllCartItems() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var token = _shared.getString("access_token");
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
    print(token);
    try {
      var response = await http.put(
          Uri.parse("http://learningapp.e8demo.com/api/add_to_cart/"),
          headers: {"Authorization": auth, "Content-Type": "application/json"},
          body: jsonEncode({"course": courseID, "section": variantID}));
      print(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("Item removed from Bag")));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
