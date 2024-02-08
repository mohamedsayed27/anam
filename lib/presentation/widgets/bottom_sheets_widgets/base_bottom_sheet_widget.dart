import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';

class BaseBottomSheetWidget extends StatelessWidget {
  final Widget child;
  const BaseBottomSheetWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withOpacity(0.15),
              offset: Offset(0,-4.h),
              blurRadius: 16.r,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
