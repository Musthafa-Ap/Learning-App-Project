import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TopImageSection extends StatefulWidget {
  TopImageSection({
    Key? key,
  }) : super(key: key);

  @override
  State<TopImageSection> createState() => _TopImageSectionState();
}

class _TopImageSectionState extends State<TopImageSection> {
  List _images = [
    "https://www.timeshighereducation.com/sites/default/files/styles/the_breaking_news_image_style/public/istock-1213470247_0.jpg?itok=VZUWOAHL",
    "http://learningapp.e8demo.com/media/thumbnail_img/5-chemistry.jpeg",
    "http://learningapp.e8demo.com/media/thumbnail_img/4-physics.jpeg"
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.width * .5,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            CarouselSlider(
                items: _images
                    .map((items) => Image.network(
                          items,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    autoPlay: true,
                    aspectRatio: 2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _images.map((url) {
                int index = _images.indexOf(url);
                return Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.purple : Colors.grey,
                  ),
                );
              }).toList(),
            )
          ],
        )
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //         fit: BoxFit.cover,
        //         image: NetworkImage(
        //           "https://www.timeshighereducation.com/sites/default/files/styles/the_breaking_news_image_style/public/istock-1213470247_0.jpg?itok=VZUWOAHL",
        //         ))),
        );
  }
}
