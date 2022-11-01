import 'package:flutter/material.dart';
import 'package:soom_net/API/api.dart';
import 'package:soom_net/models/Product.dart';
import 'package:soom_net/models/ProductDetails.dart';
import 'package:soom_net/screens/details/components/color_dots.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductDetail product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  @override
  void initState() {
    super.initState();
  }

  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product.data!.id.toString(),
              child: Image.network(
                  "$URLSTORAGE${widget.product.data!.images![0]}"),
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.product.data!.images!.length,
                (index) => buildSmallProductPreview(index)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.product.data!.returnAble.toString(),
              style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(16)),
            )
          ],
        ),
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child:
            Image.network("$URLSTORAGE${widget.product.data!.images![index]}"),
      ),
    );
  }
}
