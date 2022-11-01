import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/pages/cart/cart_services/cart_services.dart';
import 'package:nuox_project/pages/course_detailed_page/recomendations_services/recomendations_provider.dart';
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_provider.dart';
import 'package:nuox_project/pages/review_page/review_page.dart';
import 'package:nuox_project/widgets/bestseller.dart';
import 'package:nuox_project/widgets/bold_heading.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/course_detailes_list_tile.dart';

class CourseDetailedPage extends StatelessWidget {
  CourseDetailedPage({super.key});

  ValueNotifier _selectedValue = ValueNotifier("Beginner");

  var _items = ["Beginner", "Intermediate", "Expert"];

  @override
  Widget build(BuildContext context) {
    final courseDeailedProvider = Provider.of<CourseDetailedProvider>(context);
    final recomendationsProvider = Provider.of<RecomendationsProvider>(context);
    // final cartProvider = Provider.of<CartProvider>(context);
    //  bool alreadyAdded = false;
    var size = MediaQuery.of(context).size.width;
    int variant = 1;
    int? expert_price;
    int? inter_price;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Featured"),
        actions: [
          KWidth5,
          IconButton(
              onPressed: () async {
                await Share.share(
                    "https://i.guim.co.uk/img/media/71dd7c5b208e464995de3467caf9671dc86fcfd4/1176_345_3557_2135/master/3557.jpg?width=620&quality=45&dpr=2&s=none");
              },
              icon: const Icon(CupertinoIcons.share))
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          Container(
              height: size * .5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(courseDeailedProvider
                    .courseDetailes!.data!.first.thumbnail!.fullSize
                    .toString()),
              ))),
          KHeight15,
          ValueListenableBuilder(
            valueListenable: _selectedValue,
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoldHeading(
                      heading: courseDeailedProvider
                          .courseDetailes!.data!.first.courseName
                          .toString()),
                  Container(
                    height: 25,
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                        underline: const SizedBox(),
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: Colors.purple,
                        iconEnabledColor: Colors.black,
                        value: value,
                        items: _items
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14))))
                            .toList(),
                        onChanged: (newValue) {
                          _selectedValue.value = newValue;
                        }),
                  )
                ],
              );
            },
          ),
          KHeight5,
          Text(
            "All-in-one Guitar Course,FingerStyle Guitar,Blues Guitar,Acoustic Guitar,Electric Guitar & Fingerpicking Guitarra",
            style: TextStyle(color: Colors.white),
          ),
          KHeight,
          const Align(
              alignment: Alignment.centerLeft, child: BestsellerWidget()),
          KHeight,
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ReviewPage()));
            },
            child: Row(
              children: [
                Text(
                  "${courseDeailedProvider.courseDetailes!.data!.first.rating} ",
                  style: const TextStyle(fontSize: 12, color: Colors.yellow),
                ),
                RatingBarIndicator(
                  unratedColor: Colors.grey,
                  rating: courseDeailedProvider
                      .courseDetailes!.data!.first.rating!
                      .toDouble(),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  itemCount: 5,
                  itemSize: 10.0,
                  direction: Axis.horizontal,
                ),
                Text(
                  " (36,500)",
                  style: const TextStyle(fontSize: 12, color: Colors.yellow),
                ),
              ],
            ),
          ),
          KHeight,
          Row(
            children: [
              Text(
                "(2,414 ratings)",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              KWidth5,
              Text(
                "18,267 students",
                style: TextStyle(color: Colors.white, fontSize: 16),
              )
            ],
          ),
          KHeight5,
          ValueListenableBuilder(
            valueListenable: _selectedValue,
            builder: (context, value, child) {
              int actual_price = courseDeailedProvider
                  .courseDetailes!.data!.first.price!
                  .toInt();
              int exdiscount = ((courseDeailedProvider
                              .courseDetailes!.variant![0].amountPerc! /
                          100) *
                      actual_price)
                  .toInt();
              expert_price = actual_price - exdiscount;
              int interdiscount = ((courseDeailedProvider
                              .courseDetailes!.variant![1].amountPerc! /
                          100) *
                      actual_price)
                  .toInt();
              inter_price = actual_price - interdiscount;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        (value == "Beginner")
                            ? "₹${courseDeailedProvider.courseDetailes!.data!.first.price}"
                            : (value == "Intermediate")
                                ? "₹$inter_price"
                                : "₹$expert_price",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 27),
                      ),
                      KWidth10,
                      const Text(
                        "₹7499",
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                  // Container(
                  //   height: 30,
                  //   padding: EdgeInsets.only(
                  //     left: 10,
                  //   ),
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(10)),
                  //   child: DropdownButton(
                  //       underline: const SizedBox(),
                  //       borderRadius: BorderRadius.circular(10),
                  //       dropdownColor: Colors.purple,
                  //       iconEnabledColor: Colors.black,
                  //       value: value,
                  //       items: _items
                  //           .map((e) => DropdownMenuItem(
                  //               value: e,
                  //               child: Text(e,
                  //                   style: TextStyle(color: Colors.black))))
                  //           .toList(),
                  //       onChanged: (newValue) {
                  //         _selectedValue.value = newValue;
                  //       }),
                  // )
                ],
              );
            },
          ),
          KHeight,
          Row(
            children: [
              const Text(
                "Author -  ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(
                courseDeailedProvider
                    .courseDetailes!.data!.first.instructor!.name
                    .toString(),
                style: const TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )
            ],
          ),
          // KHeight,
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 75),
          //   child: SizedBox(
          //     height: 50,
          //     child: ElevatedButton(
          //       onPressed: () {},
          //       child: Text("Buy now"),
          //       style: ButtonStyle(
          //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //               RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(22))),
          //           backgroundColor: MaterialStateProperty.all(Colors.purple)),
          //     ),
          //   ),
          // ),
          KHeight,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75),
            child: SizedBox(
              height: 50,
              child: OutlinedButton(
                onPressed: () async {
                  // for (int i = 0;
                  //     i < cartProvider.cartItems!.data!.cartItem!.length;
                  //     i++) {
                  //   // print(
                  //   //     "${cartProvider.cartItems!.data!.cartItem![i].courseId}");
                  //   if (cartProvider.cartItems!.data!.cartItem![i].courseId ==
                  //       courseDeailedProvider.courseDetailes!.data!.first.id!
                  //           .toInt()) {
                  //     setState(() {
                  //       alreadyAdded = true;
                  //     });
                  //     print("found");
                  // print(cartProvider.cartItems!.data!.cartItem![i].courseId
                  //     .toString());
                  // print(courseDeailedProvider
                  //     .courseDetailes!.data!.first.id!
                  //     .toString());

                  //  }
                  // print("again");
                  // print(alreadyAdded);
                  // }
                  SharedPreferences _Sharedpref =
                      await SharedPreferences.getInstance();
                  var token = _Sharedpref.getString("access_token");
                  print(token);
                  if (_selectedValue.value == "Beginner") {
                    variant = 1;
                  } else if (_selectedValue.value == "Intermediate") {
                    variant = 2;
                  } else {
                    variant = 3;
                  }

                  if (token != null) {
                    if (variant == 1) {
                      courseDeailedProvider.addToCart(
                          context: context,
                          courseID: courseDeailedProvider
                              .courseDetailes!.data!.first.id!
                              .toInt(),
                          variantID: variant,
                          price: courseDeailedProvider
                              .courseDetailes!.data!.first.price!
                              .toInt(),
                          token: token);
                    } else if (variant == 2) {
                      courseDeailedProvider.addToCart(
                          context: context,
                          courseID: courseDeailedProvider
                              .courseDetailes!.data!.first.id!
                              .toInt(),
                          variantID: variant,
                          price: inter_price!.toInt(),
                          token: token);
                    } else {
                      courseDeailedProvider.addToCart(
                          context: context,
                          courseID: courseDeailedProvider
                              .courseDetailes!.data!.first.id!
                              .toInt(),
                          variantID: variant,
                          price: expert_price!.toInt(),
                          token: token);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Access token missing")));
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22))),
                    side: MaterialStateProperty.all(const BorderSide(
                      color: Colors.white,
                    ))),
                child: Text(
                  "Bag it",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          KHeight15,
          const BoldHeading(heading: "Recently viewed"),
          //ivide thalkaalam oru cardundaakki vechathaanh.api kittiyaal small item card thanne call cheythaal mathi
          SizedBox(
            height: size * .6,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return RecentlyViewedCard();
              },
            ),
          ),
          KHeight15,
          const BoldHeading(heading: "Recommendations"),
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount:
                recomendationsProvider.recomendationsCourses!.data!.length,
            itemBuilder: (context, index) {
              final datas =
                  recomendationsProvider.recomendationsCourses!.data![index];
              return CourseDetailesListTile(
                  courseName: datas.courseName.toString(),
                  authorName: datas.instructor!.name.toString(),
                  coursePrice: datas.price!.toDouble(),
                  image: datas.thumbnail!.fullSize.toString(),
                  rating: datas.rating!.toDouble(),
                  id: datas.id!.toInt());
            },
          ),
        ],
      ),
    );
  }
}

class RecentlyViewedCard extends StatelessWidget {
  const RecentlyViewedCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size * .365,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size * .185,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "http://learningapp.e8demo.com/media/thumbnail_img/5-chemistry.jpeg"))),
            ),
            KHeight5,
            Text(
              "Python",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            KHeight5,
            Text(
              "Marko",
              style: TextStyle(fontSize: 12, color: Colors.grey[300]),
            ),
            KHeight5,
            Row(
              children: [
                Text(
                  "2.6 ***** (36,907)",
                  style: TextStyle(fontSize: 12, color: Colors.yellow),
                ),
              ],
            ),
            KHeight5,
            Text(
              "₹6000",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            KHeight5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BestsellerWidget(),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5)),
                    margin: const EdgeInsets.only(right: 20),
                    height: 30,
                    width: 50,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.shopping_bag,
                          color: Colors.white,
                          size: 28,
                        )))
              ],
            )
          ],
        ),
      ),
    );
  }
}
