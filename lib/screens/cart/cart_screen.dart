import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soom_net/constants.dart';
import 'package:soom_net/models/Cart.dart';
import 'package:soom_net/models/ProductDetails.dart';
import 'package:soom_net/screens/checkout_confirm.dart';

import '../../API/api.dart';
import '../../components/default_button.dart';
import '../../size_config.dart';
import '../home/home_screen.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var once = true;
  var quantityProduct = [];
  var prices = [];
  var shippingPrice = [];
  var MapCart = {};
  var total = 0.0;
  List cartList = [];
  List checkoutItems = [];
  getCartItems() async {
    try {
      var shared = await SharedPreferences.getInstance();
      var item = shared.getString('cart');
      MapCart = json.decode(item!);
      MapCart.forEach((key, value) {
        Map<String, dynamic> cartDetail = json.decode(MapCart[key]);
        quantityProduct.add(cartDetail['quanitity']);
        prices.add(cartDetail['price']);
        shippingPrice.add(cartDetail['shippingPrice']);
        cartList.add(key);
      });
      getTotal();
      setState(() {});
    } catch (e) {}
  }

  removeProduct(index, cartDetail) async {
    try {
      if (quantityProduct[index] > 1) {
        quantityProduct[index] = quantityProduct[index] - 1;

        cartDetail['quanitity'] = quantityProduct[index];
        MapCart[cartList[index]] = json.encode(cartDetail);

        var shared = await SharedPreferences.getInstance();
        shared.setString('cart', json.encode(MapCart));
        // if (quantityProduct < quantityProduct) {
        total = 0.0;
        getTotal();
        setState(() {});
      }
    } catch (e) {}
  }

  addProduct(index, cartDetail) async {
    try {
      if (quantityProduct[index] < int.parse(cartDetail['maxQuantity'])) {
        quantityProduct[index] = quantityProduct[index] + 1;
        cartDetail['quanitity'] = quantityProduct[index];
        MapCart[cartList[index]] = json.encode(cartDetail);

        var shared = await SharedPreferences.getInstance();
        shared.setString('cart', json.encode(MapCart));
        //
        total = 0.0;
        getTotal();
        setState(() {});
      }
    } catch (e) {}
  }

  getTotal() {
    try {
      for (int index = 0; index < cartList.length; index++) {
        total = total +
            ((prices[index] != "0.00" ? double.parse(prices[index]) : 1) *
                    quantityProduct[index] +
                (shippingPrice[index] != "0.00"
                    ? double.parse(shippingPrice[index])
                    : 0));
      }
    } catch (e) {}
  }

  @override
  void initState() {
    getCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: ListView.builder(
          itemCount: cartList.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> cartDetail = {};
            try {
              cartDetail = json.decode(MapCart[cartList[index]]);
            } catch (e) {}

            return Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Dismissible(
                    key: Key(cartList[index]),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) async {
                      try {
                        total = total -
                            ((prices[index] != "0.00"
                                        ? double.parse(prices[index])
                                        : 1) *
                                    quantityProduct[index] +
                                (shippingPrice[index] != "0.00"
                                    ? double.parse(shippingPrice[index])
                                    : 0));
                        var shared = await SharedPreferences.getInstance();
                        MapCart.remove(cartList[index]);
                        cartList.removeAt(index);
                        shared.setString('cart', json.encode(MapCart));
                        setState(() {});
                      } catch (e) {}
                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          SvgPicture.asset("assets/icons/Trash.svg"),
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 88,
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                              padding: EdgeInsets.all(
                                  getProportionateScreenWidth(10)),
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F6F9),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image.network(
                                  URLSTORAGE + cartDetail["image"]),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: getProportionateScreenWidth(200),
                              child: Text(
                                context.locale.toString() == 'en'
                                    ? cartDetail['productName']
                                    : cartDetail['arabicName'],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                maxLines: 4,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "${cartDetail["price"]} SR",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryColor),
                                    children: [
                                      TextSpan(
                                          text: " x${quantityProduct[index]}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      removeProduct(index, cartDetail);
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                      color: kPrimaryColor,
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      await addProduct(index, cartDetail);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: kPrimaryColor,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )));
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(15),
          horizontal: getProportionateScreenWidth(30),
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: getProportionateScreenWidth(40),
                    width: getProportionateScreenWidth(40),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                  Spacer(),
                  Text("Add voucher code"),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kTextColor,
                  )
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: total.toString(),
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(190),
                    child: DefaultButton(
                      text: "Check Out",
                      press: () {
                        checkoutItems = [];

                        for (int i = 0; i < cartList.length; i++) {
                          checkoutItems.add({
                            "product_id": cartList[i],
                            "quantity": quantityProduct[i]
                          });
                        }
                        if (checkoutItems.isNotEmpty) {
                          Navigator.pushNamed(
                              context, CheckoutConfirmation.routeName,
                              arguments: {
                                "checkoutList": checkoutItems,
                                "MapCart": MapCart
                              });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('No product in cart!'),
                          ));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.routeName);
          },
          icon: Icon(Icons.arrow_back_ios_sharp)),
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${cartList.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
