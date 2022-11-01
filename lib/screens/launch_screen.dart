import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soom_net/constants.dart';
import 'package:soom_net/screens/home/home_screen.dart';
import 'package:soom_net/screens/sign_in/sign_in_screen.dart';

import '../size_config.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  var loading = true;
  @override
  void initState() {
    getUser();
    super.initState();
  }

  var isLogin;
  getUser() async {
    setState(() {
      loading = true;
    });
    var sharedData = await SharedPreferences.getInstance();
    isLogin = sharedData.getString("access_token") ?? null;

    setState(() {
      loading = false;
    });
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: loading
          ? Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/asset_launch.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(),
                  SpinKitFadingCircle(
                    color: Colors.black,
                    size: 50.0,
                  )
                ],
              ),
              /* add child content here */
            )
          : isLogin != null
              ? HomeScreen()
              : SignInScreen(),
    );
  }
}
