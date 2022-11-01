import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soom_net/components/product_card.dart';
import 'package:soom_net/models/MostSelling.dart';
import 'package:soom_net/models/Product.dart';
import 'package:soom_net/screens/most_selling.dart';

import '../../../l10n/locale_keys.g.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  final MostSelling? mostSellingProduct;
  const PopularProducts({
    this.mostSellingProduct,
    Key? key,
  }) : super(key: key);
  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
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
                "${LocaleKeys.most_selling.tr()}",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, MostSellingPage.routeName);
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < 5; i++)
                ProductCard(
                  productName: context.locale.toString() == 'en'
                      ? widget.mostSellingProduct!.data![i].productName
                      : widget.mostSellingProduct!.data![i].arabicProductName,
                  productID: widget.mostSellingProduct!.data![i].productId,
                  productPrice: widget.mostSellingProduct!.data![i].price,
                  productImage: widget.mostSellingProduct!.data![i].image,
                ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
