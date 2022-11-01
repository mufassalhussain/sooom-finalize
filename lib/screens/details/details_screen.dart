import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soom_net/API/api.dart';
import 'package:soom_net/constants.dart';
import 'package:soom_net/models/ProductDetails.dart';

import '../../components/default_button.dart';
import '../../models/Product.dart';
import '../../size_config.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';
import 'components/top_rounded_container.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool once = true;
  var quanitity = 1;
  ProductDetail? product = null;
  getProductDetails(id) async {
    product = await API().getProductDetail(id);
    setState(() {
      once = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var agrs = ModalRoute.of(context)!.settings.arguments as Map;
    if (once) {
      getProductDetails(agrs['productId']);
    }
    return product != null
        ? Scaffold(
            backgroundColor: Color(0xFFF5F6F9),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child: product != null
                  ? CustomAppBar(
                      rating: product!.data!.productRating != null
                          ? double.parse(product!.data!.productRating!)
                          : 0.0)
                  : SizedBox.shrink(),
            ),
            bottomNavigationBar: TopRoundedContainer(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.15,
                  right: SizeConfig.screenWidth * 0.15,
                  bottom: getProportionateScreenWidth(40),
                  top: getProportionateScreenWidth(15),
                ),
                child: DefaultButton(
                  text: "Add To Cart",
                  press: () async {
                    var prevQuantity = 0;
                    var available = 0;
                    var shared = await SharedPreferences.getInstance();

                    try {
                      var item = json.decode(shared.getString(
                        'cart',
                      )!);
                      prevQuantity = json.decode(
                          item[agrs['productId'].toString()])['quanitity'];
                    } catch (e) {}
                    available = int.parse(product!.data!.quantity!.toString()) -
                        prevQuantity;
                    if (product != null) {
                      if (available != 0) {
                        quanitity = 1;
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.leftSlide,
                          headerAnimationLoop: false,
                          dialogType: DialogType.infoReverse,
                          showCloseIcon: true,
                          btnOkIcon: Icons.shopping_cart,
                          btnOkOnPress: () async {
                            shared = await SharedPreferences.getInstance();
                            Map<String, dynamic> productMap = {};
                            var prevQuantity = 0;
                            var item = shared.getString(
                                  'cart',
                                ) ??
                                '';

                            if (item.isNotEmpty && item != '') {
                              try {
                                productMap = jsonDecode(item);
                                prevQuantity = json.decode(productMap[
                                    agrs['productId'].toString()])['quanitity'];
                              } catch (e) {}
                            }
                            Map<String, dynamic> productDetailMap = {
                              "quanitity": quanitity + prevQuantity,
                              "productName": product!.data!.name,
                              "arabicName": product!.data!.arabicName,
                              "image": product!.data!.images![0],
                              "price": product!.data!.price,
                              "shippingPrice": product!.data!.shippingPrice,
                              "taxId": product!.data!.taxId,
                              "maxQuantity": product!.data!.quantity,
                            };

                            productMap[agrs['productId'].toString()] =
                                json.encode(productDetailMap);

                            shared.setString('cart', json.encode(productMap));

                            AwesomeDialog(
                              context: context,
                              animType: AnimType.leftSlide,
                              headerAnimationLoop: false,
                              dialogType: DialogType.success,
                              showCloseIcon: true,
                              title: 'Success',
                              desc: 'Product added to cart',
                              btnOkOnPress: () {
                                Navigator.pushNamed(context, '/cart');
                              },
                              btnCancelText: "Shop more",
                              btnCancelOnPress: () {},
                              btnOkText: "Go to cart",
                              btnCancelIcon: Icons.cancel,
                              btnOkIcon: Icons.shop,
                              onDismissCallback: (type) {},
                            ).show();
                          },
                          btnOkText: 'Add Item',
                          body: StatefulBuilder(
                              builder: (dialogContext, setState) {
                            return Container(
                              child: Column(children: [
                                Text(
                                  "Available Quanity : $available\n",
                                  style: TextStyle(
                                      fontFamily: 'Muli',
                                      color: kPrimaryLightColor,
                                      fontSize:
                                          getProportionateScreenWidth(20)),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Quanity: \t",
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            if (quanitity > 1) {
                                              setState(() {
                                                quanitity = quanitity - 1;
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            Icons.remove,
                                            color: kPrimaryColor,
                                          )),
                                      Card(
                                          child: Container(
                                        width: getProportionateScreenWidth(30),
                                        child: Text(
                                          quanitity.toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                      IconButton(
                                          onPressed: () {
                                            if (quanitity < available) {
                                              setState(() {
                                                quanitity = quanitity + 1;
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            color: kPrimaryColor,
                                          )),
                                    ]),
                              ]),
                            );
                          }),
                          desc: 'Available Quantity : 0',
                          onDismissCallback: (type) {},
                        ).show();
                      } else {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.leftSlide,
                          headerAnimationLoop: false,
                          dialogType: DialogType.info,
                          showCloseIcon: true,
                          title: 'Item not available',
                          desc: 'Available Quantity : 0',
                          onDismissCallback: (type) {},
                        ).show();
                      }
                    }
                  },
                ),
              ),
            ),
            body: Body(product: product!))
        : Scaffold(
            body: Center(child: spinkit),
          );
  }
}
