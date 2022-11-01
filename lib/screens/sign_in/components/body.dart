import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soom_net/components/no_account_text.dart';
import 'package:soom_net/components/socal_card.dart';
import '../../../l10n/locale_keys.g.dart';
import '../../../size_config.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  final Function? setLoading;
  const Body({
    this.setLoading,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "${LocaleKeys.welcome_back.tr()}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${LocaleKeys.login_page_header.tr()}  \n",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignForm(
                  setLoading: setLoading,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
