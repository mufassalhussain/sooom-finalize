import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soom_net/components/coustom_bottom_nav_bar.dart';
import 'package:soom_net/constants.dart';
import 'package:soom_net/enums.dart';
import 'package:soom_net/size_config.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: getProportionateScreenHeight(80),
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Image.asset(
          context.locale.toString() == 'en'
              ? 'assets/en_logo.png'
              : 'assets/ar_logo.png',
          width: getProportionateScreenWidth(220),
        ),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
