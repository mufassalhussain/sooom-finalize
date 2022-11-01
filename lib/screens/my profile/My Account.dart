import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soom_net/constants.dart';
import 'package:soom_net/models/Cart.dart';

import '../../API/api.dart';
import '../../l10n/locale_keys.g.dart';
import '../../size_config.dart';

class MyAccount extends StatefulWidget {
  static String routeName = "/my_account";

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  var profileResponse;
  getProfile() async {
    profileResponse = await API().getProfile();
    setState(() {});
  }

  @override
  void initState() {
    getProfile();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "${LocaleKeys.personal_information.tr()}"),
      body: profileResponse != null
          ? ListView(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.9,
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: CircleAvatar(
                    //     radius: 50,
                    //     backgroundImage:
                    //         NetworkImage(currentUserModel?.data?.fotoUrl ?? ''),
                    //     backgroundColor: colorPrimary,
                    //   ),
                    // ),
                    SizedBox(
                      height: 22,
                    ),
                    Text(
                      profileResponse['name'] != ''
                          ? profileResponse['name']
                          : '',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 26,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.alternate_email,
                          color: kPrimaryColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          profileResponse['email'] != ''
                              ? profileResponse['email']
                              : '',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        profileResponse['phone'] != null
                            ? Icon(
                                Icons.call,
                                color: kPrimaryColor,
                                size: 15,
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          width: 10,
                        ),
                        profileResponse['phone'] != null
                            ? Text(
                                profileResponse['phone'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: kPrimaryColor),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    /* Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Center(
                            child: Text(
                              'Conectar Redes Sociales',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: rubikRegular,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset("images/fcebook_icon.png"),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            InkWell(
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset("images/google.png"),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            InkWell(
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset("images/twitter.png"),
                              ),
                            ),
                          ],
                        ),
                      ),*/
                  ],
                ),
              ),
            ])
          : Center(
              child: spinkit,
            ),
    );
  }
}

AppBar buildAppBar(BuildContext context, title) {
  return AppBar(
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios_outlined,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    title: Column(
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
      ],
    ),
  );
}
