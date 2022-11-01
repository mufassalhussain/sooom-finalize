import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:soom_net/size_config.dart';

const kPrimaryColor = Color(0xffffcb08);
const kPrimaryLightColor = Color(0xFFFF333333);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFfbdb2c), Color(0xFFFfbdb2c)],
);
const kSecondaryColor = Color(0xFFFF333333);
const kTextColor = Color(0xFFFF666666);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kNameNullError = "Please Enter your name";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);
const spinkit = SpinKitFadingCircle(
  color: kPrimaryColor,
  size: 50.0,
);
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

MyGlobals myGlobalsSignUp = MyGlobals();
MyGlobalsSignIn myGlobalsSignIn = MyGlobalsSignIn();

class MyGlobals {
  GlobalKey? _scaffoldKey;
  MyGlobals() {
    _scaffoldKey = GlobalKey();
  }

  GlobalKey get scaffoldKey => _scaffoldKey!;
}

class MyGlobalsSignIn {
  GlobalKey? _scaffoldKeySignIn;
  MyGlobalsSignIn() {
    _scaffoldKeySignIn = GlobalKey();
  }

  GlobalKey get scaffoldKey => _scaffoldKeySignIn!;
}
