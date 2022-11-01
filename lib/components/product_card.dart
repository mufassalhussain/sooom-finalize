import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soom_net/models/Product.dart';
import 'package:soom_net/screens/details/details_screen.dart';

import '../API/api.dart';
import '../constants.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.productID,
    required this.productPrice,
    required this.productName,
    required this.productImage,
  }) : super(key: key);

  final double width, aspectRetio;
  final productID;
  final productName;
  final productPrice;
  final productImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, DetailsScreen.routeName,
                arguments: {"productId": productID});
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network("$URLSTORAGE${productImage}",
                      errorBuilder: (BuildContext? context, Object? exception,
                          StackTrace? stackTrace) {
                    return Image.asset(
                      "assets/img_error.png",
                      height: 50,
                      width: 50,
                    );
                  }),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                productName,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${productPrice} SR",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(28),
                      width: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: Color(0xFFDBDEE4),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
