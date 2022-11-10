import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../constants/constants.dart';
import '../../../../widgets/bestseller.dart';

class WhichlistPage extends StatelessWidget {
  const WhichlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text("My Whishlist"),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) {
          return Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              height: size * .425,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: size * .192,
                      width: size * .192,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "http://learningapp.e8demo.com/media/thumbnail_img/5-chemistry.jpeg"))),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Course name",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            kHeight5,
                            Text(
                              "Author name",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[300]),
                            ),
                            kHeight5,
                            Row(
                              children: [
                                const Text(
                                  "4",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.yellow),
                                ),
                                RatingBarIndicator(
                                  unratedColor: Colors.grey,
                                  rating: 4,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  itemCount: 5,
                                  itemSize: 10.0,
                                  direction: Axis.horizontal,
                                ),
                                const Text(
                                  " (3500)",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.yellow),
                                ),
                              ],
                            ),
                            kHeight5,
                            const Text(
                              "₹200",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const BestsellerWidget(),
                                IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  onPressed: () {},
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
