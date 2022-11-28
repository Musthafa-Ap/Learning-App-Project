import 'package:flutter/material.dart';
import 'package:nuox_project/pages/featured/sections/recommended_section/see_all_recommended.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants.dart';
import '../../../../widgets/bold_heading.dart';
import '../../../../widgets/see_all_widget.dart';
import '../../../course_detailed_page/recomendations_services/recomendations_provider.dart';
import '../../services/featured_section/featured_provider.dart';
import '../../widgets/small_item_card.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final recommendedProvider = Provider.of<RecomendationsProvider>(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      kHeight15,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const BoldHeading(
            heading: "Recommended",
          ),
          // GestureDetector(
          //   child: const SeeAllWidget(),
          //   onTap: () async {
          //     Provider.of<FeaturedProvider>(context, listen: false)
          //         .sortedCourses = null;

          //     await recommendedProvider.getAll();
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => const SeeAllPageRecommeded()));
          //   },
          // ),
        ],
      ),
      recommendedProvider.isRecLoading == true
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              height: size * .60,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: recommendedProvider
                          .recomendationsCourses?.data?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final data = recommendedProvider
                            .recomendationsCourses?.data?[index];
                        return SmallItemCard(
                          refresh: true,
                          id: data?.id,
                          isWishlist: data?.isWishlist,
                          image: data?.thumbnail?.fullSize.toString(),
                          rating: data?.rating?.toDouble(),
                          authorName: data?.instructor?.name.toString(),
                          courseName: data?.courseName.toString(),
                          coursePrice: data?.price,
                          ratingCount: data?.ratingCount,
                          isBestSeller: data?.bestSeller,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    ]);
  }
}
