import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soom_net/screens/home/home_screen.dart';
import '../API/api.dart';
import '../constants.dart';
import '../l10n/locale_keys.g.dart';
import '../size_config.dart';
import 'cart/cart_screen.dart';
import 'details/details_screen.dart';
import 'home/components/icon_btn_with_counter.dart';
import 'package:http/http.dart' as http;

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: 0),
      action,
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static String routeName = "/search_screen";
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool flag = true;
  final _debouncer = Debouncer();
  List response = [];
  List ulist = [];
  List userLists = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          },
        ),
        toolbarHeight: getProportionateScreenHeight(80),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Image.asset(
          context.locale.toString() == 'en'
              ? 'assets/en_logo.png'
              : 'assets/ar_logo.png',
          width: getProportionateScreenWidth(220),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: SizeConfig.screenWidth * 0.70,
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    autofocus: true,
                    onEditingComplete: () {},
                    onSubmitted: (val) {},
                    onChanged: (string) {
                      _debouncer.run(() async {
                        response = await API().searchByModel(string);
                        setState(() {});
                      });
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenWidth(9)),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: "${LocaleKeys.search_product.tr()}",
                        prefixIcon: Icon(Icons.search)),
                  ),
                ),
                IconBtnWithCounter(
                    svgSrc: "assets/icons/sort-svgrepo-com.svg",
                    numOfitem: 0,
                    press: () {
                      response.sort(
                        (a, b) {
                          if (flag) {
                            setState(() {
                              flag = false;
                            });
                            return a
                                .toString()
                                .toLowerCase()
                                .compareTo(b.toString().toLowerCase());
                          } else {
                            setState(() {
                              flag = true;
                            });
                            return b
                                .toString()
                                .toLowerCase()
                                .compareTo(a.toString().toLowerCase());
                          }
                        },
                      );
                      setState(() {});
                    }),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.all(5),
              itemCount: response.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, DetailsScreen.routeName, arguments: {
                              "productId": response[index]['id']
                            });
                          },
                          leading: response[index]['images'].length > 0
                              ? Image.network(
                                  "$URLSTORAGE${response[index]['images'][0]}")
                              : Image.asset(
                                  'assets/images/ps4_console_white_2.png'),
                          title: Text(
                            response[index]['name'],
                            style: TextStyle(fontSize: 16),
                          ),
                          subtitle: Text(
                            response[index]['description'].toString(),
                            maxLines: 2,
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
