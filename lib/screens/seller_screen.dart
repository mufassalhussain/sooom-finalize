import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soom_net/l10n/locale_keys.g.dart';
import 'package:soom_net/models/SellerProfile.dart';
import 'package:soom_net/screens/home/components/brands.dart';
import '../API/api.dart';
import '../components/custom_surfix_icon.dart';
import '../components/product_card.dart';
import '../size_config.dart';
import 'con.dart';
import 'package:soom_net/constants.dart';

class SellerScreen extends StatefulWidget {
  static String routeName = "/seller_screen";
  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  bool once = true;
  bool loading = false;
  List brands = [];
  var setrating = 0.0;
  var message = '';
  TextEditingController review = TextEditingController();
  SellerProfile? profile = null;
  List brandName = [];
  List brandNameArabic = [];
  List brandUrl = [];
  getSellerProfile(id) async {
    try {
      brandName = [];
      brandNameArabic = [];
      brandUrl = [];
      profile = await API().sellerProfile(id);

      for (int i = 0; i < profile!.data!.products!.length; i++) {
        if (profile!.data!.products![i].brand != null) {
          brandName.add(profile!.data!.products![i].brand!.name.toString());
          brandNameArabic
              .add(profile!.data!.products![i].brand!.nameAr.toString());
          brandUrl.add(profile!.data!.products![i].brand!.logoPath.toString());
        }
      }
      brandName = brandName.toSet().toList();
      brandNameArabic = brandNameArabic.toSet().toList();
      brandUrl = brandUrl.toSet().toList();
      if (mounted) {
        setState(() {
          once = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          message = 'Something went wrong';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var agrs = ModalRoute.of(context)!.settings.arguments as Map;
    if (once) {
      getSellerProfile(agrs['id']);
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: profile != null
                    ? Row(
                        children: [
                          profile!.storeRating != 0.0
                              ? Text(
                                  "${profile!.storeRating!.toStringAsFixed(1)}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : Text(''),
                          const SizedBox(width: 5),
                          profile!.storeRating != 0.0
                              ? SvgPicture.asset("assets/icons/Star Icon.svg")
                              : Icon(
                                  Icons.star_outline_sharp,
                                  color: kPrimaryColor,
                                ),
                        ],
                      )
                    : SizedBox.shrink()),
          ],
          leading: SizedBox(
            height: getProportionateScreenWidth(40),
            width: getProportionateScreenWidth(40),
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                primary: kPrimaryColor,
                backgroundColor: Colors.white,
                padding: EdgeInsets.zero,
              ),
              onPressed: () => Navigator.pop(context),
              child: SvgPicture.asset(
                "assets/icons/Back ICon.svg",
                height: 15,
              ),
            ),
          ),
          elevation: 0.0,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black87),
        ),
        body: profile != null
            ? ModalProgressHUD(
                inAsyncCall: loading,
                child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.network(
                                  URLSTORAGE +
                                      profile!.data!.customer!.avatar!
                                          .toString(),
                                  height: 120),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 222,
                                height: 220,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      profile!.data!.customer!.name!.toString(),
                                      style: TextStyle(fontSize: 32),
                                    ),
                                    // Text(
                                    //   profile.data.customer.,
                                    //   style:
                                    //       TextStyle(fontSize: 19, color: Colors.grey),
                                    // ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    // SingleChildScrollView(
                                    //   scrollDirection: Axis.horizontal,
                                    //   child: Row(
                                    //     children: <Widget>[
                                    //       IconTile(
                                    //         backColor: Color(0xffFFECDD),
                                    //         imgAssetPath: "assets/email.png",
                                    //       ),
                                    //       IconTile(
                                    //         backColor: Color(0xffFEF2F0),
                                    //         imgAssetPath: "assets/call.png",
                                    //       ),
                                    //       IconTile(
                                    //         backColor: Color(0xffEBECEF),
                                    //         imgAssetPath: "assets/video_call.png",
                                    //       ),
                                    //     ],
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          Text(
                            "About",
                            style: TextStyle(fontSize: 22),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            profile!.data!.description.toString(),
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          SizedBox(
                            height: 24,
                          ),
//                     Row(
//                       children: <Widget>[
//                         Column(
//                           children: <Widget>[
//                             Row(
//                               children: <Widget>[
//                                 Image.asset("assets/images/apple-pay.png"),
//                                 SizedBox(
//                                   width: 20,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       "Address",
//                                       style: TextStyle(
//                                           color:
//                                               Colors.black87.withOpacity(0.7),
//                                           fontSize: 20),
//                                     ),
//                                     SizedBox(
//                                       height: 3,
//                                     ),
//                                     Container(
//                                         width:
//                                             MediaQuery.of(context).size.width -
//                                                 268,
//                                         child: Text(
//                                           "House # 2, Road # 5, Green Road Dhanmondi, Dhaka, Bangladesh",
//                                           style: TextStyle(color: Colors.grey),
//                                         ))
//                                   ],
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                               children: <Widget>[
//                                 Image.asset("assets/images/apple-pay.png"),
//                                 SizedBox(
//                                   width: 20,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       "Daily Practict",
//                                       style: TextStyle(
//                                           color:
//                                               Colors.black87.withOpacity(0.7),
//                                           fontSize: 20),
//                                     ),
//                                     SizedBox(
//                                       height: 3,
//                                     ),
//                                     Container(
//                                         width:
//                                             MediaQuery.of(context).size.width -
//                                                 268,
//                                         child: Text(
//                                           '''Monday - Friday
// Open till 7 Pm''',
//                                           style: TextStyle(color: Colors.grey),
//                                         ))
//                                   ],
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                         Image.asset(
//                           "assets/map.png",
//                           width: 180,
//                         )
//                       ],
//                     ),

                          Text(
                            "Products",
                            style: TextStyle(
                                color: Color(0xff242424),
                                fontSize: 28,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0;
                                    i < profile!.data!.products!.length;
                                    i++)
                                  ProductCard(
                                    productName:
                                        context.locale.toString() == 'en'
                                            ? profile!.data!.products![i].name
                                            : profile!.data!.products![i]
                                                .arabicDetail!.name,
                                    productID: profile!.data!.products![i].id,
                                    productPrice:
                                        profile!.data!.products![i].price,
                                    productImage: profile!.data!.products![i]
                                            .images!.isNotEmpty
                                        ? profile!.data!.products![i].images![0]
                                        : "",
                                  ),
                                SizedBox(
                                    width: getProportionateScreenWidth(20)),
                              ],
                            ),
                          ),
                          Text(
                            "${LocaleKeys.brands.tr()}",
                            style: TextStyle(
                                color: Color(0xff242424),
                                fontSize: 28,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0; i < brandName.length; i++)
                                  brandName.isNotEmpty
                                      ? SpecialOfferCard(
                                          image: "${brandUrl[i]}",
                                          category:
                                              context.locale.toString() == 'en'
                                                  ? "${brandName[i]}"
                                                  : "${brandNameArabic[i]}",
                                          numOfBrands: 18,
                                          press: () {},
                                        )
                                      : Text('No brand available yet'),
                                SizedBox(
                                    width: getProportionateScreenWidth(20)),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Reviews",
                                style: TextStyle(
                                    color: Color(0xff242424),
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600),
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kPrimaryColor),
                                onPressed: () async {
                                  var name = '';
                                  setrating = 0.0;
                                  review.clear();
                                  var instance =
                                      await SharedPreferences.getInstance();
                                  setState(() {
                                    name = instance.getString("name") ?? '';
                                  });
                                  AwesomeDialog(
                                    context: context,
                                    customHeader: Icon(
                                      Icons.reviews_rounded,
                                      size: 50,
                                      color: kPrimaryColor,
                                    ),
                                    animType: AnimType.leftSlide,
                                    headerAnimationLoop: false,
                                    showCloseIcon: true,
                                    body: StatefulBuilder(
                                        builder: (context, setState) {
                                      return Column(
                                        children: [
                                          TextFormField(
                                              maxLines: 4,
                                              controller: review,
                                              keyboardType: TextInputType.name,
                                              //  onSaved: (newValue) => email = newValue,
                                              onChanged: (value) {},
                                              decoration: InputDecoration(
                                                  labelText: "Review",
                                                  hintText: "Write your review",
                                                  // If  you are using latest version of flutter then lable text and hint text shown like this
                                                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
                                                  suffixIcon:
                                                      Icon(Icons.rate_review))),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          RatingBar.builder(
                                            initialRating: setrating,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: false,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              setState(() {
                                                setrating = rating;
                                              });
                                            },
                                          )
                                        ],
                                      );
                                    }),
                                    btnOkOnPress: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      Map fieldMap = {};
                                      fieldMap['seller_id'] = agrs['id'];
                                      fieldMap['name'] = name;
                                      fieldMap['review'] = review.text;
                                      fieldMap['status'] = setrating;
                                      await API().submitReview(fieldMap);
                                      await getSellerProfile(agrs['id']);
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    btnOkText: "Submit",
                                    btnOkIcon: Icons.check_circle,
                                    btnCancelOnPress: () {},
                                    btnCancelText: "Cancel",
                                    btnCancelIcon: Icons.cancel,
                                    onDismissCallback: (type) {},
                                  ).show();
                                },
                                icon: Icon(Icons.reviews),
                                label: Text("Write a review"),
                              )
                            ],
                          ),
                          for (int i = 0;
                              i < profile!.data!.review!.length;
                              i++)
                            Card(
                              elevation: 1,
                              child: ListTile(
                                  title: Text(profile!
                                      .data!.review![i].customer!.name!),
                                  subtitle: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 14, vertical: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                            child: Row(
                                              children: [
                                                double.parse(profile!
                                                            .data!
                                                            .review![i]
                                                            .status!) !=
                                                        0.0
                                                    ? Text(
                                                        "${double.parse(profile!.data!.review![i].status!)}",
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      )
                                                    : Text(''),
                                                const SizedBox(width: 5),
                                                double.parse(profile!
                                                            .data!
                                                            .review![i]
                                                            .status!) !=
                                                        0.0
                                                    ? SvgPicture.asset(
                                                        "assets/icons/Star Icon.svg")
                                                    : Icon(
                                                        Icons
                                                            .star_outline_sharp,
                                                        color: kPrimaryColor,
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(profile!.data!.review![i].review
                                          .toString()),
                                    ],
                                  ),
                                  leading: Text(profile!
                                      .data!.review![i].customer!.id
                                      .toString())),
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          profile!.data!.review!.isEmpty
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text("No reviews yet")],
                                )
                              : SizedBox.shrink(),

                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )),
                ),
              )
            : Center(
                child: message == '' ? spinkit : Text(message),
              ));
  }
}

class IconTile extends StatelessWidget {
  final String? imgAssetPath;
  final Color? backColor;

  IconTile({this.imgAssetPath, this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          imgAssetPath!,
          width: 20,
        ),
      ),
    );
  }
}
