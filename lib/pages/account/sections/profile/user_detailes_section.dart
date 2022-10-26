import 'package:flutter/material.dart';
import 'package:nuox_project/pages/account/sections/profile/profile_edit_page.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../constants/constants.dart';

class UserDetailesSection extends StatelessWidget {
  UserDetailesSection({super.key});
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfileEditPage()));
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              )),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 50,
          child: Text(
            "MA",
            style: const TextStyle(fontSize: 38, color: Colors.black),
          ),
        ),
        KHeight20,
        Center(
          child: Text(
            "Mohammed Musthafa AP",
            style: const TextStyle(color: Colors.white, fontSize: 23),
          ),
        ),
        KHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mail_outline,
              color: Colors.white,
            ),
            KWidth5,
            Text(
              "Musthafamohammed398@gmail.com",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ],
    );
  }
}
