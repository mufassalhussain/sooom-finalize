import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soom_net/API/api.dart';
import 'package:soom_net/models/Product.dart';
import 'package:soom_net/models/ProductDetails.dart' as detail;
import 'package:soom_net/screens/seller_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../home/components/categories.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.productName,
    required this.productDesc,
    required this.catagory,
    required this.price,
    required this.storeId,
    required this.partNumber,
    required this.condition,
    required this.sellerName,
    required this.sellerAvatar,
    this.pressOnSeeMore,
  }) : super(key: key);

  final productName;
  final productDesc;
  final price;
  final condition;
  final partNumber;
  final sellerName;
  final storeId;
  final sellerAvatar;
  final List<detail.Categories> catagory;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            widget.productName!,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Card(
          child: Column(
            children: [
              Divider(color: Colors.black),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(20),
                  right: getProportionateScreenWidth(64),
                ),
                child: Text(
                  "${widget.price}.00 SR",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(24),
                    color: kPrimaryColor,
                  ),
                ),
              ),
              Divider(color: Colors.black),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, SellerScreen.routeName,
                      arguments: {"id": widget.storeId});
                },
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage:
                      NetworkImage(URLSTORAGE + widget.sellerAvatar.toString()),
                  backgroundColor: Colors.transparent,
                ),
                title: Text(widget.sellerName.toString()),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            '\n' + widget.productDesc.toString(),
            // maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [],
            ),
          ),
        ),
        widget.condition != null
            ? Padding(
                padding: EdgeInsets.fromLTRB(
                    getProportionateScreenWidth(20), 0, 0, 0),
                child: Text(
                  'Condition : ${widget.condition}',
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                ),
              )
            : SizedBox.shrink(),
        widget.condition != null
            ? Padding(
                padding: EdgeInsets.fromLTRB(
                    getProportionateScreenWidth(20), 0, 0, 0),
                child: Text(
                  'Part Number : ${widget.partNumber}',
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                ),
              )
            : SizedBox.shrink(),
        widget.catagory != null
            ? Padding(
                padding: EdgeInsets.fromLTRB(
                    getProportionateScreenWidth(20), 0, 0, 0),
                child: Text(
                  'Catagories :',
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                ),
              )
            : SizedBox.shrink(),
        Padding(
          padding: EdgeInsets.fromLTRB(
              getProportionateScreenWidth(20),
              getProportionateScreenWidth(5),
              getProportionateScreenWidth(20),
              0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < widget.catagory.length; i++)
                    Padding(
                      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                      child: CategoryCard(
                        icon:
                            "https://www.ncenet.com/wp-content/uploads/2020/04/No-image-found.jpg",
                        text: widget.catagory[i].categoryName != null
                            ? widget.catagory[i].categoryName
                            : '',
                        press: () {},
                      ),
                    )
                ]),
          ),
        ),
      ],
    );
  }
}
