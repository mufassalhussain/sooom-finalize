import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AllBrands extends StatefulWidget {
  static String routeName = "/all_brands";

  @override
  State<AllBrands> createState() => _AllBrandsState();
}

class _AllBrandsState extends State<AllBrands> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var agrs = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView.builder(
        itemCount: agrs['my_brand'].data.length - 1,
        itemBuilder: (_, index) => Card(
          child: ListTile(
            onTap: () {},
            leading: Image.network(
              agrs['my_brand'].data[index].logoPath,
              height: 50,
              width: 50,
              errorBuilder: (BuildContext? context, Object? exception,
                  StackTrace? stackTrace) {
                return Image.asset(
                  "assets/img_error.png",
                  height: 50,
                  width: 50,
                );
              },
            ),
            title: Text(context.locale.toString() == 'en'
                ? agrs['my_brand'].data[index].name.toString().toUpperCase()
                : agrs['my_brand'].data[index].nameAr),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text(
          "All Brands",
          style: TextStyle(color: Colors.black),
        ));
  }
}
