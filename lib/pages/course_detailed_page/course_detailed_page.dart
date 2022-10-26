import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/pages/review_page/review_page.dart';
import 'package:nuox_project/widgets/bestseller.dart';
import 'package:nuox_project/widgets/bold_heading.dart';
import 'package:share_plus/share_plus.dart';

import '../../widgets/course_detailes_list_tile.dart';

class CourseDetailedPage extends StatelessWidget {
  CourseDetailedPage({super.key});
  ValueNotifier _selectedValue = ValueNotifier("Medium");
  var _items = ["Easy", "Medium", "Advanced"];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
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
                    image: NetworkImage(
                        "https://i.guim.co.uk/img/media/71dd7c5b208e464995de3467caf9671dc86fcfd4/1176_345_3557_2135/master/3557.jpg?width=620&quality=45&dpr=2&s=none"))),
          ),
          KHeight15,
          BoldHeading(
              heading: "Complete Guitar Lessons System - Beginner to Advanced"),
          KHeight5,
          Text(
            "All-in-one Guitar Course,FingerStyle Guitar,Blues Guitar,Acoustic Guitar,Electric Guitar & Fingerpicking Guitarra",
            style: TextStyle(color: Colors.white),
          ),
          KHeight,
          Align(alignment: Alignment.centerLeft, child: BestsellerWidget()),
          KHeight,
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ReviewPage()));
            },
            child: Text(
              "4.6 *****",
              style: TextStyle(fontSize: 12, color: Colors.yellow),
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
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        (value == "Easy")
                            ? "₹399"
                            : (value == "Medium")
                                ? "₹499"
                                : "₹699",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 27),
                      ),
                      KWidth10,
                      Text(
                        "₹3499",
                        style: const TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                    padding: EdgeInsets.only(
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
                                    style: TextStyle(color: Colors.black))))
                            .toList(),
                        onChanged: (newValue) {
                          _selectedValue.value = newValue;
                        }),
                  )
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
                "Erich Andreas",
                style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )
            ],
          ),
          KHeight,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75),
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Buy now"),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22))),
                    backgroundColor: MaterialStateProperty.all(Colors.purple)),
              ),
            ),
          ),
          KHeight,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75),
            child: SizedBox(
              height: 50,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22))),
                    side: MaterialStateProperty.all(const BorderSide(
                      color: Colors.white,
                    ))),
              ),
            ),
          ),
          KHeight15,
          const BoldHeading(heading: "Recommendations"),
          ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: 8,
            itemBuilder: (context, index) {
              return CourseDetailesListTile();
            },
          ),
        ],
      ),
    );
  }
}
