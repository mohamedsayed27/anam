import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static const primaryColor = Color(0xff25559D);
  static const authBorderColor = Color(0xffB0B0B0);
  static const searchBarBorderColor = Color(0xffF4F4F4);
  static const greyColor9D = Color(0xffD9D9D9);
  static const grey7DColor = Color(0xff7D7D7D);
  static const redColor = Color(0xffFF0000);
  static const orderTypeBackGroundColor = Color(0xffE3E3E3);
  static const dividerColor = Color(0xff9F9F9F);
  static const blackColor = Color(0xff000000);
  static const greyColor22 = Color(0xff222222);
  static const greyColor34 = Color(0xff343434);
  static const greyColor71 = Color(0xff717171);
  static const darkGreyTextColor = Color(0xff1D1E20);
  static const favoriteRedColor = Color(0xffC62626);
  static const messageTextFieldBorderColor = Color(0xffDBDBDB);
  static Color messageTextFieldFillColor = const Color(0xffF5F5F5).withOpacity(0.59);
  static const orangeColor = Color(0xffF0B35F);
  static const selectedCategoriesTabBarItem = Color(0xffEAEAEA);
  static const orderTypeContainerColor = Color(0xffEEEEEE);
  static const whiteColor = Colors.white;
  static Color shimmerFirstColor = Colors.grey[200]!;
  static Color shimmerSecondColor = Colors.grey[300]!;
}