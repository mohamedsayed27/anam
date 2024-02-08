import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/app_theme/app_colors.dart';

class AccountSettingItemWidget extends StatelessWidget {

  final String iconPath;
  final double iconWidth;
  final double iconHeight;
  final String title;
  final void Function()? onPressed;
  final bool isBordered;
  const AccountSettingItemWidget({super.key, required this.iconPath, this.iconWidth = 24,  this.iconHeight = 24, required this.title, this.onPressed, this.isBordered = true});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      contentPadding: EdgeInsets.zero,
      shape:isBordered? UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.dividerColor,
          width: 0.5.w
        )
      ):null,
      title: Text(
        title.tr(),
        textAlign: TextAlign.start,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(fontSize: 14.sp),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_outlined,
        size: 12.r,
      ),
      leading: SvgPicture.asset(iconPath,width: iconWidth.w,height: iconHeight.h,),
    );
  }
}

