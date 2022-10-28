import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuox_project/authentication/providers/auth_provider.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sections/featured_section/featured_section.dart';
import 'widgets/top_image_section.dart';
import 'widgets/top_text_section.dart';

class Featured extends StatefulWidget {
  Featured({super.key});

  @override
  State<Featured> createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  @override
  void initState() {
    preffunc();
    super.initState();
  }

  var username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarBrightness: Brightness.light),
            automaticallyImplyLeading: false,
            title: username == null
                ? Text("Welcome,")
                : Text("Welcome ${username},")),
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            TopImageSection(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [TopTextSection(), FeaturedSection()],
            )
          ],
        ));
  }

  void preffunc() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPref.getString("name");
    });
  }
}
