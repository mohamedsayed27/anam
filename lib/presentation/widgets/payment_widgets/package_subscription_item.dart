import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/app_theme/custom_themes.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_check_box.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_outlined_button.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:anam/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/packages_model/packages_model.dart';

class PackageSubscriptionItem extends StatelessWidget {
  final bool isChecked;
  final void Function()? onPressed;
  final MonthlyPackage? monthlyPackage;

  const PackageSubscriptionItem({
    super.key,
    required this.isChecked,
    this.onPressed,
     this.monthlyPackage,
  });

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      backgroundColor: isChecked
          ? AppColors.orangeColor.withOpacity(0.20)
          : AppColors.whiteColor,
      onPressed: onPressed,
      borderColor: isChecked ? AppColors.orangeColor : AppColors.grey7DColor,
      foregroundColor: AppColors.orangeColor,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                monthlyPackage?.title ?? "",
                style: CustomThemes.darkGreyColorTextTheme(context)
                    .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w400),
              ),
              CustomCheckBox(isChecked: isChecked),
            ],
          ),
          const CustomSizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${monthlyPackage?.price} ${LocaleKeys.sar.tr()}",
                style: CustomThemes.primaryColorTextTheme(context)
                    .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w400),
              ),
              Text(
                "${monthlyPackage?.productsCount} ${LocaleKeys.offer.tr()}",
                style: CustomThemes.primaryColorTextTheme(context)
                    .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          CustomSizedBox(
            height: 12,
          ),
          Text(
            "${monthlyPackage?.description}",
            style: CustomThemes.grey7DColorTextTheme(context)
                .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
