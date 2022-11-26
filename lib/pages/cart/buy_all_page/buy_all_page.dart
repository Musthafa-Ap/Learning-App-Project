import 'package:flutter/material.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/pages/cart/cart_services/cart_services.dart';
import 'package:nuox_project/widgets/bold_heading.dart';
import 'package:provider/provider.dart';

class BuyAllPage extends StatelessWidget {
  BuyAllPage({super.key});
  final TextEditingController _coupenController = TextEditingController();
  final ValueNotifier _paymentNotifier = ValueNotifier("GPay");
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text("Checkout"),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15),
        children: [
          const BoldHeading(heading: "Summary"),
          kHeight15,
          ListTile(
            title: const Text(
              "Original price",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              "₹${cartProvider.checkoutDetailes!.data!.totalAmount!.toDouble()}",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            title: const Text(
              "Discounts",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              cartProvider.isCoupenSuccess == true
                  ? "- ₹${cartProvider.coupenDetailes!.discountAmount!.toDouble()}"
                  : "- ₹${cartProvider.checkoutDetailes!.data!.discountAmount!.toDouble()}",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: const Text(
              "Total:",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            trailing: Text(
              cartProvider.isCoupenSuccess == true
                  ? "₹${cartProvider.coupenDetailes!.grandTotal!.toDouble()}"
                  : "₹${cartProvider.checkoutDetailes!.data!.grandTotal!.toDouble()}",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          kheight20,
          cartProvider.isCoupenSuccess == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        // width: 70,
                        margin: const EdgeInsets.only(left: 10),
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white)),
                        child: Center(
                            child: Row(
                          children: [
                            const Spacer(),
                            const Text(
                              "Coupon Applied",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            kWidth10,
                            Image.network(
                              "https://cdn.pixabay.com/photo/2014/04/02/11/01/tick-305245__340.png",
                              height: 15,
                            ),
                            const Spacer()
                          ],
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        cartProvider.cancelCoupen(context: context);
                        _coupenController.text = "";
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Center(
                          child: cartProvider.cancelPromoLoading == true
                              ? const CircularProgressIndicator()
                              : const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.purple),
                                  textAlign: TextAlign.center,
                                ),
                        ),
                      ),
                    )
                  ],
                )
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  padding: const EdgeInsets.only(left: 10),
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _coupenController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter coupon"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_coupenController.text.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    duration: Duration(milliseconds: 600),
                                    backgroundColor: Colors.white,
                                    content: Text(
                                      "Invalid coupon code",
                                      style: TextStyle(color: Colors.black),
                                    )));
                          } else {
                            cartProvider.coupenApply(
                                coupen: _coupenController.text,
                                context: context);
                          }
                        },
                        child: Container(
                          width: 70,
                          decoration: const BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5))),
                          child: cartProvider.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const Center(
                                  child: Text(
                                  "Apply",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                        ),
                      )
                    ],
                  )),
                ),
          kHeight15,
          const BoldHeading(heading: "Select a payment method : "),
          ValueListenableBuilder(
            valueListenable: _paymentNotifier,
            builder: (context, value, child) {
              return Column(
                children: [
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateProperty.all(Colors.white),
                        value: "GPay",
                        groupValue: value,
                        onChanged: (value) {
                          _paymentNotifier.value = value;
                        },
                      ),
                      const Text(
                        "GPay",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateProperty.all(Colors.white),
                        value: "Credit Card",
                        groupValue: value,
                        onChanged: (value) {
                          _paymentNotifier.value = value;
                        },
                      ),
                      const Text(
                        "Credit Card",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateProperty.all(Colors.white),
                        value: "Debit Card",
                        groupValue: value,
                        onChanged: (value) {
                          _paymentNotifier.value = value;
                        },
                      ),
                      const Text(
                        "Debit Card",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateProperty.all(Colors.white),
                        value: "PayPal",
                        groupValue: value,
                        onChanged: (value) {
                          _paymentNotifier.value = value;
                        },
                      ),
                      const Text(
                        "PayPal",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateProperty.all(Colors.white),
                        value: "Net Banking",
                        groupValue: value,
                        onChanged: (value) {
                          _paymentNotifier.value = value;
                        },
                      ),
                      const Text(
                        "Net Banking",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                ],
              );
            },
          ),
          kheight20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                    vertical: 15,
                  )),
                  backgroundColor: const MaterialStatePropertyAll(
                    Colors.purple,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  )),
              onPressed: () {
                var payment;
                if (_paymentNotifier.value == "GPay") {
                  payment = "gpay";
                } else if (_paymentNotifier.value == "Credit Card") {
                  payment = "card";
                } else if (_paymentNotifier.value == "PayPal") {
                  payment = "paypal";
                } else if (_paymentNotifier.value == "Net Banking") {
                  payment = "netbanking";
                } else if (_paymentNotifier.value == "Debit Card") {
                  payment = "debit_card";
                }

                if (cartProvider.isCoupenSuccess == true) {
                  cartProvider.checkoutWithPromo(
                      paymentMode: payment,
                      context: context,
                      promocode: cartProvider.promo_code.toString());
                } else {
                  cartProvider.checkoutWithoutPromo(
                      paymentMode: payment, context: context);
                }
              },
              child: const Text("Checkout"),
            ),
          )
        ],
      ),
    );
  }
}
