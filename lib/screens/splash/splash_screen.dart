import 'package:flutter/material.dart';
import 'package:soom_net/screens/splash/components/body.dart';
import 'package:soom_net/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // You have to call it on your starting screen

    return Scaffold(
      body: Body(),
    );
  }
}
