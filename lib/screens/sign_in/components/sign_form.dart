import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soom_net/components/custom_surfix_icon.dart';
import 'package:soom_net/components/form_error.dart';
import 'package:soom_net/helper/keyboard.dart';
import 'package:soom_net/screens/forgot_password/forgot_password_screen.dart';
import 'package:soom_net/screens/login_success/login_success_screen.dart';

import '../../../API/api.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../l10n/locale_keys.g.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  final Function? setLoading;
  const SignForm({
    this.setLoading,
  });
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? email = TextEditingController();
  TextEditingController? password = TextEditingController();
  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
              text: "Continue",
              press: () async {
                KeyboardUtil.hideKeyboard(context);
                widget.setLoading!(true);
                var errorResponse =
                    await API().userLogin(email!.text, password!.text);
                if (!errorResponse) {
                  Navigator.pushNamedAndRemoveUntil(
                      myGlobalsSignIn.scaffoldKey.currentContext!,
                      LoginSuccessScreen.routeName,
                      (Route<dynamic> route) => false);
                } else {
                  AwesomeDialog(
                    context: myGlobalsSignIn.scaffoldKey.currentContext!,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dialogType: DialogType.error,
                    showCloseIcon: true,
                    title: 'Error',
                    desc: 'Wrong Email / Password \ Or No User Exist',
                    btnOkOnPress: () {
                      debugPrint('OnClcik');
                    },
                    btnOkText: "OK",
                    btnOkIcon: Icons.check_circle,
                    onDismissCallback: (type) {
                      debugPrint('Dialog Dissmiss from callback $type');
                    },
                  ).show();
                }
                widget.setLoading!(false);
              }
              // },
              ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: password,
      //onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${LocaleKeys.password.tr()}",
        hintText: "${LocaleKeys.enter_your_password.tr()}",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      //  onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${LocaleKeys.email.tr()}",
        hintText: "${LocaleKeys.enter_your_email.tr()}",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
