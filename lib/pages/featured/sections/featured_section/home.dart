import 'package:flutter/material.dart';
import 'package:nuox_project/pages/account/account_services/account_provider.dart';
import 'package:nuox_project/pages/cart/cart_services/cart_services.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/services/catagories_detailed_provider.dart';
import 'package:nuox_project/pages/course_detailed_page/recomendations_services/recomendations_provider.dart';
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_provider.dart';
import 'package:nuox_project/pages/featured/services/catagories_section/catagories_provider.dart';
import 'package:nuox_project/pages/featured/services/top_courses_section/top_courses_provider.dart';
import 'package:nuox_project/pages/my_learning/services/my_learnings_provider.dart';
import 'package:nuox_project/pages/search/services/search_provider.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants.dart';
import '../../../../widgets/bold_heading.dart';
import '../../../../widgets/course_detailes_list_tile.dart';
import '../../services/featured_section/featured_provider.dart';
import '../top_courses_section/top_courses_section.dart';
import '../catagories_section/catagories_section.dart';
import 'featured_section.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Provider.of<FeaturedProvider>(context, listen: false).sample();
    Provider.of<CatagoriesProvider>(context, listen: false).getAll();
    Provider.of<TopCoursesProvider>(context, listen: false).getAll();
    Provider.of<CourseDetailedProvider>(context, listen: false)
        .getAll(courseID: 2);
    Provider.of<CatagoriesDetailedProvider>(context, listen: false)
        .getAll(catagoriesID: 1);
    Provider.of<CatagoriesDetailedProvider>(context, listen: false)
        .getAllSub(catagoriesID: 1);
    Provider.of<RecomendationsProvider>(context, listen: false).getAll();
    Provider.of<CatagoriesDetailedProvider>(context, listen: false)
        .getSubCatagoriesDetailes(subCatagoriesID: 1);
    super.initState();
    Provider.of<CartProvider>(context, listen: false).getAllCartItems();
    Provider.of<TopCoursesProvider>(context, listen: false).bannerList();
    Provider.of<AccountProvider>(context, listen: false).getFAQ();
    Provider.of<CourseDetailedProvider>(context, listen: false)
        .getReview(courseID: 2);
    Provider.of<AccountProvider>(context, listen: false).getAboutApp();
    Provider.of<MyLearningsProvider>(context, listen: false).getMyLearnings();
    Provider.of<SearchProvider>(context, listen: false).getSearchItems(key: "");
    Provider.of<FeaturedProvider>(context, listen: false).sortedCourses = null;
    Provider.of<CourseDetailedProvider>(context, listen: false)
        .getRecentlyViewed();
    Provider.of<FeaturedProvider>(context, listen: false).getNotifications();
    Provider.of<FeaturedProvider>(context, listen: false).getWhishlist();
    Provider.of<AccountProvider>(context, listen: false).getOrderDetailes();
    Provider.of<AccountProvider>(context, listen: false).getDocument();
  }

  @override
  Widget build(BuildContext context) {
    final recomendationProvider = Provider.of<RecomendationsProvider>(context);
    bool isfeaturetop = true;
    Provider.of<CourseDetailedProvider>(context, listen: false)
        .getRecentlyViewed();

    return isfeaturetop == true
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FeaturedSection(),
              kHeight15,
              const CatagoriesSection(),
              const TopCoursesSection(),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopCoursesSection(),
              kHeight15,
              const CatagoriesSection(),
              const FeaturedSection(),
              // const BoldHeading(heading: "Recommendations"),
              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: const BouncingScrollPhysics(),
              //   itemCount:
              //       recomendationProvider.recomendationsCourses?.data?.length,
              //   itemBuilder: (context, index) {
              //     final datas =
              //         recomendationProvider.recomendationsCourses?.data?[index];
              //     return CourseDetailesListTile(
              //       courseName: datas?.courseName.toString(),
              //       authorName: datas?.instructor?.name.toString(),
              //       coursePrice: datas?.price?.toDouble(),
              //       image: datas?.thumbnail?.fullSize.toString(),
              //       ratingCount: datas?.ratingCount,
              //       isWishlist: datas?.isWishlist,
              //       rating: datas?.rating?.toDouble(),
              //       id: datas?.id?.toInt(),
              //       isRecomended: datas?.bestSeller,
              //     );
              //   },
              // )
            ],
          );
  }
}
