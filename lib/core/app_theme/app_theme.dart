import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/assets_path/fonts_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme{

  static ThemeData lightTheme = ThemeData(
    primarySwatch: AppColors.createMaterialColor(AppColors.primaryColor),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    primaryColor: AppColors.primaryColor,

    useMaterial3: true,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
      ),
    ),
    scaffoldBackgroundColor: AppColors.whiteColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 20.sp,
        fontFamily: FontsPath.boutrosAsma,
        color: AppColors.darkGreyTextColor,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        fontSize: 18.sp,
        fontFamily: FontsPath.boutrosAsma,
        color: AppColors.darkGreyTextColor,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: TextStyle(
        fontSize: 16.sp,
        fontFamily: FontsPath.boutrosAsma,
        color: AppColors.darkGreyTextColor,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize: 16.sp,
        fontFamily: FontsPath.boutrosAsma,
        color: AppColors.grey7DColor,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: TextStyle(
        fontSize: 14.sp,
        fontFamily: FontsPath.boutrosAsma,
        color: AppColors.grey7DColor,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontSize: 12.sp,
        fontFamily: FontsPath.boutrosAsma,
        color: AppColors.grey7DColor,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        fontFamily: FontsPath.boutrosAsma,
        color: AppColors.greyColor9D,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        fontFamily: FontsPath.boutrosAsma,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: const TextStyle(
        fontFamily: FontsPath.boutrosAsma,
        color: AppColors.whiteColor,
      ),
      bodyLarge: const TextStyle(
        fontFamily: FontsPath.boutrosAsma,
        color: AppColors.greyColor34,
      ),
    ),
  );

}