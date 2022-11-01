import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soom_net/API/api.dart';
import 'package:soom_net/models/Brands.dart';
import 'package:soom_net/screens/allbrands.dart';

import '../../../l10n/locale_keys.g.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class Brands extends StatefulWidget {
  final BrandsList? brand;
  const Brands({
    this.brand,
    Key? key,
  }) : super(key: key);

  @override
  State<Brands> createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${LocaleKeys.brands.tr()}',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AllBrands.routeName,
                      arguments: {'my_brand': widget.brand});
                },
                child: Text(
                  "${LocaleKeys.see_more.tr()}",
                  style: TextStyle(color: Color(0xFFBBBBBB)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return SpecialOfferCard(
              image: "${widget.brand!.data![index].logoPath}",
              category: context.locale.toString() == 'en'
                  ? "${widget.brand!.data![index].name}"
                  : "${widget.brand!.data![index].nameAr}",
              numOfBrands: 18,
              press: () {},
            );
          },
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(150),
          height: getProportionateScreenWidth(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    width: getProportionateScreenWidth(100),
                    height: getProportionateScreenWidth(70),
                    child: Image.network(image, fit: BoxFit.fitHeight,
                        errorBuilder: (BuildContext? context, Object? exception,
                            StackTrace? stackTrace) {
                      return Image.asset(
                        "assets/img_error.png",
                        fit: BoxFit.fitHeight,
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text(
                    "$category\n",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(13),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
