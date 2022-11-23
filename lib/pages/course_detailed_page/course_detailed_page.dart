import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/my_home_page.dart';
import 'package:nuox_project/pages/course_detailed_page/recomendations_services/recomendations_provider.dart';
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_provider.dart';
import 'package:nuox_project/pages/course_detailed_page/sections/review_page/review_page.dart';
import 'package:nuox_project/pages/featured/services/featured_section/featured_provider.dart';
import 'package:nuox_project/pages/featured/services/top_courses_section/top_courses_provider.dart';
import 'package:nuox_project/pages/featured/widgets/small_item_card.dart';
import 'package:nuox_project/widgets/bestseller.dart';
import 'package:nuox_project/widgets/bold_heading.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../../widgets/course_detailes_list_tile.dart';
import '../catagories_detailed_page.dart/services/catagories_detailed_provider.dart';

class CourseDetailedPage extends StatefulWidget {
  final bool refesh;
  final int? id;
  final int? subcatid;
  const CourseDetailedPage(
      {super.key, this.id, this.refesh = false, this.subcatid});

  @override
  State<CourseDetailedPage> createState() => _CourseDetailedPageState();
}

class _CourseDetailedPageState extends State<CourseDetailedPage> {
  String? token;
  void get() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    token = shared.getString("access_token");
  }

  final ValueNotifier _selectedValue = ValueNotifier("Beginner");
  late VideoPlayerController _controller;
  final List _items = ["Beginner", "Intermediate", "Expert"];
  int currentIndex = 0;
  @override
  void initState() {
    get();
    final courseDeailedProviders =
        Provider.of<CourseDetailedProvider>(context, listen: false);

    super.initState();
    _controller = VideoPlayerController.network(courseDeailedProviders
            .courseDetailes?.data?.first.introVideo ??
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.pause();
        _controller.setLooping(false);
        _controller.setVolume(1);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final featuredProvider = Provider.of<FeaturedProvider>(context);
    final isMuted = _controller.value.volume == 0;
    final courseDeailedProvider = Provider.of<CourseDetailedProvider>(context);
    final recomendationsProvider = Provider.of<RecomendationsProvider>(context);
    var size = MediaQuery.of(context).size.width;
    int variant = 1;
    int? expert_price;
    int? inter_price;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Featured"),
        actions: [
          kWidth5,
          IconButton(
              onPressed: () async {
                if (courseDeailedProvider
                        .courseDetailes!.data!.first.introVideo !=
                    null) {
                  await Share.share(courseDeailedProvider
                      .courseDetailes!.data!.first.introVideo
                      .toString());
                }
              },
              icon: const Icon(CupertinoIcons.share))
        ],
        leading: IconButton(
            onPressed: () async {
              await Provider.of<TopCoursesProvider>(
                context,
                listen: false,
              ).getAll();
              if (widget.subcatid != null) {
                await Provider.of<CatagoriesDetailedProvider>(context,
                        listen: false)
                    .getAll(catagoriesID: widget.id);
              }
              await Provider.of<CatagoriesDetailedProvider>(context,
                      listen: false)
                  .getSubCatagoriesDetailes(subCatagoriesID: widget.id);
              await Provider.of<CatagoriesDetailedProvider>(context,
                      listen: false)
                  .getSubCatagoriesDetailes(subCatagoriesID: widget.subcatid);
              await Provider.of<FeaturedProvider>(context, listen: false)
                  .samples();
              await Provider.of<RecomendationsProvider>(context, listen: false)
                  .getAll();
              await Provider.of<CourseDetailedProvider>(context, listen: false)
                  .getRecentlyViewed();
              selectedIndex.value = 0;
              widget.refesh == false
                  ? Navigator.pop(context)
                  : Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()),
                      (route) => false);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: courseDeailedProvider.isCourseLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: size * .5,
                      child: PageView(
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(courseDeailedProvider
                                      .courseDetailes
                                      ?.data
                                      ?.first
                                      .thumbnail
                                      ?.fullSize
                                      .toString() ??
                                  "http://learningapp.e8demo.com/media/thumbnail_img/5-chemistry.jpeg"),
                            )),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                              });
                            },
                            child: Container(
                                child: _controller.value.isInitialized
                                    ? Stack(
                                        children: [
                                          AspectRatio(
                                              aspectRatio:
                                                  _controller.value.aspectRatio,
                                              child: VideoPlayer(_controller)),
                                          _controller.value.isPlaying
                                              ? const SizedBox()
                                              : Align(
                                                  alignment: Alignment.center,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          _controller.play();
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.play_arrow,
                                                        color: Colors.white,
                                                        size: 45,
                                                      )),
                                                ),
                                          Positioned(
                                            right: 10,
                                            bottom: 5,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _controller.setVolume(
                                                          isMuted ? 1 : 0);
                                                    });
                                                  },
                                                  icon: Icon(
                                                    isMuted
                                                        ? Icons.volume_off
                                                        : Icons.volume_up,
                                                    color: Colors.black,
                                                  )),
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: VideoProgressIndicator(
                                                  _controller,
                                                  allowScrubbing: true))
                                        ],
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      )),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: currentIndex == 0
                                        ? Colors.purple
                                        : Colors.grey)),
                            Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: currentIndex == 1
                                        ? Colors.purple
                                        : Colors.grey))
                          ]),
                    )
                  ],
                ),
                kHeight15,
                ValueListenableBuilder(
                  valueListenable: _selectedValue,
                  builder: (context, value, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoldHeading(
                            heading: courseDeailedProvider
                                    .courseDetailes?.data?.first.courseName
                                    .toString() ??
                                "Course name"),
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
                                              color: Colors.black,
                                              fontSize: 14))))
                                  .toList(),
                              onChanged: (newValue) {
                                _selectedValue.value = newValue;
                              }),
                        )
                      ],
                    );
                  },
                ),
                kHeight5,
                Text(
                  courseDeailedProvider.courseDetailes?.data?.first.description
                          .toString() ??
                      "Course description",
                  style: const TextStyle(color: Colors.white),
                ),
                kHeight,
                const Align(
                    alignment: Alignment.centerLeft, child: BestsellerWidget()),
                kHeight,
                GestureDetector(
                  onTap: () async {
                    SharedPreferences shared =
                        await SharedPreferences.getInstance();
                    var token = shared.getString("access_token");
                    if (token != null) {
                      if (courseDeailedProvider
                              .courseDetailes?.data?.first.id !=
                          null) {
                        courseDeailedProvider.getReview(
                            courseID: courseDeailedProvider
                                .courseDetailes!.data!.first.id);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ReviewPage(
                                  id: courseDeailedProvider
                                      .courseDetailes!.data!.first.id!
                                      .toInt(),
                                )));
                      }
                    } else {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const Test()),
                        (route) => false,
                      );
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        "${courseDeailedProvider.courseDetailes?.data?.first.rating ?? "4"} ",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.yellow),
                      ),
                      RatingBarIndicator(
                        unratedColor: Colors.grey,
                        rating: courseDeailedProvider
                                .courseDetailes?.data?.first.rating!
                                .toDouble() ??
                            4,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        itemCount: 5,
                        itemSize: 10.0,
                        direction: Axis.horizontal,
                      ),
                      courseDeailedProvider
                                  .courseDetailes?.data?.first.ratingCount ==
                              null
                          ? const Text(
                              " (36,500)",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.yellow),
                            )
                          : Text(
                              "  (${courseDeailedProvider.courseDetailes?.data?.first.ratingCount})",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.yellow),
                            ),
                    ],
                  ),
                ),
                kHeight,
                // GestureDetector(
                //   onTap: () async {
                //     if (courseDeailedProvider.courseDetailes?.data?.first.id !=
                //         null) {
                //       await courseDeailedProvider.getReview(
                //           courseID: courseDeailedProvider
                //               .courseDetailes!.data!.first.id);
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (context) => ReviewPage(
                //                 id: courseDeailedProvider
                //                     .courseDetailes!.data!.first.id!
                //                     .toInt(),
                //               )));
                //     }
                //   },
                //   child: Row(
                //     children: [
                //       Text(
                //         "(2,414 ratings)",
                //         style: TextStyle(color: Colors.white, fontSize: 16),
                //       ),
                //       KWidth5,
                //       Text(
                //         "18,267 students",
                //         style: TextStyle(color: Colors.white, fontSize: 16),
                //       )
                //     ],
                //   ),
                // ),
                // KHeight5,
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
                            kWidth10,
                            const Text(
                              "₹10,000",
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
                kHeight,
                Row(
                  children: [
                    const Text(
                      "Author -  ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        // if (courseDeailedProvider
                        //         .courseDetailes?.data?.first.instructor?.name
                        //         .toString() !=
                        //     null) {
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (context) =>
                        //           const AuthorDetailesPage()));
                        // }
                      },
                      child: Text(
                        courseDeailedProvider
                                .courseDetailes?.data?.first.instructor?.name
                                .toString() ??
                            "Author name",
                        style: const TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),

                kHeight,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 75),
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        SharedPreferences sharedpref =
                            await SharedPreferences.getInstance();
                        var token = sharedpref.getString("access_token");
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
                          if (!mounted) return;
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const Test()),
                            (route) => false,
                          );
                        }
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22))),
                          side: MaterialStateProperty.all(const BorderSide(
                            color: Colors.white,
                          ))),
                      label: const Text(
                        "Add to Bag",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                kHeight,
                token == null
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 75),
                        child: SizedBox(
                          height: 50,
                          child: OutlinedButton.icon(
                            icon: Icon(
                              courseDeailedProvider.courseDetailes!.data!.first
                                          .isWislist ==
                                      true
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: courseDeailedProvider.courseDetailes!.data!
                                          .first.isWislist ==
                                      true
                                  ? Colors.red
                                  : Colors.white,
                            ),
                            onPressed: () async {
                              if (_selectedValue.value == "Beginner") {
                                variant = 1;
                              } else if (_selectedValue.value ==
                                  "Intermediate") {
                                variant = 2;
                              } else {
                                variant = 3;
                              }
                              SharedPreferences shared =
                                  await SharedPreferences.getInstance();
                              var token = shared.getString("access_token");
                              if (token == null) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const Test()),
                                  (route) => false,
                                );
                              } else {
                                if (courseDeailedProvider.courseDetailes!.data!
                                        .first.isWislist ==
                                    false) {
                                  if (variant == 1) {
                                    featuredProvider.addToWhishlist(
                                        id: courseDeailedProvider
                                            .courseDetailes!.data!.first.id!
                                            .toInt(),
                                        variant: variant,
                                        context: context,
                                        price: courseDeailedProvider
                                            .courseDetailes!.data!.first.price!
                                            .toInt());
                                  } else if (variant == 2) {
                                    featuredProvider.addToWhishlist(
                                        id: courseDeailedProvider
                                            .courseDetailes!.data!.first.id!
                                            .toInt(),
                                        variant: variant,
                                        context: context,
                                        price: inter_price!.toInt());
                                  } else {
                                    featuredProvider.addToWhishlist(
                                        id: courseDeailedProvider
                                            .courseDetailes!.data!.first.id!
                                            .toInt(),
                                        variant: variant,
                                        context: context,
                                        price: expert_price!.toInt());
                                  }
                                }
                                if (courseDeailedProvider.courseDetailes!.data!
                                        .first.isWislist ==
                                    true) {
                                  await featuredProvider.deleteFromWhishlist(
                                      variant: variant,
                                      id: courseDeailedProvider
                                          .courseDetailes!.data!.first.id!
                                          .toString(),
                                      context: context);
                                  //await featuredProvider.getWhishlist();
                                }
                                if (widget.id != null) {
                                  print("Entered");
                                  Provider.of<CourseDetailedProvider>(context,
                                          listen: false)
                                      .getAll(courseID: widget.id);
                                  Provider.of<TopCoursesProvider>(
                                    context,
                                    listen: false,
                                  ).getAll();
                                  await Provider.of<CatagoriesDetailedProvider>(
                                          context,
                                          listen: false)
                                      .getSubCatagoriesDetailes(
                                          subCatagoriesID: widget.id);
                                }
                              }
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(22))),
                                side:
                                    MaterialStateProperty.all(const BorderSide(
                                  color: Colors.white,
                                ))),
                            label: Text(
                              courseDeailedProvider.courseDetailes!.data!.first
                                          .isWislist ==
                                      false
                                  ? "Add to wishlist"
                                  : "Remove from wishlist",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                kHeight15,
                courseDeailedProvider.recentlyViewedList == null ||
                        courseDeailedProvider
                            .recentlyViewedList!.data!.data!.isEmpty
                    ? const SizedBox()
                    : const BoldHeading(heading: "Recently viewed"),
                kHeight5,
                courseDeailedProvider.recentlyViewedList == null ||
                        courseDeailedProvider
                            .recentlyViewedList!.data!.data!.isEmpty
                    ? const SizedBox()
                    : SizedBox(
                        height: size * .6,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: courseDeailedProvider
                              .recentlyViewedList?.data?.data?.length,
                          itemBuilder: (context, index) {
                            final datas = courseDeailedProvider
                                .recentlyViewedList?.data?.data?[index];
                            return SmallItemCard(
                              courseName: datas?.courseName,
                              authorName: datas?.instructorName,
                              coursePrice: datas?.coursePrice,
                              isWishlist: datas?.isWishlist,
                              image: datas?.courseThumbnail.toString(),
                              rating: datas?.rating?.toDouble(),
                              id: datas?.id,
                              ratingCount: datas?.ratingCount,
                              isBestSeller: datas?.bestSeller,
                            );
                          },
                        ),
                      ),
                kHeight,
                const BoldHeading(heading: "Recommendations"),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: recomendationsProvider
                      .recomendationsCourses?.data?.length,
                  itemBuilder: (context, index) {
                    final datas = recomendationsProvider
                        .recomendationsCourses?.data?[index];
                    return CourseDetailesListTile(
                      courseName: datas?.courseName.toString(),
                      authorName: datas?.instructor?.name.toString(),
                      coursePrice: datas?.price?.toDouble(),
                      image: datas?.thumbnail?.fullSize.toString(),
                      ratingCount: datas?.ratingCount,
                      rating: datas?.rating?.toDouble(),
                      isWishlist: datas?.isWishlist,
                      id: datas?.id?.toInt(),
                      isRecomended: datas?.bestSeller,
                    );
                  },
                ),
              ],
            ),
    );
  }
}
