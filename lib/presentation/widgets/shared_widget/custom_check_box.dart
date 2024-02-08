import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isChecked;
  final double? width;
  final double? height;
  final double? padding;

  const CustomCheckBox({
    super.key,
    this.isChecked = false,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?.w ?? 24.w,
      height: height?.h ?? 24.h,
      // padding: EdgeInsets.all(padding?.r ?? 2.r),
      decoration: BoxDecoration(
        color: isChecked ? AppColors.orangeColor : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: isChecked ? AppColors.orangeColor : AppColors.grey7DColor,
          width: 1.w,
        ),
      ),
      alignment: Alignment.center,
      child: isChecked
          ? Container(
              height: 8.h,
              width: 8.w,
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
              ),
            )
          : null,
    );
  }
}
