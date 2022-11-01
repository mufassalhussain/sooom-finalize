import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soom_net/models/Cart.dart';
import 'package:http/http.dart' as http;
import '../../API/api.dart';
import '../../size_config.dart';
import '../constants.dart';
import '../l10n/locale_keys.g.dart';
import '../models/Product.dart';
import 'details/details_screen.dart';

class MostSellingPage extends StatefulWidget {
  static String routeName = "/most_selling";

  @override
  State<MostSellingPage> createState() => _MostSellingPageState();
}

class _MostSellingPageState extends State<MostSellingPage> {
  int _page = 1;

  int _limit = 0;

  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;

  bool _isLoadMoreRunning = false;
  Product? product;

  List _posts = [];
  void _loadMore() async {
    if (_hasNextPage == true &&
        _page != _limit &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        var apiHeaderData = await API().getHeaders(null);
        final mostSelling = await http.post(
          Uri.parse(URL + MOSTSELLING + "?page=$_page"),
          headers: apiHeaderData,
        );
        final List fetchedPosts = json.decode(mostSelling.body)['data']['data'];
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      var apiHeaderData = await API().getHeaders(null);
      final mostSelling = await http.post(
        Uri.parse(URL + MOSTSELLING + "?page=$_page"),
        headers: apiHeaderData,
      );
      var decodeMostSelling = json.decode(mostSelling.body);
      _limit = decodeMostSelling['data']['last_page'];
      setState(() {
        _posts = json.decode(mostSelling.body)['data']['data'];
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: _isFirstLoadRunning
            ? const Center(
                child: spinkit,
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _posts.length,
                      controller: _controller,
                      itemBuilder: (_, index) {
                        try {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, DetailsScreen.routeName,
                                    arguments: {
                                      "productId": _posts[index]['product_id']
                                    });
                              },
                              leading: Image.network(
                                "$URLSTORAGE${_posts[index]['products_detail']['images'][0]}",
                                errorBuilder: (BuildContext? context,
                                    Object? exception, StackTrace? stackTrace) {
                                  return Image.asset(
                                    "assets/img_error.png",
                                    height: 50,
                                    width: 50,
                                  );
                                },
                              ),
                              title: Text(context.locale.toString() == 'en'
                                  ? _posts[index]['product_name'].trim() != ''
                                      ? _posts[index]['product_name']
                                      : _posts[index]['arabic_detail']['name']
                                  : _posts[index]['arabic_detail']['name']),
                              subtitle: Text("${_posts[index]['price']} SR"),
                            ),
                          );
                        } catch (e) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, DetailsScreen.routeName,
                                    arguments: {
                                      "productId": _posts[index]['product_id']
                                    });
                              },
                              leading: Image.asset(
                                  "assets/images/ps4_console_blue_4.png"),
                              title: Text(context.locale.toString() == 'en'
                                  ? _posts[index]['product_name'].trim() != ''
                                      ? _posts[index]['product_name']
                                      : _posts[index]['arabic_detail']['name']
                                  : _posts[index]['arabic_detail']['name']),
                              subtitle: Text("\$${_posts[index]['price']}"),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  if (_isLoadMoreRunning == true)
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 40),
                      child: Center(
                        child: spinkit,
                      ),
                    ),
                  if (_hasNextPage == false)
                    Container(
                      padding: const EdgeInsets.only(top: 30, bottom: 40),
                      color: Colors.amber,
                      child: const Center(
                        child: Text('You have fetched all of the content'),
                      ),
                    ),
                ],
              ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text(
          "${LocaleKeys.most_selling.tr()}",
          style: TextStyle(color: Colors.black),
        ));
  }
}
