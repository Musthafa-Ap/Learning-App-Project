import 'package:flutter/material.dart';
import 'package:nuox_project/pages/account/sections/profile/profile_edit_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/constants.dart';

class UserDetailesSection extends StatefulWidget {
  const UserDetailesSection({super.key});

  @override
  State<UserDetailesSection> createState() => _UserDetailesSectionState();
}

class _UserDetailesSectionState extends State<UserDetailesSection> {
  @override
  void initState() {
    preffunc();
    super.initState();
  }

  String? name;
  String? email;
  String? image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfileEditPage()));
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              )),
        ),
        Stack(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const ProfileEditPage()));
                },
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 50,
                  backgroundImage: NetworkImage(image == null
                      ? "https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg"
                      : image!),
                )),
          ],
        ),
        kheight20,
        Center(
          child: Text(
            name == null || name!.isEmpty ? "Username" : name.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 23),
          ),
        ),
        kHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.mail_outline,
              color: Colors.white,
            ),
            kWidth5,
            Text(
              email == null ? "E-mail" : email.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        kHeight,
        Container(
          height: 20,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Colors.purple,
          ),
          child: const Center(
              child: Text(
            "Instructor",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1),
          )),
        ),
      ],
    );
  }

  void preffunc() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPref.getString("name");
      email = sharedPref.getString("email");
      image = sharedPref.getString("image");
    });
  }
}
