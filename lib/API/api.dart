import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:soom_net/models/Advertisement.dart';
import 'package:soom_net/models/AllOrders.dart';
import 'package:soom_net/models/Brands.dart';
import 'package:soom_net/models/CarModels.dart';
import 'package:soom_net/models/Catagories.dart';
import 'package:soom_net/models/CheckoutCalculate.dart';
import 'package:soom_net/models/ExploreSeller.dart';
import 'package:soom_net/models/MostSelling.dart';
import 'package:soom_net/models/ProductDetails.dart' as detail;
import 'package:soom_net/models/SellerProfile.dart';
import 'package:soom_net/screens/explore_seller.dart';

import '../models/CustomOrders.dart';

const String URL = 'http://app.sooom.info/api/';
const String URLSTORAGE = 'http://app.sooom.info/storage/';
const String GOOGLE_API_KEY = 'AIzaSyDqoFQlyvaDTDmKUpbWf1VrLpSkxVoNIlg';

//API TARGETS
const String REGISTER = 'apicustomer/registers';
const String LOGIN = 'apicustomer/login';
const String PROFILE = 'apicustomer/profile';
const String BRANDSLIST = 'brands/list';
const String PRODUCTLIST = 'products/list';
const String CATAGORIESLIST = 'products/categories';
const String PRODUCTDETAILS = 'products/detail/';
const String MOSTSELLING = 'products/most_selling';
const String SEATCHBYMODEL = 'products/search_by_model';
const String ADSLIST = 'ads/list';
const String SELLERPROFILE = 'products/store/detail/';
const String CALCULATECART = 'orders/calculate';
const String PROCEEDCART = 'orders/addcart';
const String ALLORDERS = 'orders/allorder';
const String ORDERSTATUSCHANGE = 'orders/orderstatus';
const String SUBMITREVIEW = 'seller/add/review';
const String GETALLSELLER = 'products/all/store';
const String SUBMITSPECIALREQUEST = 'specials/add/order';
const String ALLCUSTOMORDER = 'specials/all/order';
const String ALLCARMODEL = 'carmodel/all/model';
const String BIDACCEPTREJECT = 'specials/bid/status';

class API with ChangeNotifier {
  Future searchByModel(search) async {
    var apiHeaderData = await getHeaders(null);
    final productDetails = await http.post(Uri.parse(URL + SEATCHBYMODEL),
        headers: apiHeaderData, body: {"search": search});
    var decodeSearchResult = jsonDecode(productDetails.body)['data']['data'];
    return decodeSearchResult;
  }

  bidAcceptReject(bidId, bidStatus) async {
    try {
      var apiHeaderData = await getHeaders(null);
      apiHeaderData.putIfAbsent(
          HttpHeaders.contentTypeHeader, () => 'application/json');

      final accpetOrReject = await http.post(Uri.parse(URL + BIDACCEPTREJECT),
          headers: apiHeaderData,
          body: json.encode({
            "bid_id": bidId,
            "bid_status": bidStatus,
          }));
      if (accpetOrReject.statusCode == 200 ||
          accpetOrReject.statusCode == 201) {
        return 200;
      } else {
        var response = await bidAcceptReject(bidId, bidStatus);
        return response;
      }
    } catch (e) {}
  }

  Future<Map<String, String>> getHeaders(BuildContext? context) async {
    Map<String, String> apiHeaderData = {};
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    final userToken = sharedPreferences.getString('access_token');

    if (userToken != null) {
      apiHeaderData = {
        HttpHeaders.acceptHeader: "application/json",
        'Authorization': 'Bearer ' + userToken,
      };
    } else {
      if (context != null) {
        //logout(context);
      }
    }
    return apiHeaderData;
  }

  getCustomOrder() async {
    try {
      var apiHeaderData = await getHeaders(null);
      var response = await http.get(
        Uri.parse(URL + ALLCUSTOMORDER),
        headers: apiHeaderData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CustomOrders.fromJson(json.decode(response.body));
      } else {
        var response = await getCustomOrder();
        return response;
      }
    } catch (e) {}
  }

  Future<CarModels> getCarModels() async {
    var apiHeaderData = await getHeaders(null);
    var response = await http.get(
      Uri.parse(URL + ALLCARMODEL),
      headers: apiHeaderData,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return CarModels.fromJson(json.decode(response.body));
    } else {
      var response = await getCarModels();
      return response;
    }
  }

  submitSpecialRequest(fieldMap) async {
    var apiHeaderData = await getHeaders(null);
    apiHeaderData.putIfAbsent(
        HttpHeaders.contentTypeHeader, () => 'application/json');
    final submitSpecialRequest = await http.post(
        Uri.parse(URL + SUBMITSPECIALREQUEST),
        headers: apiHeaderData,
        body: json.encode(fieldMap));
    if (submitSpecialRequest.statusCode == 200 ||
        submitSpecialRequest.statusCode == 201) {
      return submitSpecialRequest;
    } else {
      var response = await getCarModels();
      return response;
    }
  }

  Future<ExploreSellerModel> getAllSeller() async {
    try {
      var apiHeaderData = await getHeaders(null);
      final getAllSeller = await http.get(
        Uri.parse(URL + GETALLSELLER),
        headers: apiHeaderData,
      );

      if (getAllSeller.statusCode == 200 || getAllSeller.statusCode == 201) {
        return ExploreSellerModel.fromJson(json.decode(getAllSeller.body));
      } else {
        var response = await API().getAllSeller();
        return response;
      }
    } catch (e) {
      return ExploreSellerModel.fromJson({"status_code": "400", "data": []});
    }
  }

  Future<CheckoutCalculate> getCheckoutCalculation(productList) async {
    if (productList != []) {
      var fieldMap = new Map<String, dynamic>();
      fieldMap['cart'] = productList;
      var apiHeaderData = await getHeaders(null);
      apiHeaderData.putIfAbsent(
          HttpHeaders.contentTypeHeader, () => 'application/json');
      final checkoutCalculation = await http.post(
          Uri.parse(URL + CALCULATECART),
          headers: apiHeaderData,
          body: json.encode(fieldMap));
      if (checkoutCalculation.statusCode == 200) {
        var decodeCalculation = json.decode(checkoutCalculation.body);
        return CheckoutCalculate.fromJson(decodeCalculation);
      } else {
        return CheckoutCalculate(statusCode: checkoutCalculation.statusCode);
      }
    } else {
      return CheckoutCalculate(statusCode: 400);
    }
  }

  submitReview(fieldMap) async {
    var apiHeaderData = await getHeaders(null);
    apiHeaderData.putIfAbsent(
        HttpHeaders.contentTypeHeader, () => 'application/json');
    final response = await http.post(
      Uri.parse(URL + SUBMITREVIEW),
      body: json.encode(fieldMap),
      headers: apiHeaderData,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      var my_response = await API().getAllSeller();
      return my_response;
    }
  }

  Future<AllOrders> getAllOrder() async {
    var apiHeaderData = await getHeaders(null);
    final allOrderResponse = await http.get(
      Uri.parse(URL + ALLORDERS),
      headers: apiHeaderData,
    );

    if (allOrderResponse.statusCode == 200 ||
        allOrderResponse.statusCode == 201) {
      return AllOrders.fromJson(json.decode(allOrderResponse.body));
    } else {
      var my_response = await API().getAllOrder();
      return my_response;
    }
  }

  changeStatusOrder(orderId, status) async {
    var apiHeaderData = await getHeaders(null);
    apiHeaderData.putIfAbsent(
        HttpHeaders.contentTypeHeader, () => 'application/json');
    final changeStatusResponse = await http.post(
        Uri.parse(URL + ORDERSTATUSCHANGE),
        headers: apiHeaderData,
        body: json.encode({"order_id": orderId, "status": status}));

    if (changeStatusResponse.statusCode == 200 ||
        changeStatusResponse.statusCode == 201) {
      return changeStatusResponse;
    } else {
      var my_response = await API().changeStatusOrder(orderId, status);
      return my_response;
    }
  }

  Future<Response> proceedCart(Map fieldMap) async {
    var apiHeaderData = await getHeaders(null);
    apiHeaderData.putIfAbsent(
        HttpHeaders.contentTypeHeader, () => 'application/json');
    final proceedCart = await http.post(Uri.parse(URL + PROCEEDCART),
        headers: apiHeaderData, body: json.encode(fieldMap));
    if (proceedCart.statusCode == 200 || proceedCart.statusCode == 201) {
      return proceedCart;
    } else {
      var my_response = await API().proceedCart(fieldMap);
      return my_response;
    }
  }

  Future<SellerProfile> sellerProfile(id) async {
    var apiHeaderData = await getHeaders(null);
    final sellerProfile = await http.post(
      Uri.parse(URL + SELLERPROFILE + "$id"),
      headers: apiHeaderData,
    );
    if (sellerProfile.statusCode == 200 || sellerProfile.statusCode == 201) {
      var decodeSellerProfile = json.decode(sellerProfile.body);
      return SellerProfile.fromJson(decodeSellerProfile);
    } else {
      var my_response = await API().sellerProfile(id);
      return my_response;
    }
  }

  Future<detail.ProductDetail> getProductDetail(id) async {
    var apiHeaderData = await getHeaders(null);
    final productDetails = await http.post(
      Uri.parse(URL + PRODUCTDETAILS + "$id"),
      headers: apiHeaderData,
    );
    if (productDetails.statusCode == 200 || productDetails.statusCode == 201) {
      var decodeProductDetails = jsonDecode(productDetails.body);
      return detail.ProductDetail.fromJson(decodeProductDetails);
    } else {
      var response = await getProductDetail(id);
      return response;
    }
  }

  Future<CatagoriesModel> getCatagories() async {
    var apiHeaderData = await getHeaders(null);
    final catResponse = await http.post(
      Uri.parse(URL + CATAGORIESLIST),
      headers: apiHeaderData,
    );

    if (catResponse.statusCode == 200 || catResponse.statusCode == 201) {
      var decodeResponse = jsonDecode(catResponse.body);
      notifyListeners();
      return CatagoriesModel.fromJson(decodeResponse);
    } else {
      var response = await getCatagories();
      return response;
    }
  }

  Future<MostSelling> getMostSellingProducts() async {
    var apiHeaderData = await getHeaders(null);
    final mostSelling = await http.post(
      Uri.parse(URL + MOSTSELLING),
      headers: apiHeaderData,
    );
    if (mostSelling.statusCode == 200 || mostSelling.statusCode == 201) {
      var decodeResponse = jsonDecode(mostSelling.body);
      return MostSelling.fromJson(decodeResponse['data']);
    } else {
      var response = await getMostSellingProducts();
      return response;
    }
  }

  Future<AdvertisementModel> getAds() async {
    var apiHeaderData = await getHeaders(null);
    final brandResponse = await http.post(
      Uri.parse(URL + ADSLIST),
      headers: apiHeaderData,
    );
    if (brandResponse.statusCode == 200 || brandResponse.statusCode == 201) {
      var decodeResponse = jsonDecode(brandResponse.body);
      notifyListeners();
      return AdvertisementModel.fromJson(decodeResponse);
    } else {
      var response = await getAds();
      return response;
    }
  }

  Future<BrandsList> getBrands() async {
    var apiHeaderData = await getHeaders(null);
    final brandResponse = await http.post(
      Uri.parse(URL + BRANDSLIST),
      headers: apiHeaderData,
    );
    if (brandResponse.statusCode == 200 || brandResponse.statusCode == 201) {
      var decodeResponse = jsonDecode(brandResponse.body);
      notifyListeners();
      return BrandsList.fromJson(decodeResponse);
    } else {
      var response = await getBrands();
      return response;
    }
  }

  userLogin(email, password) async {
    var sharedStore = await SharedPreferences.getInstance();
    try {
      var fieldMap = {"email": email, "password": password};

      final loginResponse = await http.post(Uri.parse(URL + LOGIN),
          headers: {
            HttpHeaders.acceptHeader: "application/json",
          },
          body: fieldMap);
      print(loginResponse.body);
      log(loginResponse.statusCode.toString());
      var decodeResponse = jsonDecode(loginResponse.body);

      log(decodeResponse.toString());

      if (loginResponse.statusCode == 200) {
        sharedStore.setString(
            "userId", decodeResponse['user']['id'].toString());
        sharedStore.setString("access_token", decodeResponse['access_token']);
        sharedStore.setString("name", decodeResponse['user']['name']);
        if (decodeResponse['error'] == false) {}
      } else {
        return true;
      }
      return decodeResponse['error'];
    } catch (e) {
      print(e);
      return true;
    }
  }

  getProfile() async {
    var apiHeaderData = await getHeaders(null);
    final profile = await http.post(
      Uri.parse(URL + PROFILE),
      headers: apiHeaderData,
    );
    if (profile.statusCode == 200 || profile.statusCode == 201) {
      return jsonDecode(profile.body)['data'];
    } else {
      var response = await getProfile();
      return response;
    }
  }

  var loading = false;
  setLoading(val) {
    loading = val;
  }

  userRegister(name, email, password) async {
    try {
      var fieldMap = {
        "name": name,
        "email": email,
        "password": password,
        "vendor_id": "0"
      };
      var apiHeaderData = await getHeaders(null);
      final registerResponse = await http.post(Uri.parse(URL + REGISTER),
          headers: apiHeaderData, body: fieldMap);
      if (registerResponse.statusCode == 200) {
        var decodeResponse = jsonDecode(registerResponse.body);

        if (decodeResponse['error'] == false) {
          return 200;
        }
      } else {
        return 400;
      }
    } catch (e) {
      return 400;
    }
  }
}
