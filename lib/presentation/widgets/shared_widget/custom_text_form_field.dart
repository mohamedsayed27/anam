import '../../../core/app_theme/custom_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final bool enabled;
  final TextEditingController? controller;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? fillColor;
  final bool isNotVisible;
  final bool? filled;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.enabled = true,
    this.isNotVisible = false,
    this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode, this.fillColor, this.filled,
  });

  @override
  Widget build(BuildContext context) {
    InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        color: AppColors.greyColor9D,
        width: 1.w,
      ),
    );
    InputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        color: AppColors.primaryColor,
        width: 1.w,
      ),
    );
    InputBorder errorBorderColor = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        color: AppColors.redColor,
        width: 1.w,
      ),
    );
    return TextFormField(
      controller: controller,
      obscureText: isNotVisible,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: border,
        focusedBorder: focusedBorder,
        enabledBorder: border,
        disabledBorder: border,
        errorBorder: errorBorderColor,
        contentPadding: EdgeInsets.symmetric(horizontal:12.w,vertical: 12.h),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: fillColor,
        filled: filled,
        hintText: hintText,
        hintStyle: CustomThemes.greyD9ColorTextTheme(context).copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400
        ),
        enabled: enabled,
      ),
    );
  }
}
