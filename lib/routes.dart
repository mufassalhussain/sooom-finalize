import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:soom_net/models/MostSelling.dart';
import 'package:soom_net/screens/allbrands.dart';
import 'package:soom_net/screens/cart/cart_screen.dart';
import 'package:soom_net/screens/checkout_confirm.dart';
import 'package:soom_net/screens/complete_profile/complete_profile_screen.dart';
import 'package:soom_net/screens/custom_order.dart';
import 'package:soom_net/screens/details/details_screen.dart';
import 'package:soom_net/screens/explore_seller.dart';
import 'package:soom_net/screens/forgot_password/forgot_password_screen.dart';
import 'package:soom_net/screens/home/home_screen.dart';
import 'package:soom_net/screens/login_success/login_success_screen.dart';
import 'package:soom_net/screens/manage_account.dart';
import 'package:soom_net/screens/most_selling.dart';
import 'package:soom_net/screens/my%20profile/My%20Account.dart';
import 'package:soom_net/screens/orders/browse_order.dart';
import 'package:soom_net/screens/orders/cancelled_order.dart';
import 'package:soom_net/screens/orders/orders.dart';
import 'package:soom_net/screens/orders/return_order.dart';
import 'package:soom_net/screens/orders/ship_order.dart';
import 'package:soom_net/screens/otp/otp_screen.dart';
import 'package:soom_net/screens/profile/profile_screen.dart';
import 'package:soom_net/screens/search_screen.dart';
import 'package:soom_net/screens/seller_screen.dart';
import 'package:soom_net/screens/setting.dart';
import 'package:soom_net/screens/sign_in/sign_in_screen.dart';
import 'package:soom_net/screens/special_offer_view.dart';
import 'package:soom_net/screens/splash/splash_screen.dart';
import 'package:soom_net/screens/submit_special_request.dart';

import 'API/api.dart';
import 'models/Brands.dart';
import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  Orders.routeName: ((context) => Orders()),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  MyAccount.routeName: (context) => MyAccount(),
  MostSellingPage.routeName: ((context) => MostSellingPage()),
  CheckoutConfirmation.routeName: (((context) => CheckoutConfirmation())),
  AllBrands.routeName: ((context) => AllBrands()),
  BrowseOrder.routeName: ((context) => BrowseOrder()),
  CancelledOrder.routeName: (context) => CancelledOrder(),
  SubmitSpecialRequest.routeName: ((context) => SubmitSpecialRequest()),
  ReturnOrder.routeName: (context) => ReturnOrder(),
  SellerScreen.routeName: (context) => (SellerScreen()),
  ExploreSeller.routeName: (context) => ExploreSeller(),
  Setting.routeName: ((context) => Setting()),
  ViewSpecialOffer.routeName: (context) => ViewSpecialOffer(),
  ShipOrder.routeName: (context) => ShipOrder(),
  CustomOrder.routeName: (context) => CustomOrder(),
  SearchScreen.routeName: ((context) => SearchScreen()),
  ManageAccount.routeName: ((context) => ManageAccount())
};
