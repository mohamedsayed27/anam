import 'package:anam/core/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/app_router/screens_name.dart';
import '../shared_widget/custom_sized_box.dart';
import '../shared_widget/product_image_widget.dart';
import '../shared_widget/product_item_component.dart';

class ProductShimmerListWidget extends StatelessWidget {
  const ProductShimmerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, index) {
        return const CustomSizedBox(
          height: 16,
        );
      },
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return const ProductShimmer();
      },
    );
  }
}

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 314.h,
          width: double.infinity,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Shimmer.fromColors(
            baseColor: AppColors.shimmerFirstColor,
            highlightColor: AppColors.shimmerSecondColor,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
        ),
        const CustomSizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Shimmer.fromColors(
              baseColor: AppColors.shimmerFirstColor,
              highlightColor: AppColors.shimmerSecondColor,
              child: Container(
                height: 16.h,
                width: 72.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
            ),
            Row(
              children: [
                Shimmer.fromColors(
                  baseColor: AppColors.shimmerFirstColor,
                  highlightColor: AppColors.shimmerSecondColor,
                  child: Container(
                    height: 16.h,
                    width: 32.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),
                ),
                Icon(
                  Icons.star,
                  color: AppColors.orangeColor,
                  size: 18.r,
                ),
              ],
            )
          ],
        ),
        const CustomSizedBox(
          height: 4,
        ),
        Shimmer.fromColors(
          baseColor: AppColors.shimmerFirstColor,
          highlightColor: AppColors.shimmerSecondColor,
          child: Container(
            height: 16.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
        ),
        const CustomSizedBox(
          height: 4,
        ),
        Shimmer.fromColors(
          baseColor: AppColors.shimmerFirstColor,
          highlightColor: AppColors.shimmerSecondColor,
          child: Container(
            height: 16.h,
            width: 64.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
        ),
      ],
    );
  }
}
