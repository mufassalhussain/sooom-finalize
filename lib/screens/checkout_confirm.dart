import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soom_net/constants.dart';
import 'package:soom_net/screens/home/home_screen.dart';
import '../../size_config.dart';
import '../API/api.dart';
import '../components/default_button.dart';
import '../l10n/locale_keys.g.dart';
import '../models/CheckoutCalculate.dart';
import 'cart/cart_screen.dart';

class CheckoutConfirmation extends StatefulWidget {
  static String routeName = "/checkout_confirmation";

  @override
  State<CheckoutConfirmation> createState() => _CheckoutConfirmationState();
}

class _CheckoutConfirmationState extends State<CheckoutConfirmation> {
  final _formKey = GlobalKey<FormState>();

  bool showItems = false;
  var productList = [];
  CheckoutCalculate? calculation;
  var cartMap = {};
  bool onceRun = true;
  var productName = [];
  double total = 0.0;
  bool loading = false;
  var img = [];
  var quantityProduct = [];
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController address = TextEditingController();
  Map fieldMap = {};
  getCalculation(productList) async {
    calculation = await API().getCheckoutCalculation(productList);
    setState(() {
      total = calculation!.amount! + calculation!.tax! + calculation!.spipping!;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  getCartItems() async {
    try {
      cartMap.forEach((key, value) {
        Map<String, dynamic> cartDetail = json.decode(cartMap[key]);
        productName.add(cartDetail[
            context.locale.toString() == 'en' ? 'productName' : 'arabicName']);
        img.add(cartDetail['image']);
        quantityProduct.add(cartDetail['quanitity']);
      });

      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    var checkOutItem = ModalRoute.of(context)!.settings.arguments as Map;
    if (onceRun) {
      productList = checkOutItem['checkoutList'] as List;
      cartMap = checkOutItem['MapCart'] as Map;
      getCartItems();
      getCalculation(productList);
      setState(() {
        onceRun = false;
      });
    }
    return Scaffold(
        appBar: buildAppBar(context),
        body: calculation != null
            ? ModalProgressHUD(
                inAsyncCall: loading,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: getProportionateScreenHeight(50),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: TextFormField(
                                    controller: name,
                                    keyboardType: TextInputType.text,
                                    onSaved: (newValue) {},
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Name is empty';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        focusColor: kPrimaryColor,
                                        labelText: "${LocaleKeys.name.tr()}",
                                        hintText:
                                            "${LocaleKeys.enter_your_name.tr()}",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        suffixIcon: Icon(Icons.person)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    controller: phone,
                                    keyboardType: TextInputType.phone,
                                    onSaved: (newValue) {},
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Phone is empty';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        focusColor: kPrimaryColor,
                                        labelText: "Phone",
                                        hintText: "Enter your phone",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        suffixIcon: Icon(Icons.phone)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    controller: email,
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (newValue) {},
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Email is empty';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      focusColor: kPrimaryColor,
                                      labelText: "${LocaleKeys.email.tr()}",
                                      hintText:
                                          "${LocaleKeys.enter_your_email.tr()}",
                                      suffixIcon: Icon(Icons.email),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(5.0),
                                //   child: TextFormField(
                                //     validator: (text) {
                                //       if (text == null || text.isEmpty) {
                                //         return 'Please select country';
                                //       }
                                //       return null;
                                //     },
                                //     controller: country,
                                //     onTap: () {
                                //       showCountryPicker(
                                //         context: context,
                                //         showPhoneCode:
                                //             true, // optional. Shows phone code before the country name.
                                //         onSelect: (Country selectCountry) {
                                //           country.text = selectCountry.name;
                                //         },
                                //       );
                                //     },
                                //     keyboardType: TextInputType.none,
                                //     onSaved: (newValue) {},
                                //     decoration: InputDecoration(
                                //       focusColor: kPrimaryColor,
                                //       labelText: "Country",
                                //       suffixIcon: Icon(Icons.flag),
                                //       hintText: "Enter your country",
                                //       floatingLabelBehavior:
                                //           FloatingLabelBehavior.always,
                                //     ),
                                //   ),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.all(5.0),
                                //   child: TextFormField(
                                //     controller: city,
                                //     keyboardType: TextInputType.text,
                                //     onSaved: (newValue) {},
                                //     validator: (text) {
                                //       if (text == null || text.isEmpty) {
                                //         return 'Please enter your city';
                                //       }
                                //       return null;
                                //     },
                                //     decoration: InputDecoration(
                                //       focusColor: kPrimaryColor,
                                //       suffixIcon: Icon(Icons.location_city),
                                //       labelText: "City",
                                //       hintText: "Enter your city",
                                //       floatingLabelBehavior:
                                //           FloatingLabelBehavior.always,
                                //     ),
                                //   ),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.all(5.0),
                                //   child: TextFormField(
                                //     controller: zipcode,
                                //     keyboardType: TextInputType.text,
                                //     onSaved: (newValue) {},
                                //     validator: (text) {
                                //       if (text == null || text.isEmpty) {
                                //         return 'Please enter zipcode';
                                //       }
                                //       return null;
                                //     },
                                //     decoration: InputDecoration(
                                //       focusColor: kPrimaryColor,
                                //       suffixIcon: Icon(Icons.numbers),
                                //       labelText: "Zip Code",
                                //       hintText: "Enter zip code",
                                //       floatingLabelBehavior:
                                //           FloatingLabelBehavior.always,
                                //     ),
                                //   ),
                                // ),

                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    controller: address,
                                    keyboardType: TextInputType.text,
                                    onSaved: (newValue) {},
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Please enter your address';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      focusColor: kPrimaryColor,
                                      suffixIcon: Icon(Icons.location_city),
                                      labelText: "Address",
                                      hintText: "Enter your address",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(10),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Card(
                                    elevation: 1,
                                    child: ListTile(
                                      leading: ImageIcon(
                                        AssetImage(
                                          'assets/cod.png',
                                        ),
                                        size: 50,
                                        color: Colors.blue,
                                      ),
                                      title: Text(
                                        "Cash on delivery",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Radio(
                                        value: false,
                                        activeColor: Colors.blue,
                                        groupValue: false,
                                        onChanged: (val) {},
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(30),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Table(
                            children: [
                              TableRow(children: [
                                Column(children: [
                                  Text(
                                    "Sub-Total:",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ]),
                                Column(children: [
                                  Text(
                                    calculation!.amount!.toStringAsFixed(2) +
                                        " SR",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                              ]),
                              TableRow(children: [
                                Column(children: [
                                  Text(
                                    "Tax:",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ]),
                                Column(children: [
                                  Text(
                                    calculation!.tax!.toStringAsFixed(2) +
                                        " SR",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                              ]),
                              TableRow(children: [
                                Column(children: [
                                  Text("Shipping Price:",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      )),
                                ]),
                                Column(children: [
                                  Text(
                                    calculation!.spipping!.toStringAsFixed(2) +
                                        " SR",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                              ]),
                              TableRow(children: [
                                Column(children: [
                                  Text(
                                    "Total:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                                Column(children: [
                                  Text(
                                    total.toStringAsFixed(2) + " SR\n",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                              ])
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          DefaultButton(
                              text: "Proceed",
                              press: () async {
                                if (productList != []) {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    try {
                                      fieldMap['cart'] = productList;
                                      fieldMap['name'] = name.text;
                                      fieldMap['phone'] = phone.text;
                                      fieldMap['email'] = email.text;
                                      // fieldMap['country'] = country.text;
                                      // fieldMap['state'] = state.text;
                                      // fieldMap['city'] = city.text;
                                      // fieldMap['zip_code'] = zipcode.text;
                                      fieldMap['address'] = address.text;
                                      var response =
                                          await API().proceedCart(fieldMap);

                                      if (response.statusCode == 200) {
                                        var shared = await SharedPreferences
                                            .getInstance();
                                        shared.setString(
                                            'cart', json.encode({}));
                                        AwesomeDialog(
                                          context: context,
                                          animType: AnimType.leftSlide,
                                          headerAnimationLoop: false,
                                          dialogType: DialogType.success,
                                          showCloseIcon: true,
                                          title:
                                              "Your odrer is successfully placed",
                                          desc:
                                              "Thank you for purchasing our products!",
                                          btnOkOnPress: () {
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                HomeScreen.routeName,
                                                (route) => false);
                                          },
                                          btnOkText: "OK",
                                          btnOkIcon: Icons.check_circle,
                                        ).show();
                                      } else {}
                                    } catch (e) {
                                      AwesomeDialog(
                                        context: context,
                                        animType: AnimType.leftSlide,
                                        headerAnimationLoop: false,
                                        dialogType: DialogType.success,
                                        showCloseIcon: true,
                                        title: "Something went wrong",
                                        desc: "Failed to place the order",
                                        btnOkOnPress: () {},
                                        btnOkText: "OK",
                                        btnOkIcon: Icons.check_circle,
                                        onDismissCallback: (type) {},
                                      ).show();
                                    }
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                }
                              }),
                          SizedBox(
                            width: getProportionateScreenHeight(220),
                          ),
                        ]))),
              )
            : Center(child: spinkit));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, CartScreen.routeName);
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              AwesomeDialog(
                context: context,
                animType: AnimType.topSlide,
                headerAnimationLoop: false,
                body: Column(children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.all(5),
                      itemCount: productName.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.network(URLSTORAGE + img[index]),
                            title: Text(productName.toString()),
                            subtitle: Text(" x${quantityProduct[index]}",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                        );
                      })
                ]),
                dialogType: DialogType.info,
                showCloseIcon: true,
                btnOkOnPress: () {},
                onDismissCallback: (type) {},
              ).show();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.preview, color: kPrimaryColor),
                  Text(
                    !showItems ? "Preview Products" : "Hide Products",
                    style: TextStyle(color: kPrimaryColor),
                  )
                ],
              ),
            ),
          )
        ],
        title: Text(
          "Confirmation",
          style: TextStyle(color: Colors.black),
        ));
  }
}
