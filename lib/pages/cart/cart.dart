import 'package:flutter/material.dart';
import 'package:nuox_project/pages/cart/cart_services/cart_services.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../widgets/course_detailes_list_tile.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

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
        automaticallyImplyLeading: false,
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
                        return CourseDetailesListTile(
                          variantID: datas.section!.id!.toInt(),
                          courseName: datas.courseName.toString(),
                          authorName: datas.autherName.toString(),
                          coursePrice: datas.price!.toDouble(),
                          ratingCount: 100,
                          image: datas.courseimage.toString(),
                          rating: datas.rating!.toDouble(),
                          id: datas.courseId!.toInt(),
                          isCartItem: true,
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
