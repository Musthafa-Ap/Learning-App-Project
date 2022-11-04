import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/pages/account/widgets/small_heading_account_page.dart';
import 'package:nuox_project/pages/cart/cart_services/cart_services.dart';
import 'package:nuox_project/widgets/bold_heading.dart';
import 'package:provider/provider.dart';

class BuyAllPage extends StatelessWidget {
  BuyAllPage({super.key});
  TextEditingController _coupenController = TextEditingController();
  ValueNotifier _paymentNotifier = ValueNotifier("GPay");
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Checkout"),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(15),
        children: [
          BoldHeading(heading: "Summary"),
          KHeight15,
          ListTile(
            title: Text(
              "Original price",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              "₹${cartProvider.checkoutDetailes!.data!.totalAmount!.toDouble()}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            title: Text(
              "Discounts",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              cartProvider.isCoupenSuccess == true
                  ? "- ₹${cartProvider.coupenDetailes!.discountAmount!.toDouble()}"
                  : "- ₹${cartProvider.checkoutDetailes!.data!.discountAmount!.toDouble()}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text(
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
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          KHeight20,
          cartProvider.isCoupenSuccess == true
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 70),
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.white)),
                  child: Center(
                      child: Row(
                    children: [
                      Spacer(),
                      Text(
                        "Coupen Applied",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      KWidth10,
                      Image.network(
                        "https://cdn.pixabay.com/photo/2014/04/02/11/01/tick-305245__340.png",
                        height: 15,
                      ),
                      Spacer()
                    ],
                  )),
                )
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  padding: EdgeInsets.only(left: 10),
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
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter coupon"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_coupenController.text == null ||
                              _coupenController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.white,
                                content: Text(
                                  "Invalid coupen code",
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
                          decoration: BoxDecoration(
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
          KHeight15,
          BoldHeading(heading: "Select a payment method : "),
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
                      Text(
                        "GPay",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateProperty.all(Colors.white),
                        value: "Cradit/Debit Card",
                        groupValue: value,
                        onChanged: (value) {
                          _paymentNotifier.value = value;
                        },
                      ),
                      Text(
                        "Credit/Debit Card",
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
                      Text(
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
                      Text(
                        "Net Banking",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                ],
              );
            },
          ),
          KHeight20,
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
                } else if (_paymentNotifier.value == "Cradit/Debit Card") {
                  payment = "card";
                } else if (_paymentNotifier.value == "PayPal") {
                  payment = "paypal";
                } else if (_paymentNotifier.value == "Net Banking") {
                  payment = "netbanking";
                }

                if (cartProvider.isCoupenSuccess == true) {
                  print(cartProvider.promo_code);
                  cartProvider.checkoutWithPromo(
                      paymentMode: payment,
                      context: context,
                      promocode: cartProvider.promo_code.toString());
                  print(cartProvider.promo_code);
                } else {
                  print(payment);
                  print("without promo code");
                  cartProvider.checkoutWithoutPromo(
                      paymentMode: payment, context: context);
                }
              },
              child: Text("Checkout"),
            ),
          )
        ],
      ),
    );
  }
}
