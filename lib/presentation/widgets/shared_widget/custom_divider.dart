import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDivider extends StatelessWidget {
  final double? hPadding;
  final double? vPadding;
  final double? start;
  final double? end;
  final double? bottom;
  final Color? dividerColor;
  final double? top;
  final bool isOnlyPadding;

  const CustomDivider({
    super.key,
    this.hPadding,
    this.isOnlyPadding = false,
    this.vPadding,
    this.start,
    this.end,
    this.bottom,
    this.top, this.dividerColor,
  });

  @override
  Widget build(BuildContext context) {
    return isOnlyPadding
        ?  Divider(
            thickness: 0.5,
            color: dividerColor??AppColors.dividerColor,
          ).onlyDirectionalPadding(
            start: start,
            end: end,
            bottom: bottom,
            top: top,
          )
        :  Divider(
            thickness: 0.5,
            color: dividerColor??AppColors.dividerColor,
          ).symmetricPadding(
            horizontal: hPadding,
            vertical: vPadding,
          );
  }
}
