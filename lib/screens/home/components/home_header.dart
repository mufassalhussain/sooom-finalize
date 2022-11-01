import 'package:flutter/material.dart';
import 'package:soom_net/screens/cart/cart_screen.dart';
import 'package:soom_net/screens/search_screen.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key, required this.counter}) : super(key: key);
  final counter;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),

          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            numOfitem: counter,
            press: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
          // IconBtnWithCounter(
          //   svgSrc: "assets/icons/Bell.svg",
          //   numOfitem: 3,
          //   press: () {},
          // ),
        ],
      ),
    );
  }
}
