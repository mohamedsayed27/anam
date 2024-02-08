import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesTabBarItem extends StatelessWidget {
  final bool isSelected;
  final String imagePath;
  final String title;
  final void Function()? onTap;

  const CategoriesTabBarItem({
    super.key,
    required this.isSelected,
    required this.imagePath,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? AppColors.selectedCategoriesTabBarItem
          : Colors.transparent,
      borderRadius: BorderRadius.circular(5.r),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        splashColor: Colors.black38,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(
              color: isSelected ? AppColors.blackColor : Colors.transparent,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                width: 33.w,
                height: 33.h,
                fit: BoxFit.contain,
                imageUrl: imagePath,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const CustomSizedBox(
                height: 1.76,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
