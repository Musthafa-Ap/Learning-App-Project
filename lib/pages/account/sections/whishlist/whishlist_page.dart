import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nuox_project/pages/featured/services/featured_section/featured_provider.dart';
import 'package:nuox_project/widgets/big_cart_icon_button.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants.dart';
import '../../../../widgets/bestseller.dart';
import '../../../course_detailed_page/course_detailed_page.dart';
import '../../../course_detailed_page/services/course_detailed_provider.dart';

class WhichlistPage extends StatelessWidget {
  const WhichlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final featuerdProvider = Provider.of<FeaturedProvider>(context);
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text("My Wishlist"),
      ),
      body: featuerdProvider.whishlist == null ||
              featuerdProvider.whishlist!.data!.wishlist!.isEmpty ||
              featuerdProvider.isWhishlistEmpty == true
          ? const Center(
              child: Text(
                "Wishlist is empty",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: featuerdProvider.whishlist!.data!.wishlist?.length,
              padding: const EdgeInsets.all(15),
              itemBuilder: (context, index) {
                final datas =
                    featuerdProvider.whishlist!.data!.wishlist![index];
                return InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () async {
                    if (datas.courseId != null) {
                      await Provider.of<CourseDetailedProvider>(context,
                              listen: false)
                          .getAll(courseID: datas.courseId);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CourseDetailedPage()));
                    }
                  },
                  child: SizedBox(
                      //padding: const EdgeInsets.symmetric(vertical: 5),
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
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          datas.courseImage.toString()))),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          datas.courseName.toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        datas.courseId == null ||
                                                datas.price == null
                                            ? const SizedBox()
                                            : BigCartIconButton(
                                                id: datas.courseId!.toInt(),
                                                price: datas.price!.toInt())
                                      ],
                                    ),
                                    // kHeight5,
                                    Text(
                                      datas.autherName.toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[300]),
                                    ),
                                    kHeight5,
                                    Row(
                                      children: [
                                        Text(
                                          "${datas.rating!.toDouble()} ",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.yellow),
                                        ),
                                        RatingBarIndicator(
                                          unratedColor: Colors.grey,
                                          rating: datas.rating!.toDouble(),
                                          itemBuilder: (context, index) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          itemCount: 5,
                                          itemSize: 10.0,
                                          direction: Axis.horizontal,
                                        ),
                                      ],
                                    ),
                                    kHeight5,
                                    Text(
                                      "₹${datas.price}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const BestsellerWidget(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                  barrierColor: Colors.black
                                                      .withOpacity(.5),
                                                  context: context,
                                                  builder: (ctx) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          Colors.black,
                                                      content: const Text(
                                                        "Do you want to remove it from whishlist?",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const Text("No"),
                                                        ),
                                                        ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              await featuerdProvider.deleteFromWhishlist(
                                                                  variant: datas
                                                                      .section!
                                                                      .id,
                                                                  id: datas
                                                                      .courseId
                                                                      .toString(),
                                                                  context:
                                                                      context);
                                                              await featuerdProvider
                                                                  .getWhishlist();
                                                              // ignore: use_build_context_synchronously
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "Yes"))
                                                      ],
                                                    );
                                                  });
                                            },
                                          ),
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
              },
            ),
    );
  }
}
