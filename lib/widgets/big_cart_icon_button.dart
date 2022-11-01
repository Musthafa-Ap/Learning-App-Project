import 'package:flutter/material.dart';
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_model.dart';
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BigCartIconButton extends StatelessWidget {
  final int id;
  final int price;
  const BigCartIconButton({
    Key? key,
    required this.id,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courseDetailedProvider = Provider.of<CourseDetailedProvider>(context);
    return Container(
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(5)),
        margin: const EdgeInsets.only(right: 20),
        height: 35,
        width: 70,
        child: IconButton(
            onPressed: () async {
              SharedPreferences _Sharedpref =
                  await SharedPreferences.getInstance();
              var token = _Sharedpref.getString("access_token");
              if (token != null) {
                courseDetailedProvider.addToCart(
                    courseID: id,
                    context: context,
                    variantID: 1,
                    price: price.toInt(),
                    token: token);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("Access token missing")));
              }
            },
            icon: Icon(
              Icons.shopping_bag,
              color: Colors.white,
              size: 35,
            )));
  }
}
