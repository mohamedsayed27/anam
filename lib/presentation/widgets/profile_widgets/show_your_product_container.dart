import 'package:anam/core/assets_path/images_path.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_themes.dart';

class ShowYourProductContainer extends StatelessWidget {
  final void Function()? onPressed;
  const ShowYourProductContainer({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onPressed,
      child: Ink(
        padding: EdgeInsetsDirectional.only(
          top: 6.h,
          bottom: 6.h,
          start: 25.w,
          end: 44,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withOpacity(.15),
              blurRadius: 10.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ارفع منتجاتك",
                    style: CustomThemes.greyColor34TextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  Text(
                    LocaleKeys.fillFormEasily.tr(),
                    overflow: TextOverflow.ellipsis,
                    style: CustomThemes.grey7DColorTextTheme(context).copyWith(
                        fontSize: 14.sp,
                        height: 1,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  Text(
                    LocaleKeys.startMakingProfits.tr(),
                    overflow: TextOverflow.ellipsis,
                    style: CustomThemes.grey7DColorTextTheme(context).copyWith(
                        fontSize: 14.sp,
                        height: 1,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              ImagesPath.anaamLogo,
              height: 70.h,
              width: 52.w,
            )
          ],
        ),
      ),
    ).symmetricPadding(horizontal: 27);
  }
}
