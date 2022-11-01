import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:soom_net/models/ExploreSeller.dart';
import 'package:soom_net/screens/my%20profile/My%20Account.dart';
import 'package:soom_net/screens/seller_screen.dart';

import '../API/api.dart';
import '../constants.dart';

class ExploreSeller extends StatefulWidget {
  static const routeName = 'explore_seller';
  const ExploreSeller({Key? key}) : super(key: key);

  @override
  State<ExploreSeller> createState() => _ExploreSellerState();
}

class _ExploreSellerState extends State<ExploreSeller> {
  ExploreSellerModel data =
      ExploreSellerModel.fromJson({"status_code": 400, "data": []});
  getDataFromAPI() async {
    data = await API().getAllSeller();
    setState(() {});
  }

  @override
  void initState() {
    getDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, "Explore Seller"),
        body: data.statusCode != 400
            ? ListView.builder(
                itemCount: data.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, SellerScreen.routeName,
                                arguments: {
                                  "id": data.data![index].id.toString()
                                });
                          },
                          title:
                              Text(data.data![index].customer!.name.toString()),
                          leading: data.data![index].customer!.avatar != null
                              ? Image.network(
                                  URLSTORAGE +
                                      data.data![index].customer!.avatar!
                                          .toString(), errorBuilder:
                                      (BuildContext? context, Object? exception,
                                          StackTrace? stackTrace) {
                                  return Image.asset(
                                    "assets/img_error.png",
                                    height: 50,
                                    width: 50,
                                  );
                                })
                              : Image.asset(
                                  "assets/img_error.png",
                                  height: 50,
                                  width: 50,
                                )));
                },
              )
            : Center(child: spinkit));
  }
}
