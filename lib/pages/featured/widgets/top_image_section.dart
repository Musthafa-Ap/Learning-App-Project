import 'package:flutter/material.dart';

class TopImageSection extends StatelessWidget {
  const TopImageSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * .5,
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                "https://www.timeshighereducation.com/sites/default/files/styles/the_breaking_news_image_style/public/istock-1213470247_0.jpg?itok=VZUWOAHL",
              ))),
    );
  }
}
