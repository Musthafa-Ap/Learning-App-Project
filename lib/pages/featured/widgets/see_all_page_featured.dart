import 'package:flutter/material.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/pages/featured/services/catagories_section/catagories_provider.dart';
import 'package:nuox_project/pages/featured/services/featured_section/featured_provider.dart';
import 'package:nuox_project/widgets/course_detailes_list_tile.dart';
import 'package:provider/provider.dart';

class SeeAllPageFeatured extends StatelessWidget {
  final bool fromSubCatagories;
  const SeeAllPageFeatured({super.key, this.fromSubCatagories = false});

  @override
  Widget build(BuildContext context) {
    final featuredProvider = Provider.of<FeaturedProvider>(context).auto;
    final featuredProviders = Provider.of<FeaturedProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: fromSubCatagories ? null : const Text("Featured"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        automaticallyImplyLeading: false,
        actions: [
          featuredProviders.sortedCourses == null ||
                  featuredProviders.sortedCourses!.data!.isEmpty
              ? IconButton(
                  onPressed: () async {
                    showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (BuildContext context) {
                        return const RangeClass();
                      },
                    );
                  },
                  icon: const Icon(Icons.sort, size: 28))
              : const SizedBox()
        ],
      ),
      body: featuredProviders.sortedCourses == null ||
              featuredProviders.sortedCourses!.data!.isEmpty
          ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              physics: const BouncingScrollPhysics(),
              itemCount: featuredProvider.length,
              itemBuilder: (context, index) {
                final data = featuredProvider[index];
                return CourseDetailesListTile(
                  authorName: data!.instructor!.name.toString(),
                  courseName: data.courseName.toString(),
                  image: data.thumbnail!.full_size.toString(),
                  ratingCount: data.ratingCount,
                  coursePrice: data.price!,
                  id: data.id!,
                  rating: data.rating!.toDouble(),
                  isRecomended: data.recommendedCourse!,
                );
              },
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              physics: const BouncingScrollPhysics(),
              itemCount: featuredProviders.sortedCourses!.data!.length,
              itemBuilder: (context, index) {
                final datas = featuredProviders.sortedCourses!.data![index];
                return CourseDetailesListTile(
                  authorName: datas.instructor!.name.toString(),
                  courseName: datas.courseName.toString(),
                  image: datas.thumbnail!.fullSize.toString(),
                  coursePrice: datas.price,
                  id: datas.id!,
                  ratingCount: datas.ratingCount,
                  rating: datas.rating!.toDouble(),
                  isRecomended: datas.recommendedCourse!,
                );
              },
            ),
    );
  }
}

ValueNotifier<int> catagoryNotifier = ValueNotifier(0);

class RangeClass extends StatefulWidget {
  const RangeClass({super.key});

  @override
  State<RangeClass> createState() => _RangeClassState();
}

class _RangeClassState extends State<RangeClass> {
  RangeValues values = const RangeValues(500, 30000);
  RangeLabels labels = const RangeLabels('500', '30000');
  int minPrice = 500;
  int maxPrice = 30000;
  @override
  Widget build(BuildContext context) {
    final featuredProvider = Provider.of<FeaturedProvider>(context);
    final catagoryProvider = Provider.of<CatagoriesProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(.5)),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kHeight5,
            Center(
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(5)),
              ),
            ),
            kHeight15,
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Price range",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Text(
                    "₹500",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Expanded(
                    child: RangeSlider(
                        activeColor: Colors.purple,
                        inactiveColor: Colors.white,
                        min: 1,
                        max: 30000,
                        divisions: 15,
                        values: values,
                        labels: labels,
                        onChanged: (value) {
                          setState(() {
                            minPrice = value.start.toInt();
                            maxPrice = value.end.toInt();
                            values = value;
                            labels = RangeLabels(value.start.toInt().toString(),
                                value.end.toInt().toString());
                          });
                        }),
                  ),
                  const Text(
                    "₹30000",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            kHeight15,
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Catagory type",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: catagoryProvider.catagoriesList!.data!.length,
                itemBuilder: (context, index) {
                  final datas = catagoryProvider.catagoriesList!.data![index];
                  return RadioListTile(
                    catagoryName: datas.categoryName.toString(),
                    id: datas.id,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 15)),
                          backgroundColor: const MaterialStatePropertyAll(
                            Colors.purple,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          )),
                      onPressed: () {
                        if (catagoryNotifier.value == 0) {
                          featuredProvider.getSortedCourses(
                              context: context,
                              minPrice: minPrice.toString(),
                              maxPrice: maxPrice.toString());
                        } else {
                          featuredProvider.getSortedCourses(
                              context: context,
                              minPrice: minPrice.toString(),
                              maxPrice: maxPrice.toString(),
                              catagoryID: catagoryNotifier.value.toString());
                        }
                      },
                      child: const Text("Filter"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RadioListTile extends StatelessWidget {
  final id;
  final String catagoryName;
  const RadioListTile({
    Key? key,
    required this.catagoryName,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: catagoryNotifier,
      builder: (context, value, child) {
        return Row(
          children: [
            Radio(
                fillColor: MaterialStateProperty.all(Colors.white),
                value: id,
                groupValue: value,
                onChanged: (value) {
                  catagoryNotifier.value = value;
                }),
            Text(
              catagoryName,
              style: const TextStyle(color: Colors.white),
            )
          ],
        );
      },
    );
  }
}
