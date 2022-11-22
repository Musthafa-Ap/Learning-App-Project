import 'package:flutter/material.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/my_home_page.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/services/catagories_detailed_provider.dart';
import 'package:nuox_project/pages/course_detailed_page/recomendations_services/recomendations_provider.dart';
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_provider.dart';
import 'package:nuox_project/pages/featured/widgets/catagories_button.dart';
import 'package:nuox_project/widgets/bold_heading.dart';
import 'package:provider/provider.dart';
import '../../widgets/course_detailes_list_tile.dart';
import '../featured/widgets/small_item_card.dart';
import 'widgets/catagory_detailed_page_item_card.dart';

class CatagoriesDetailedPage extends StatelessWidget {
  int cataid;
  CatagoriesDetailedPage({super.key, this.cataid = 1});
  @override
  Widget build(BuildContext context) {
    final courseDeailedProvider = Provider.of<CourseDetailedProvider>(context);
    final size = MediaQuery.of(context).size.width;
    final catagoriesDetailedProvider =
        Provider.of<CatagoriesDetailedProvider>(context);
    final recomendationProvider = Provider.of<RecomendationsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const MyHomePage()),
                (route) => false);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        children: [
          const Text(
            "Courses to get you started",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size * .76,
            child: ListView.builder(
              itemCount:
                  catagoriesDetailedProvider.catagoriesDetailes?.data?.length,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final datas =
                    catagoriesDetailedProvider.catagoriesDetailes?.data?[index];
                return CatagoryDetailedPageItemCard(
                  image: datas?.thumbnail?.fullSize.toString(),
                  isWishlist: datas?.isWishlist,
                  courseName: datas?.courseName.toString(),
                  price: datas?.price?.toInt(),
                  ratingCount: datas?.ratingCount!.toInt(),
                  rating: datas?.rating?.toInt(),
                  id: datas?.id,
                  cataid: cataid,
                  bestSeller: datas?.bestSeller,
                );
              },
            ),
          ),
          kHeight15,
          const BoldHeading(heading: "Subcategories"),
          kHeight,
          SizedBox(
            height: 60,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: catagoriesDetailedProvider.subCatagories?.data!.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final datas =
                    catagoriesDetailedProvider.subCatagories!.data![index];
                return CatagoriesButton(
                    navigatepage: "sub_catagories_detailed",
                    title: datas.subCatehoryName.toString(),
                    id: datas.id?.toInt());
              },
            ),
          ),
          kHeight15,
          courseDeailedProvider.recentlyViewedList == null ||
                  courseDeailedProvider.recentlyViewedList!.data!.data!.isEmpty
              ? const SizedBox()
              : const BoldHeading(heading: "Recently viewed"),
          kHeight5,
          courseDeailedProvider.recentlyViewedList == null ||
                  courseDeailedProvider.recentlyViewedList!.data!.data!.isEmpty
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
                        isWishlist: datas?.isWishlist,
                        coursePrice: datas?.coursePrice,
                        image: datas?.courseThumbnail.toString(),
                        rating: datas?.rating?.toDouble(),
                        id: datas?.id,
                        ratingCount: datas?.ratingCount,
                        isBestSeller: datas?.bestSeller,
                      );
                    },
                  ),
                ),
          kHeight15,
          const BoldHeading(heading: "Recommendations"),
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount:
                recomendationProvider.recomendationsCourses!.data!.length,
            itemBuilder: (context, index) {
              final datas =
                  recomendationProvider.recomendationsCourses?.data?[index];
              return CourseDetailesListTile(
                courseName: datas?.courseName.toString(),
                authorName: datas?.instructor?.name.toString(),
                coursePrice: datas?.price?.toDouble(),
                image: datas?.thumbnail?.fullSize.toString(),
                ratingCount: datas?.ratingCount,
                isWishlist: datas?.isWishlist,
                rating: datas?.rating?.toDouble(),
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
