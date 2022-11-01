import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soom_net/constants.dart';
import 'package:soom_net/models/Advertisement.dart';
import 'package:soom_net/models/Catagories.dart';
import 'package:soom_net/models/MostSelling.dart';
import 'package:soom_net/screens/home/components/brands.dart';
import 'package:soom_net/screens/home/components/brands.dart';
import 'package:soom_net/screens/home/components/section_title.dart';

import '../../../API/api.dart';
import '../../../API/api_streams.dart';
import '../../../l10n/locale_keys.g.dart';
import '../../../models/Brands.dart';
import '../../../size_config.dart';
import '../../explore_seller.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var cartcounter = 0;
  getCartCounter() async {
    var shared = await SharedPreferences.getInstance();
    var item = shared.getString('cart') ?? null;
    if (item != null) {
      setState(() {
        cartcounter = json.decode(item).length;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  subscribeToNotification() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getString('userId');
    print("SUBSCRIBED NOTIFICATION WITH USER ID $userId");
    FirebaseMessaging.instance.subscribeToTopic("$userId");
  }

  @override
  void initState() {
    subscribeToNotification();
    getCartCounter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(
              counter: cartcounter,
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  getProportionateScreenWidth(240), 0, 8, 0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ExploreSeller.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.explore,
                      color: kPrimaryColor,
                    ),
                    Text(
                      " ${LocaleKeys.explore_seller.tr()}",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ],
                ),
              ),
            ),
            (mounted)
                ? StreamProvider<AdvertisementModel>(
                    create: APISTREAM().getAds,
                    initialData: AdvertisementModel.fromJson(
                      {
                        "status_code": 400,
                      },
                    ),
                    child: Consumer<AdvertisementModel>(
                        builder: (context, adss, child) {
                      if (adss.statusCode == 400) {
                        // replace the return with your shimmer widget
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: getProportionateScreenHeight(180),
                            width: getProportionateScreenWidth(350),
                            child: ListView(
                              children: [
                                Card(
                                  elevation: 1.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: SizedBox(
                                    height: getProportionateScreenHeight(170),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      return AdsBanner(ads: adss);
                    }))
                : SizedBox.shrink(),
            (mounted)
                ? StreamProvider<CatagoriesModel>(
                    create: APISTREAM().getCatagoriesStream,
                    initialData: CatagoriesModel.fromJson(
                      {
                        "status_code": 400,
                      },
                    ),
                    child: Consumer<CatagoriesModel>(
                        builder: (context, catg, child) {
                      if (catg.statusCode == 400) {
                        // replace the return with your shimmer widget
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: getProportionateScreenHeight(180),
                            width: getProportionateScreenWidth(350),
                            child: ListView(
                              children: [
                                Card(
                                  elevation: 1.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: SizedBox(
                                    height: getProportionateScreenHeight(170),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      return Categories(
                        catagories: catg,
                      );
                    }))
                : SizedBox.shrink(),
            StreamProvider<MostSelling>(
                create: APISTREAM().getMostSelling,
                initialData: MostSelling.fromJson(
                  {
                    "current_page": 0,
                  },
                ),
                child: Consumer<MostSelling>(builder: (context, mSell, child) {
                  if (mSell.currentPage == 0) {
                    // replace the return with your shimmer widget
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: getProportionateScreenHeight(180),
                        width: getProportionateScreenWidth(350),
                        child: ListView(
                          children: [
                            Card(
                              elevation: 1.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: SizedBox(
                                height: getProportionateScreenHeight(170),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return PopularProducts(
                    mostSellingProduct: mSell,
                  );
                })),
            SizedBox(height: getProportionateScreenWidth(30)),
            (mounted)
                ? StreamProvider<BrandsList>(
                    create: APISTREAM().getBrandData,
                    initialData: BrandsList.fromJson(
                      {
                        "status_code": 400,
                      },
                    ),
                    child: Consumer<BrandsList>(
                      builder: (context, heroes, child) {
                        if (heroes.statusCode == 400) {
                          // replace the return with your shimmer widget
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: getProportionateScreenHeight(180),
                              width: getProportionateScreenWidth(350),
                              child: ListView(
                                children: [
                                  Card(
                                    elevation: 1.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: SizedBox(
                                      height: getProportionateScreenHeight(170),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        return Brands(
                          brand: heroes,
                        );
                      },
                    ))
                : SizedBox.shrink(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
