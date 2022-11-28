import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../my_home_page.dart';
import '../../../../widgets/course_detailes_list_tile.dart';
import '../../../course_detailed_page/recomendations_services/recomendations_provider.dart';
import '../../services/featured_section/featured_provider.dart';
import '../../widgets/see_all_page_featured.dart';

class SeeAllPageRecommeded extends StatelessWidget {
  const SeeAllPageRecommeded({super.key});

  @override
  Widget build(BuildContext context) {
    final featuredProviders = Provider.of<FeaturedProvider>(context);
    final recommendedProvider = Provider.of<RecomendationsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommended Courses"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                  (route) => false);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        automaticallyImplyLeading: false,
        // actions: [
        //   featuredProviders.sortedCourses == null ||
        //           featuredProviders.sortedCourses!.data!.isEmpty
        //       ? IconButton(
        //           onPressed: () async {
        //             showModalBottomSheet(
        //               backgroundColor: Colors.white,
        //               context: context,
        //               builder: (BuildContext context) {
        //                 return const RangeClass();
        //               },
        //             );
        //           },
        //           icon: const Icon(Icons.sort, size: 28))
        //       : const SizedBox()
        // ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        physics: const BouncingScrollPhysics(),
        itemCount: recommendedProvider.recomendationsCourses?.data?.length,
        itemBuilder: (context, index) {
          final datas = recommendedProvider.recomendationsCourses?.data?[index];
          return CourseDetailesListTile(
            authorName: datas?.instructor?.name.toString(),
            courseName: datas?.courseName.toString(),
            isWishlist: datas?.isWishlist,
            coursePrice: datas?.price!.toDouble(),
            image: datas?.thumbnail?.fullSize.toString(),
            ratingCount: datas?.ratingCount,
            id: datas?.id?.toInt(),
            rating: datas?.rating?.toDouble(),
            isRecomended: datas?.bestSeller,
          );
        },
      ),
    );
  }
}
