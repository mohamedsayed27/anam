import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SubCategoriesShimmersList extends StatelessWidget {
  const SubCategoriesShimmersList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (_, index) {
          return Container(
            height: 32.h,
            width: 64.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(
                color: AppColors.primaryColor,
                width: 1.w,
              ),
            ),
            child: Shimmer.fromColors(
              baseColor: AppColors.primaryColor.withOpacity(0.2),
              highlightColor: AppColors.primaryColor.withOpacity(0.5),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
            ),
          );
        },scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        separatorBuilder: (_, index) {
          return const CustomSizedBox(
            width: 8,
          );
        },
        itemCount: 5,);
  }
}
