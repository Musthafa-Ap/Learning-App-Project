import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/pages/search/services/search_provider.dart';
import 'package:nuox_project/widgets/bold_heading.dart';
import 'package:provider/provider.dart';
import '../course_detailed_page/course_detailed_page.dart';
import '../course_detailed_page/services/course_detailed_provider.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoSearchTextField(
              onChanged: (value) {
                searchProvider.getSearchItems(key: value);
                searchProvider.searchList;
              },
              backgroundColor: Colors.grey.withOpacity(.4),
              prefixIcon: const Icon(
                CupertinoIcons.search,
                color: Colors.grey,
              ),
              suffixIcon: const Icon(
                CupertinoIcons.xmark,
                color: Colors.white,
              ),
              style: const TextStyle(color: Colors.white),
            ),
            kHeight,
            const BoldHeading(heading: "Browse Catagories"),
            kHeight,
            Expanded(
              child: searchProvider.notFound != null
                  ? const Center(
                      child: Text(
                      "No course found",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ))
                  : searchProvider.searchList?.data == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 20,
                                  crossAxisCount: 2,
                                  childAspectRatio: 1 / 1.1),
                          itemCount: searchProvider.searchList!.data!.length,
                          itemBuilder: (context, index) {
                            final datas =
                                searchProvider.searchList?.data?[index];
                            return SearchCard(
                              authorName: datas?.instructor?.name.toString(),
                              courseName: datas?.courseName.toString(),
                              coursePrice: datas?.price.toString(),
                              image: datas?.thumbnail?.fullSize.toString(),
                              id: datas!.id!.toInt(),
                            );
                          },
                        ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchCard extends StatelessWidget {
  final String? courseName;
  final String? coursePrice;
  final String? authorName;
  final String? image;
  final int id;
  const SearchCard(
      {super.key,
      required this.image,
      required this.id,
      required this.courseName,
      required this.authorName,
      required this.coursePrice});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Provider.of<CourseDetailedProvider>(context, listen: false)
            .getAll(courseID: id);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CourseDetailedPage()));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      image!,
                    ),
                    fit: BoxFit.fill),
              ),
            ),
            kHeight5,
            Text(
              courseName ?? "Course Name",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "₹${coursePrice ?? "₹3000"}",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              authorName ?? "Author Name",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
