import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'components/body.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "/sign_in";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool loadingScreen = false;
  void loading(bool val) {
    setState(() {
      loadingScreen = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: myGlobalsSignIn.scaffoldKey,
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: ModalProgressHUD(
          inAsyncCall: loadingScreen,
          progressIndicator: spinkit,
          child: Body(
            setLoading: loading,
          )),
    );
  }
}
