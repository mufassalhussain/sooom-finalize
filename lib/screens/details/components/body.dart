import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:soom_net/components/default_button.dart';
import 'package:soom_net/models/Product.dart';
import 'package:soom_net/models/ProductDetails.dart';
import 'package:soom_net/size_config.dart';

import '../../../API/api.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final ProductDetail product;

  const Body({Key? key, required this.product});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // getProductDetails(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: widget.product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                storeId: widget.product.data!.storeId,
                sellerAvatar: widget.product.data!.sellerAvatar,
                sellerName: widget.product.data!.sellerName,
                partNumber: widget.product.data!.partNumber,
                condition: widget.product.data!.productCondition,
                catagory: widget.product.data!.categories!,
                price: widget.product.data!.price,
                productName: widget.product.data!.name,
                productDesc: widget.product.data!.description,
                pressOnSeeMore: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
