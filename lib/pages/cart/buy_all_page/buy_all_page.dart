import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/pages/account/widgets/small_heading_account_page.dart';
import 'package:nuox_project/widgets/bold_heading.dart';

class BuyAllPage extends StatelessWidget {
  BuyAllPage({super.key});
  ValueNotifier _paymentNotifier = ValueNotifier("");
  @override
  Widget build(BuildContext context) {
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
              "₹3499.00",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            title: Text(
              "Discounts",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              "- ₹499.00",
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
              "₹3000.00",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            padding: EdgeInsets.only(left: 10),
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Enter coupon"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("Coupen applied");
                  },
                  child: Container(
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                    child: Center(
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
                        "Cradit/Debit Card",
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
              onPressed: () {},
              child: Text("Checkout"),
            ),
          )
        ],
      ),
    );
  }
}
