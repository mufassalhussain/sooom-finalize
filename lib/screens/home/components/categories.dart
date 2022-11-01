import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soom_net/API/api.dart';
import 'package:soom_net/models/Catagories.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Categories extends StatefulWidget {
  final CatagoriesModel? catagories;
  const Categories({
    this.catagories,
    Key? key,
  }) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < widget.catagories!.data!.length; i++)
                Padding(
                  padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                  child: CategoryCard(
                    icon: widget.catagories!.data![i].image != null
                        ? URLSTORAGE +
                            widget.catagories!.data![i].image.toString()
                        : "",
                    text: widget.catagories!.data![i].name,
                    press: () {},
                  ),
                )
            ]),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFfbdb2c),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(icon!, errorBuilder: (BuildContext? context,
                  Object? exception, StackTrace? stackTrace) {
                return Image.asset(
                  "assets/img_error.png",
                  height: 50,
                  width: 50,
                );
              }),
            ),
            SizedBox(height: 5),
            Text(text!,
                style: TextStyle(fontSize: 10), textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
