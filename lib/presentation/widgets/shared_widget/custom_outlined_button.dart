import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final double? titleSize;
  final Color? borderColor;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final void Function()? onPressed;

  const CustomOutlinedButton({
    super.key,
    this.radius,
    this.titleSize,
    this.padding,
    required this.child,
    this.onPressed, this.height, this.width, this.borderColor, this.foregroundColor, this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: padding ?? EdgeInsets.zero,
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          side: BorderSide(
            color: borderColor??AppColors.blackColor,
            width: 0.71.w
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius?.r ?? 6.r),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
