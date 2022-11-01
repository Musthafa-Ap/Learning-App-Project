import 'package:flutter/material.dart';
import 'package:nuox_project/pages/cart/buy_all_page/buy_all_page.dart';
import 'package:nuox_project/pages/cart/cart_services/cart_services.dart';
import 'package:nuox_project/pages/featured/sections/catagories_section/see_all_catagories.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../widgets/course_detailes_list_tile.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getAllCartItems();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Course cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: cartProvider.cartItems!.data!.cartItem!.isEmpty
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
                        return CourseDetailesListTile(
                            variantID: datas.section!.id!.toInt(),
                            courseName: datas.courseName.toString(),
                            authorName: datas.autherName.toString(),
                            coursePrice: datas.price!.toDouble(),
                            image: datas.courseimage.toString(),
                            rating: datas.rating!.toDouble(),
                            id: datas.courseId!.toInt(),
                            isCartItem: true);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: cartProvider.cartItems!.data!.cartItem!.isEmpty
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BuyAllPage()));
                              },
                              child: Text(
                                cartProvider.cartItems!.data!.cartItem!
                                            .length ==
                                        1
                                    ? "Buy Item"
                                    : "Buy All",
                                style: TextStyle(fontSize: 20),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.purple)),
                            ),
                          ),
                  ),
                  KHeight
                ],
              ),
      ),
    );
  }
}
