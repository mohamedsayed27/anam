import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/assets_path/svg_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCircleButton extends StatelessWidget {
  final bool isOutlinedButton;
  final bool isSvgChild;
  final void Function()? onPressed;
  final IconData? iconPath;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? iconSize;
  final double? width;
  final double? elevation;
  final double? height;

  const CustomCircleButton({
    super.key,
    this.isOutlinedButton = false,
    this.onPressed,
    this.isSvgChild = false,
    this.iconPath,
     this.iconSize,
    this.height,
    this.width, this.iconColor, this.backgroundColor, this.foregroundColor, this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return isOutlinedButton
        ? SizedBox(
            height: height,
            width: width,
            child: OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                elevation: 0,
                shadowColor: Colors.transparent,
                side: BorderSide(
                  color: AppColors.whiteColor,
                  width: 0.46.w,
                ),
                padding: EdgeInsets.zero,
                foregroundColor: foregroundColor??Colors.black,
                backgroundColor: backgroundColor??AppColors.blackColor.withOpacity(0.16),
                shape: const CircleBorder(),
              ),
              child: Icon(
                iconPath,
                size: iconSize,
                color: iconColor??Colors.white,
              ),
            ),
          )
        : SizedBox(
            height: height,
            width: width,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                elevation: elevation??6,
                padding: EdgeInsets.zero,
                shadowColor: Colors.transparent,
                foregroundColor: foregroundColor??Colors.black,
                backgroundColor: backgroundColor??AppColors.whiteColor,
                shape: const CircleBorder(),
              ),
              child: isSvgChild
                  ? SvgPicture.asset(SvgPath.cancel,width: 7.w,height: 7.h,)
                  : Icon(
                      iconPath,
                      size: iconSize,
                      color:iconColor??Colors.black,
                    ),
            ),
          );
  }
}
