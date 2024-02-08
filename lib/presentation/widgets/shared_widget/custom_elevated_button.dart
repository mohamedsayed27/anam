import 'package:anam/core/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final Size? buttonSize;
  final double? radius;
  final double? titleSize;
  final EdgeInsetsGeometry? padding;
  final String title;
  final void Function()? onPressed;
  const CustomElevatedButton({super.key, this.buttonSize, this.radius, required this.title, this.titleSize, this.onPressed, this.padding});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonSize?.width,
      height: buttonSize?.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding??EdgeInsets.zero,
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.whiteColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius?.r??6.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white,fontSize: titleSize?.sp??17.sp),
        ),
      ),
    );
  }
}
