import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:soom_net/models/CustomOrders.dart';

import '../API/api.dart';
import '../constants.dart';
import '../size_config.dart';
import 'details/details_screen.dart';

class ViewSpecialOffer extends StatefulWidget {
  static const routeName = '/view_special_offer';
  const ViewSpecialOffer({Key? key}) : super(key: key);

  @override
  State<ViewSpecialOffer> createState() => _ViewSpecialOfferState();
}

class _ViewSpecialOfferState extends State<ViewSpecialOffer> {
  List<Bids> bids = [];
  bool loading = false;
  bool once = true;
  var index = null;
  var customOrder = null;

  getCustomOrder() async {
    customOrder = await API().getCustomOrder();
    bids = customOrder.data![index]!.bids;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var agrs = ModalRoute.of(context)!.settings.arguments as Map;
    if (once) {
      bids = agrs['bids'] as List<Bids>;
      index = agrs['index'];
      once = false;
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
        body: ModalProgressHUD(
          inAsyncCall: loading,
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.network("${agrs['image']}", height: 120,
                            errorBuilder: (BuildContext? context,
                                Object? exception, StackTrace? stackTrace) {
                          return Image.asset(
                            "assets/img_error.png",
                            height: 50,
                            width: 50,
                          );
                        }),
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
                                "${agrs['name']}",
                                style: TextStyle(fontSize: 32),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${agrs['year']}  | ${agrs['model']}",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Condition: ",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "${agrs['condition']}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Part Number: ",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "${agrs['part_number']}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Chassis Number: ",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "${agrs['chassis_number']}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Bids",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            child: Table(
                                border: TableBorder.all(color: Colors.black),
                                children: [
                                  TableRow(children: [
                                    Text(
                                      "",
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'BIDDER',
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'PRICE',
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'RATING',
                                      textAlign: TextAlign.center,
                                    ),
                                  ])
                                ]),
                          ),
                          // ListTile(
                          //   title: Text("BIDDER |PRICE |PART-RATING |ACTION"),
                          // ),
                          for (int i = 0; i < bids.length; i++)
                            Card(
                              child: ListTile(
                                onTap: bids[i]
                                            .product!
                                            .bidStatus!
                                            .toString()
                                            .toUpperCase() ==
                                        "REJECTED"
                                    ? null
                                    : () {
                                        Navigator.pushNamed(
                                            context, DetailsScreen.routeName,
                                            arguments: {
                                              "productId": bids[i]
                                                  .product!
                                                  .productDetail!
                                                  .id!
                                                  .toString()
                                            });
                                      },
                                leading: Text(
                                  (i + 1).toString(),
                                  textAlign: TextAlign.center,
                                ),
                                title: Column(
                                  children: [
                                    Table(
                                      border:
                                          TableBorder.all(color: Colors.black),
                                      children: [
                                        TableRow(children: [
                                          Text(
                                            bids[i]
                                                .product!
                                                .productDetail!
                                                .store!
                                                .name!
                                                .toString(),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            bids[i]
                                                .product!
                                                .productDetail!
                                                .price
                                                .toString(),
                                            textAlign: TextAlign.center,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(bids[i]
                                                  .product!
                                                  .productDetail!
                                                  .productRating
                                                  .toString()),
                                              Icon(
                                                Icons.star,
                                                color: kPrimaryColor,
                                              )
                                            ],
                                          ),
                                        ]),

                                        // TableRow(children: [
                                        //   Text(
                                        //     bids[i]
                                        //         .product!
                                        //         .productDetail!
                                        //         .store!
                                        //         .name!
                                        //         .toString(),
                                        //     textAlign: TextAlign.center,
                                        //   ),
                                        //   Text('Cell 4'),
                                        //   Text('Cell 5'),
                                        //   Text('Cell 6'),
                                        //   Text('Cell 6'),
                                        // ])
                                      ],
                                    ),
                                    (bids[i]
                                                    .product!
                                                    .bidStatus!
                                                    .toString()
                                                    .toUpperCase() ==
                                                "ACCEPTED" ||
                                            bids[i]
                                                    .product!
                                                    .bidStatus!
                                                    .toString()
                                                    .toUpperCase() ==
                                                "REJECTED" ||
                                            bids[i]
                                                    .product!
                                                    .bidStatus!
                                                    .toString()
                                                    .toUpperCase() ==
                                                "ACCEPTED")
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: bids[i]
                                                        .product!
                                                        .bidStatus!
                                                        .toString()
                                                        .toUpperCase() ==
                                                    "REJECTED"
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.cancel,
                                                        color: Colors.red,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            getProportionateScreenWidth(
                                                                3),
                                                      ),
                                                      Text(
                                                        bids[i]
                                                            .product!
                                                            .bidStatus!
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.red),
                                                      ),
                                                    ],
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                        Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              getProportionateScreenWidth(
                                                                  3),
                                                        ),
                                                        Text(
                                                          bids[i]
                                                              .product!
                                                              .bidStatus!,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.green),
                                                        )
                                                      ]),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  var response = await API()
                                                      .bidAcceptReject(
                                                    bids[i].id!.toString(),
                                                    "Rejected",
                                                  );
                                                  if (response == 200) {
                                                    await getCustomOrder();
                                                  }
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  var response = await API()
                                                      .bidAcceptReject(
                                                    bids[i].id.toString(),
                                                    "Accepted",
                                                  );
                                                  if (response == 200) {
                                                    await getCustomOrder();
                                                  }
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                ),
                                              )
                                            ],
                                          )
                                  ],
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )),
          ),
        ));
  }
}
