import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soom_net/l10n/locale_keys.g.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../search_screen.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.6,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, SearchScreen.routeName);
        },
        child: TextField(
          enabled: false,
          onChanged: (value) => print(value),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenWidth(9)),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: "${LocaleKeys.search_product.tr()}",
              prefixIcon: Icon(Icons.search)),
        ),
      ),
    );
  }
}
