import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soom_net/API/api_streams.dart';
import 'package:soom_net/components/coustom_bottom_nav_bar.dart';
import 'package:soom_net/enums.dart';
import 'package:soom_net/models/Brands.dart';

import '../../API/api.dart';
import '../../constants.dart';
import '../../size_config.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        toolbarHeight: getProportionateScreenHeight(80),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Image.asset(
          context.locale.toString() == 'en'
              ? 'assets/en_logo.png'
              : 'assets/ar_logo.png',
          width: getProportionateScreenWidth(220),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => super.widget));
        },
        child: Body(),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
