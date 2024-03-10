import 'package:anam/core/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';

class MessageItemWidget extends StatelessWidget {
  final bool isMyMessage;
  final String? text;

  const MessageItemWidget({
    super.key,
    required this.isMyMessage,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return isMyMessage
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.greyColor9D,
                width: 0.72.w,
              ),
            ),
            child: Text(
              text ?? "Test test test test test test",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontSize: 16.sp, height: 1.5.h),
            ),
          ).onlyDirectionalPadding(end: 16)
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.greyColor9D,
                width: 0.72.w,
              ),
            ),
            child: Text(
              text ??
                  "Test test test test test test test test test test test test test test test test",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontSize: 16.sp, height: 1.5.h),
            ),
          ).onlyDirectionalPadding(start: 16);
  }
}
