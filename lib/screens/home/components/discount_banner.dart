import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soom_net/API/api.dart';
import 'package:soom_net/models/Advertisement.dart';

import '../../../size_config.dart';

var adsBanner = null;

class AdsBanner extends StatefulWidget {
  AdvertisementModel? ads;
  AdsBanner({
    this.ads,
    Key? key,
  }) : super(key: key);

  @override
  State<AdsBanner> createState() => _AdsBannerState();
}

class _AdsBannerState extends State<AdsBanner> {
  List<String> imgList = [];
  List<String> imgName = [];
  List<String> arabicImageName = [];
  getImage() {
    for (int i = 0; i < widget.ads!.data!.length; i++) {
      if (widget.ads!.data![i].image!.trim() != "") {
        imgList.add("$URLSTORAGE${widget.ads!.data![i].image.toString()}");
        imgName.add(widget.ads!.data![i].name.toString());
        arabicImageName.add(widget.ads!.data![i].arabicName.toString());
      }
    }
    adsBanner = widget.ads!;
    setState(() {});
  }

  @override
  void initState() {
    getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 90,
        width: double.infinity,
        //margin: EdgeInsets.all(getProportionateScreenWidth(20)),
        // padding: EdgeInsets.symmetric(
        //   horizontal: getProportionateScreenWidth(20),
        //   vertical: getProportionateScreenWidth(15),
        // ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: CarouselSlider(
          items: imgList.isNotEmpty
              ? imgList
                  .map((item) => Container(
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              child: Stack(
                                children: <Widget>[
                                  Image.network(item,
                                      fit: BoxFit.cover, width: 1000.0,
                                      errorBuilder: (BuildContext? context,
                                          Object? exception,
                                          StackTrace? stackTrace) {
                                    return Image.asset(
                                      "assets/img_error.png",
                                      fit: BoxFit.fitHeight,
                                    );
                                  }),
                                  Positioned(
                                    bottom: 0.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(200, 0, 0, 0),
                                            Color.fromARGB(0, 0, 0, 0)
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 20.0),
                                      child: Text(
                                        '${context.locale == 'en' ? imgName[imgList.indexOf(item)] : arabicImageName[imgList.indexOf(item)]}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ))
                  .toList()
              : [],
          options: CarouselOptions(
              autoPlay: true, aspectRatio: 2.0, enlargeCenterPage: true),
        ));
  }
}
