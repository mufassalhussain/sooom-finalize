import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:soom_net/constants.dart';
import 'package:soom_net/models/BrandSearchModel.dart';
import 'package:soom_net/screens/home/components/brands.dart';
import 'package:soom_net/screens/special_offer_view.dart';
import 'package:soom_net/screens/submit_special_request.dart';
import '../API/api.dart';
import '../components/custom_surfix_icon.dart';

import '../l10n/locale_keys.g.dart';
import '../models/CustomOrders.dart';
import '../size_config.dart';

class CustomOrder extends StatefulWidget {
  static const routeName = '/custom_order';
  const CustomOrder({Key? key}) : super(key: key);

  @override
  State<CustomOrder> createState() => _CustomOrderState();
}

class _CustomOrderState extends State<CustomOrder> {
  bool loadingIndicator = false;
  var customOrder = null;

  getCustomOrder() async {
    customOrder = await API().getCustomOrder();

    setState(() {});
  }

  @override
  void initState() {
    getCustomOrder();
    // getBrands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: customOrder != null
            ? ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, SubmitSpecialRequest.routeName);
                },
                icon: Icon(Icons.request_page),
                label: Text(
                  '${LocaleKeys.submit_special_request.tr()}',
                ))
            : SizedBox.shrink(),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Column(
            children: [
              Text(
                '${LocaleKeys.custom_order.tr()}',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        body: customOrder != null
            ? ModalProgressHUD(
                inAsyncCall: loadingIndicator,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: customOrder.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          elevation: 1,
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ViewSpecialOffer.routeName,
                                  arguments: {
                                    "id": customOrder.data![index].id,
                                    "bids": customOrder.data![index].bids,
                                    "name": customOrder.data![index].name,
                                    "image":
                                        "${URLSTORAGE + "/special/order/" + customOrder.data![index].image!.toString()}",
                                    "year": customOrder.data![index].year
                                        .toString(),
                                    "make": "",
                                    "model": customOrder.data![index].carModelId
                                        .toString(),
                                    "condition": customOrder
                                        .data![index].productType
                                        .toString(),
                                    "part_number": customOrder
                                        .data![index].partNumber
                                        .toString(),
                                    "chassis_number": customOrder
                                        .data![index].partNumber
                                        .toString(),
                                    "index": index
                                  });
                            },
                            leading: Image.network(
                                URLSTORAGE +
                                    "/special/order/" +
                                    customOrder.data![index].image!.toString(),
                                errorBuilder: (BuildContext? context,
                                    Object? exception, StackTrace? stackTrace) {
                              return Image.asset(
                                "assets/img_error.png",
                                height: 50,
                                width: 50,
                              );
                            }),
                            title:
                                Text(customOrder.data![index].name.toString()),
                          ),
                        ),
                      );
                    },
                  ),
                ))
            : Center(child: spinkit));
  }

  // Column submitSpecialRequest() {
  //   return
  // }

}
