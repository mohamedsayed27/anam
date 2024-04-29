import 'package:anam/core/app_theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../translations/locale_keys.g.dart';

class OrderTypeContainer extends StatelessWidget {
  final double hPadding;
  final double vPadding;
  final double fontSize;
  final double? radius;
  const OrderTypeContainer({super.key, required this.hPadding, required this.vPadding, required this.fontSize, this.radius});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(radius?.r??4.r),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: hPadding.w, vertical: vPadding.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius?.r??4.r),
          color: AppColors.orderTypeBackGroundColor
        ),
        child: Text(
          LocaleKeys.travelEssentials.tr(),
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontSize: fontSize.sp),
        ),
      ),
    );
  }
}
