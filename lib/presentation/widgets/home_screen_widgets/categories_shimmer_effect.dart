import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/app_theme/app_colors.dart';

class CategoriesShimmerEffectList extends StatelessWidget {
  const CategoriesShimmerEffectList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Shimmer.fromColors(
                  baseColor: AppColors.shimmerFirstColor,
                  highlightColor: AppColors.shimmerSecondColor,
                  child: Container(
                    height: 33.h,
                    width: 33.w,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const CustomSizedBox(
                  height: 4,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    height: 8.h,
                    width: 24.w,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, index) {
          return CustomSizedBox(width: 8,);
        },
        itemCount: 3,);
  }
}
