import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:soom_net/constants.dart';

import '../l10n/locale_keys.g.dart';
import 'my profile/My Account.dart';
import 'orders/orders.dart';

class ManageAccount extends StatefulWidget {
  static String routeName = "/manage_account";

  @override
  State<ManageAccount> createState() => _ManageAccountState();
}

class _ManageAccountState extends State<ManageAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "${LocaleKeys.myAccount.tr()}"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                  shape: Border(
                    left: BorderSide(width: 4.0, color: kPrimaryColor),
                  ),
                  child: InkResponse(
                    onTap: () {
                      Navigator.pushNamed(context, MyAccount.routeName);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 90.0,
                          child: ListTile(
                            title: Text(
                              "${LocaleKeys.personal_information.tr()}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                            leading: Container(
                                child: Icon(
                                  Icons.shopping_cart_sharp,
                                  color: kPrimaryColor,
                                ),
                                width: 50,
                                height: double.infinity,
                                decoration: new BoxDecoration(
                                  //color: Colors.orangeAccent,
                                  border: Border.all(
                                    color: kPrimaryColor,
                                  ),
                                  shape: BoxShape.circle,
                                )),
                            trailing: Container(
                                child: Icon(
                                  Icons.arrow_forward_sharp,
                                  color: Colors.white,
                                ),
                                width: 30,
                                height: 200,
                                decoration: new BoxDecoration(
                                  color: kPrimaryColor,
                                  shape: BoxShape.circle,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ))),
          // Padding(
          //     padding: const EdgeInsets.all(5.0),
          //     child: Card(
          //         color: kTextColor,
          //         shape: Border(
          //           left: BorderSide(width: 4.0, color: kPrimaryColor),
          //         ),
          //         child: InkResponse(
          //           onTap: () {},
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: <Widget>[
          //               SizedBox(
          //                 height: 30.0,
          //               ),
          //               Container(
          //                 height: 90.0,
          //                 child: ListTile(
          //                   title: Text(
          //                     "Special Requests",
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                       color: kPrimaryColor,
          //                     ),
          //                   ),
          //                   leading: Container(
          //                       child: Icon(
          //                         Icons.shopping_cart_sharp,
          //                         color: kPrimaryColor,
          //                       ),
          //                       width: 50,
          //                       height: double.infinity,
          //                       decoration: new BoxDecoration(
          //                         //color: Colors.orangeAccent,
          //                         border: Border.all(
          //                           color: kPrimaryColor,
          //                         ),
          //                         shape: BoxShape.circle,
          //                       )),
          //                   trailing: Container(
          //                       child: Icon(
          //                         Icons.arrow_forward_sharp,
          //                         color: Colors.white,
          //                       ),
          //                       width: 30,
          //                       height: 200,
          //                       decoration: new BoxDecoration(
          //                         color: kPrimaryColor,
          //                         shape: BoxShape.circle,
          //                       )),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ))),

          Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                  shape: Border(
                    left: BorderSide(width: 4.0, color: kPrimaryColor),
                  ),
                  child: InkResponse(
                    onTap: () {
                      Navigator.pushNamed(context, Orders.routeName);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          height: 90.0,
                          child: ListTile(
                            title: Text(
                              "${LocaleKeys.orders.tr()}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                            leading: Container(
                                child: Icon(
                                  Icons.shopping_cart_sharp,
                                  color: kPrimaryColor,
                                ),
                                width: 50,
                                height: double.infinity,
                                decoration: new BoxDecoration(
                                  //color: Colors.orangeAccent,
                                  border: Border.all(
                                    color: kPrimaryColor,
                                  ),
                                  shape: BoxShape.circle,
                                )),
                            trailing: Container(
                                child: Icon(
                                  Icons.arrow_forward_sharp,
                                  color: Colors.white,
                                ),
                                width: 30,
                                height: 200,
                                decoration: new BoxDecoration(
                                  color: kPrimaryColor,
                                  shape: BoxShape.circle,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }
}
