import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:soom_net/components/custom_surfix_icon.dart';
import 'package:soom_net/components/default_button.dart';
import 'package:soom_net/components/form_error.dart';
import 'package:soom_net/screens/complete_profile/complete_profile_screen.dart';

import '../../../API/api.dart';
import '../../../constants.dart';
import '../../../l10n/locale_keys.g.dart';
import '../../../size_config.dart';
import '../../sign_in/sign_in_screen.dart';

class SignUpForm extends StatefulWidget {
  final Function? setLoading;
  const SignUpForm({
    this.setLoading,
  });
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? name;
  String? password;
  String? conform_password;
  bool remember = false;
  bool loading = false;
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
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () async {
              _formKey.currentState!.save();

              if (_formKey.currentState!.validate()) {
                widget.setLoading!(true);

                var response = await API().userRegister(name, email, password);

                if (response == 200) {
                  AwesomeDialog(
                    context: myGlobalsSignUp.scaffoldKey.currentContext!,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dialogType: DialogType.success,
                    showCloseIcon: true,
                    title: '${LocaleKeys.congratulations.tr()}',
                    desc: '${LocaleKeys.registration_success_message.tr()}',
                    btnOkOnPress: () {
                      Navigator.of(myGlobalsSignUp.scaffoldKey.currentContext!)
                          .pop();
                      Navigator.pushNamed(
                          myGlobalsSignUp.scaffoldKey.currentContext!,
                          SignInScreen.routeName);
                    },
                    btnOkColor: kPrimaryColor,
                    btnOkText: "${LocaleKeys.continues.tr()}",
                    btnOkIcon: Icons.check_circle,
                    onDismissCallback: (type) {},
                  ).show();
                } else {
                  AwesomeDialog(
                    context: myGlobalsSignUp.scaffoldKey.currentContext!,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dialogType: DialogType.error,
                    showCloseIcon: true,
                    title: '${LocaleKeys.error.tr()}',
                    desc: '${LocaleKeys.registration_error_message.tr()}',
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
                // if all are valid then go to success screen
                //  Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              }
              // } catch (e) {
              //   widget.setLoading!(false);
              // }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
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

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => name = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${LocaleKeys.name.tr()}",
        hintText: "${LocaleKeys.enter_your_name.tr()}",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
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
