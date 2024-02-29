import 'package:anam/core/assets_path/svg_path.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui;

import '../../../core/app_theme/app_colors.dart';
import '../../../translations/locale_keys.g.dart';

class ChatTextField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function()? onTap;
  const ChatTextField({super.key, this.controller, this.onTap});

  @override
  Widget build(BuildContext context) {
    InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.r),
      borderSide: BorderSide(
        color: AppColors.messageTextFieldBorderColor,
        width: 0.59.w,
      ),
    );
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        SizedBox(
          height: 40.h,
          child: TextField(
            controller: controller,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: 12.sp),
            decoration: InputDecoration(
              border: border,
              enabledBorder: border,
              focusedBorder: border,
              disabledBorder: border,
              filled: true,
              fillColor: AppColors.messageTextFieldFillColor,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 27.w,
                vertical: 11.h,
              ),
              hintText: LocaleKeys.enterYouMessage.tr(),
              hintStyle: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 12.sp,fontWeight: FontWeight.w600),
            ),
          ),
        ).onlyDirectionalPadding(end: 8.w),
        ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: const CircleBorder(),
            minimumSize: Size(43.w, 43.h),
            elevation: 0,
            padding: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            foregroundColor: AppColors.whiteColor,
          ),
          child: SvgPicture.asset(SvgPath.sendMessage,width: 16.w,height: 17.h,),
        )
      ],
    );
  }
}
