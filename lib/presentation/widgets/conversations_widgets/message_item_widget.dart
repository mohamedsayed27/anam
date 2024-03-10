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
        ? Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(16.r),
                  topStart: Radius.circular(16.r),
                  bottomEnd: Radius.circular(16.r),
                ),
                border: Border.all(
                  color: AppColors.greyColor9D,
                  width: 0.72.w,
                ),
              ),
              child: Text(
                text ?? "Test",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontSize: 16.sp, height: 1.5.h),
              ),
            ),
          )
        : Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(16.r),
                  topStart: Radius.circular(16.r),
                  bottomStart: Radius.circular(16.r),
                ),
                border: Border.all(
                  color: AppColors.greyColor9D,
                  width: 0.72.w,
                ),
              ),
              child: Text(
                text ?? "Test",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontSize: 16.sp, height: 1.5.h),
              ),
            ),
          );
  }
}
