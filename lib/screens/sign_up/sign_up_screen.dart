import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:soom_net/API/api.dart';

import '../../constants.dart';
import 'components/body.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class SignUpScreen extends StatefulWidget {
  static String routeName = "/sign_up";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loadingScreen = false;
  void loading(bool val) {
    setState(() {
      loadingScreen = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: myGlobalsSignUp.scaffoldKey,
        appBar: AppBar(
          title: Text("Sign Up"),
        ),
        body: ModalProgressHUD(
          inAsyncCall: loadingScreen,
          progressIndicator: spinkit,
          child: Body(
            setLoading: loading,
          ),
        ));
  }
}
