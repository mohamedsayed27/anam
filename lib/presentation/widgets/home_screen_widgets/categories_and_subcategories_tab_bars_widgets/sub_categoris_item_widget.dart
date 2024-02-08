import 'package:anam/core/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubCategoriesTabBarItemWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final void Function()? onTap;

  const SubCategoriesTabBarItemWidget({
    super.key,
    required this.title,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100.r),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 5.h
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withOpacity(.21)
              : AppColors.whiteColor,
          border: Border.all(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(100.r),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
