import 'package:flutter/material.dart';
import 'package:nuox_project/pages/cart/cart_services/cart_services.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../my_home_page.dart';
import '../../widgets/big_cart_icon_button.dart';
import '../../widgets/course_detailes_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nuox_project/pages/cart/cart_services/cart_services.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/services/catagories_detailed_provider.dart';
import 'package:nuox_project/pages/course_detailed_page/course_detailed_page.dart';
import 'package:nuox_project/pages/course_detailed_page/recomendations_services/recomendations_provider.dart';
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_provider.dart';
import 'package:nuox_project/pages/featured/services/featured_section/featured_provider.dart';
import 'package:nuox_project/pages/featured/services/top_courses_section/top_courses_provider.dart';
import 'package:nuox_project/widgets/bestseller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../../widgets/course_detailes_list_tile.dart';
import '../catagories_detailed_page.dart/services/catagories_detailed_provider.dart';
import '../my_learning/widgets/course_videos_page.dart';

class Cart extends StatefulWidget {
  bool? fromdetail;
  Cart({super.key, this.fromdetail = false});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    get();
    super.initState();
  }

  void get() async {
    await Provider.of<CartProvider>(context, listen: false).getAllCartItems();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getAllCartItems();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: widget.fromdetail == true ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Text("Course cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: cartProvider.cartItems == null ||
                cartProvider.cartItems!.data!.cartItem!.isEmpty ||
                cartProvider.cartEmpty == true
            ? const Center(
                child: Text(
                "Bag is Empty",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: cartProvider.cartItems!.data!.cartItem!.length,
                      itemBuilder: (context, index) {
                        final datas =
                            cartProvider.cartItems!.data!.cartItem![index];
                        return CourseListTile(
                          variantID: datas.section!.id!.toInt(),
                          courseName: datas.courseName.toString(),
                          authorName: datas.autherName.toString(),
                          isWishlist: false,
                          coursePrice: datas.price!.toDouble(),
                          ratingCount: 100,
                          image: datas.courseimage.toString(),
                          rating: datas.rating!.toDouble(),
                          id: datas.courseId!.toInt(),
                          isCartItem: true,
                          isRecomended: datas.bestSeller,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: cartProvider.cartItems!.data!.cartItem!.isEmpty
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: ElevatedButton(
                              onPressed: () {
                                cartProvider.isCoupenSuccess = false;
                                cartProvider.getCheckout(context);
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.purple)),
                              child: cartProvider.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Text(
                                      cartProvider.cartItems!.data!.cartItem!
                                                  .length ==
                                              1
                                          ? "Buy Item"
                                          : "Buy All",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                            ),
                          ),
                  ),
                  kHeight
                ],
              ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CourseListTile extends StatefulWidget {
  final int? subCatid;
  final bool? isWishlist;
  final int? ratingCount;
  final bool? isRecomended;
  final int? id;
  final String? courseName;
  final String? authorName;
  final double? coursePrice;
  final String? image;
  final double? rating;
  final int? variantID;
  const CourseListTile({
    Key? key,
    this.subCatid,
    this.isCartItem = false,
    required this.courseName,
    required this.authorName,
    required this.coursePrice,
    required this.image,
    required this.rating,
    required this.id,
    this.variantID,
    this.isRecomended = false,
    required this.ratingCount,
    required this.isWishlist,
  }) : super(key: key);
  final bool isCartItem;

  @override
  State<CourseListTile> createState() => _CourseListTileState();
}

class _CourseListTileState extends State<CourseListTile> {
  @override
  void initState() {
    get();
    super.initState();
  }

  String? token;
  void get() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    token = shared.getString("access_token");
  }

  String? variant;

  @override
  Widget build(BuildContext context) {
    final featuredProvider = Provider.of<FeaturedProvider>(context);
    if (widget.variantID != null) {
      if (widget.variantID == 1) {
        variant = "Beginner";
      } else if (widget.variantID == 2) {
        variant = "Intermediate";
      } else {
        variant = "Expert";
      }
    }
    final cartProvider = Provider.of<CartProvider>(context);
    final size = MediaQuery.of(context).size.width;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        if (widget.id != null) {
          await Provider.of<CourseDetailedProvider>(context, listen: false)
              .getAll(
            courseID: widget.id,
          );
          await Provider.of<RecomendationsProvider>(context, listen: false)
              .getAllRecFromCourse(courseId: widget.id!.toInt());
          if (widget.subCatid != null) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CourseDetailedPageFromCart(
                      id: widget.id,
                      subcatid: widget.subCatid,
                      variant: variant.toString(),
                    )));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CourseDetailedPageFromCart(
                      id: widget.id,
                      variant: variant.toString(),
                    )));
          }
        }
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          height: size * .425,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size * .3,
                  width: size * .270,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.image ??
                              "http://learningapp.e8demo.com/media/thumbnail_img/5-chemistry.jpeg"))),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.courseName ?? "Course name",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 26),
                              child: GestureDetector(
                                onTap: () async {
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
                                    if (widget.id != null ||
                                        widget.coursePrice != null) {
                                      if (widget.isWishlist == false) {
                                        featuredProvider.addToWhishlist(
                                            id: widget.id,
                                            variant: 1,
                                            context: context,
                                            price: widget.coursePrice);
                                        // await featuredProvider.getWhishlist();
                                      }
                                      if (widget.isWishlist == true) {
                                        await featuredProvider
                                            .deleteFromWhishlist(
                                                variant: 1,
                                                id: widget.id.toString(),
                                                context: context);
                                        // await featuredProvider.getWhishlist();
                                      }
                                      await Provider.of<FeaturedProvider>(
                                              context,
                                              listen: false)
                                          .samples();
                                      await Provider.of<FeaturedProvider>(
                                              context,
                                              listen: false)
                                          .sample();
                                      await Provider.of<TopCoursesProvider>(
                                              context,
                                              listen: false)
                                          .getAll();
                                      await Provider.of<RecomendationsProvider>(
                                              context,
                                              listen: false)
                                          .getAll();
                                      await Provider.of<CourseDetailedProvider>(
                                              context,
                                              listen: false)
                                          .getRecentlyViewed();
                                      if (widget.subCatid != null) {
                                        await Provider.of<
                                                    CatagoriesDetailedProvider>(
                                                context,
                                                listen: false)
                                            .getSubCatagoriesDetailes(
                                                subCatagoriesID:
                                                    widget.subCatid);
                                      }
                                    }
                                  }
                                },
                                child: token == null ||
                                        widget.isCartItem == true ||
                                        widget.isWishlist == null
                                    ? const SizedBox()
                                    : Icon(
                                        widget.isWishlist == true
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 20,
                                        color: widget.isWishlist == true
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                              ),
                            )
                          ],
                        ),
                        kHeight5,
                        Text(
                          widget.authorName ?? "Author name",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[300]),
                        ),
                        kHeight5,
                        Row(
                          children: [
                            Text(
                              "${widget.rating ?? "4"} ",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.yellow),
                            ),
                            RatingBarIndicator(
                              unratedColor: Colors.grey,
                              rating: widget.rating ?? 4,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              itemCount: 5,
                              itemSize: 10.0,
                              direction: Axis.horizontal,
                            ),
                            Text(
                              " (${widget.ratingCount ?? "0"})",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.yellow),
                            ),
                          ],
                        ),
                        kHeight5,
                        widget.isCartItem
                            ? Text(
                                variant.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox(),
                        kHeight5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "₹${widget.coursePrice ?? "Course price"}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            widget.isCartItem
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    margin: const EdgeInsets.only(right: 20),
                                    height: 35,
                                    width: 45,
                                    child: IconButton(
                                        onPressed: () {
                                          if (widget.id != null ||
                                              widget.variantID != null) {
                                            cartProvider.deleteCartItem(
                                                courseID: widget.id,
                                                variantID: widget.variantID,
                                                context: context);
                                          }
                                        },
                                        icon: const Icon(Icons.delete)))
                                : const SizedBox()
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            widget.isRecomended != false
                                ? const BestsellerWidget()
                                : const SizedBox(),
                            widget.isCartItem == true ||
                                    widget.id == null ||
                                    widget.coursePrice == null
                                ? const SizedBox()
                                // ? Container(
                                //     decoration: BoxDecoration(
                                //         color: Colors.white,
                                //         borderRadius: BorderRadius.circular(5)),
                                //     margin: const EdgeInsets.only(right: 20),
                                //     height: 35,
                                //     width: 45,
                                //     child: IconButton(
                                //         onPressed: () {
                                //           cartProvider.deleteCartItem(
                                //               courseID: widget.id,
                                //               variantID: widget.variantID,
                                //               context: context);
                                //         },
                                //         icon: const Icon(Icons.delete)))
                                : BigCartIconButton(
                                    id: widget.id!,
                                    price: widget.coursePrice!.toInt(),
                                  )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

//
//
//
//
//
//
//
//
//
//
//
//
//
//
class CourseDetailedPageFromCart extends StatefulWidget {
  String variant;
  final bool refesh;
  final int? id;
  final int? subcatid;
  CourseDetailedPageFromCart(
      {super.key,
      this.id,
      this.refesh = false,
      this.subcatid,
      required this.variant});

  @override
  State<CourseDetailedPageFromCart> createState() =>
      _CourseDetailedPageFromCartState();
}

class _CourseDetailedPageFromCartState
    extends State<CourseDetailedPageFromCart> {
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
    _selectedValue.value = widget.variant;
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
    int? beginning_price;
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
              Navigator.pop(context);
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
              //selectedIndex.value = 0;
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
                                            left: 2,
                                            bottom: 7,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              child: IconButton(
                                                  splashColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
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
                                          Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: IconButton(
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LandscapePlayerPage(
                                                                  controller:
                                                                      _controller)));
                                                },
                                                icon: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white38,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: const Icon(
                                                    Icons.fullscreen,
                                                    color: Colors.black,
                                                  ),
                                                )),
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
                                              fontWeight: FontWeight.w500,
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
                // Text(
                //   courseDeailedProvider.courseDetailes?.data?.first.description
                //           .toString() ??
                //       "Course description",
                //   style: const TextStyle(color: Colors.white),
                // ),
                ReadMoreText(
                  courseDeailedProvider.courseDetailes?.data?.first.description
                          .toString() ??
                      "Course description",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  trimLines: 2,
                  colorClickableText: Colors.purple,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
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
                                  isPurchased: false,
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
                              " (500)",
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
                                    .courseDetailes!.variant![2].amountPerc! /
                                100) *
                            actual_price)
                        .toInt();
                    expert_price = actual_price - exdiscount;
                    int interdiscount = ((courseDeailedProvider
                                    .courseDetailes!.variant![0].amountPerc! /
                                100) *
                            actual_price)
                        .toInt();
                    inter_price = actual_price - interdiscount;
                    int begdiscount = ((courseDeailedProvider
                                    .courseDetailes!.variant![1].amountPerc! /
                                100) *
                            actual_price)
                        .toInt();
                    beginning_price = actual_price - begdiscount;
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
                      onTap: () {},
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
                                price: beginning_price!.toInt(),
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
                                        price: beginning_price!.toInt());
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
                              refresh: false,
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
