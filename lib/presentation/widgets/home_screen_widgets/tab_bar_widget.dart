import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_themes.dart';

class HomeTabBarWidget extends StatelessWidget {
  final TabController tabController;
  final void Function(int)? onTap;
  const HomeTabBarWidget({
    super.key,
    required this.tabController, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 8.h),
                color: AppColors.blackColor.withOpacity(0.08),
                blurRadius: 32.r
            ),
          ],
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: EdgeInsets.symmetric(horizontal: 11.w),
        dividerColor: Colors.transparent,
        labelStyle: CustomThemes.whiteColorTextTheme(context).copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        unselectedLabelStyle: CustomThemes.greyD9ColorTextTheme(context).copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        onTap: onTap,
        labelColor: AppColors.whiteColor,
        unselectedLabelColor: AppColors.grey7DColor,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: AppColors.primaryColor,
        ),
        tabs: const [
          Tab(
            text: "منتجاتنا",
          ),
          Tab(
            text: "خدماتنا",
          ),
        ],
        controller: tabController,
      ),
    );
  }
}