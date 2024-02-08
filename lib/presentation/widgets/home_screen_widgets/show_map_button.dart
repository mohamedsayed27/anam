import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/assets_path/fonts_path.dart';
import '../../../core/assets_path/svg_path.dart';
import '../../../translations/locale_keys.g.dart';
import '../shared_widget/custom_sized_box.dart';

class ShowMapButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool isMap;
  const ShowMapButton({super.key, this.onPressed, required this.isMap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.orangeColor,
        foregroundColor: AppColors.whiteColor,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 17.w,
          vertical: 16.h,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            isMap ? SvgPath.showMenu : SvgPath.openMapIcon,
          ),
          const CustomSizedBox(
            width: 5,
          ),
          Text(
            isMap
                ? LocaleKeys.showMenu.tr()
                : LocaleKeys.showMap.tr(),
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 14.sp,
              fontFamily: FontsPath.boutrosAsma,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
