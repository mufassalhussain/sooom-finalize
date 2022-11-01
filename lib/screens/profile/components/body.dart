import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soom_net/models/Advertisement.dart';
import 'package:soom_net/screens/custom_order.dart';
import 'package:soom_net/screens/home/components/discount_banner.dart';
import 'package:soom_net/screens/manage_account.dart';
import 'package:soom_net/size_config.dart';
import '../../../l10n/locale_keys.g.dart';
import '../../sign_in/sign_in_screen.dart';
import 'profile_menu.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var name = '';
  getUserDetails() async {
    var instance = await SharedPreferences.getInstance();
    setState(() {
      name = instance.getString("name")!;
    });
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  int _groupValue = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          adsBanner != null
              ? AdsBanner(
                  ads: adsBanner,
                )
              : Container(),
          // Image.asset(
          //   context.locale.toString() == 'en'
          //       ? 'assets/en_logo.png'
          //       : 'assets/ar_logo.png',
          // ),
          SizedBox(height: getProportionateScreenHeight(50)),
          ProfileMenu(
            text: LocaleKeys.myAccount.tr(),
            icon: "assets/icons/User Icon.svg",
            press: () =>
                {Navigator.pushNamed(context, ManageAccount.routeName)},
          ),
          // ProfileMenu(
          //   text: "Notifications",
          //   icon: "assets/icons/Bell.svg",
          //   press: () {},
          // ),
          // ProfileMenu(
          //   text: "Settings",
          //   icon: "assets/icons/Settings.svg",
          //   press: () {
          //     Navigator.pushNamed(context, '/setting');
          //     // context.setLocale(Locale('en'));
          //   },
          // ),
          ProfileMenu(
            text: "${LocaleKeys.special_request.tr()}",
            icon: "assets/icons/Question mark.svg",
            press: () {
              Navigator.pushNamed(context, CustomOrder.routeName);
            },
          ),

          // ProfileMenu(
          //   text: "Help Center",
          //   icon: "assets/icons/Question mark.svg",
          //   press: () {},
          // ),
          ProfileMenu(
            text: "${LocaleKeys.select_language.tr()}",
            icon: "assets/icons/translate.svg",
            press: () {
              AwesomeDialog(
                context: context,
                animType: AnimType.topSlide,
                headerAnimationLoop: false,
                body: StatefulBuilder(builder: (context, setState) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: RadioListTile(
                          value: 0,
                          groupValue: _groupValue,
                          title: Text(
                            context.locale.toString() == 'en'
                                ? "English"
                                : "إنجليزي",
                            style: TextStyle(fontSize: 15),
                          ),
                          onChanged: (int? newValue) =>
                              setState(() => _groupValue = newValue!),
                          activeColor: Colors.red,
                          selected: false,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          value: 1,
                          groupValue: _groupValue,
                          title: Text(
                            context.locale.toString() == 'en'
                                ? "Arabic"
                                : "عربي",
                            style: TextStyle(fontSize: 15),
                          ),
                          onChanged: (int? newValue) => setState(() {
                            _groupValue = newValue!;
                          }),
                          activeColor: Colors.red,
                          selected: false,
                        ),
                      ),
                    ],
                  );
                }),
                dialogType: DialogType.info,
                showCloseIcon: true,
                btnOkOnPress: () async {
                  var sharedStore = await SharedPreferences.getInstance();
                  if (_groupValue == 1) {
                    sharedStore.setString('lang', 'ar');
                    context.setLocale(Locale('ar'));
                  } else {
                    sharedStore.setString('lang', 'en');
                    context.setLocale(Locale('en'));
                  }
                },
                onDismissCallback: (type) {
                  debugPrint('Dialog Dissmiss from callback $type');
                },
              ).show();
            },
          ),
          ProfileMenu(
            text: "${LocaleKeys.log_out.tr()}",
            icon: "assets/icons/Log out.svg",
            press: () async {
              var sharedStore = await SharedPreferences.getInstance();
              sharedStore.clear();
              Navigator.pushNamed(context, SignInScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
