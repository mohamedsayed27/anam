import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/app_theme/custom_themes.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_check_box.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_outlined_button.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackageSubscriptionItem extends StatelessWidget {
  final bool isChecked;
  final void Function()? onPressed;
  const PackageSubscriptionItem({super.key, required this.isChecked, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      backgroundColor: isChecked?AppColors.orangeColor.withOpacity(0.20):AppColors.whiteColor,
      onPressed: onPressed,
      borderColor: isChecked ? AppColors.orangeColor : AppColors.grey7DColor,
      foregroundColor: AppColors.orangeColor,
      padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("الباقة الشهرية",style: CustomThemes.darkGreyColorTextTheme(context).copyWith(fontSize: 20.sp,fontWeight: FontWeight.w400),),
              CustomCheckBox(isChecked: isChecked),
            ],
          ),
          CustomSizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("15 ريال",style: CustomThemes.primaryColorTextTheme(context).copyWith(fontSize: 18.sp,fontWeight: FontWeight.w400),),
              Text("10 عرض",style: CustomThemes.primaryColorTextTheme(context).copyWith(fontSize: 18.sp,fontWeight: FontWeight.w400),),
            ],
          ),
          CustomSizedBox(height: 12,),
          Text("لقد تم توليد هذا النص من مولد النص العربى",style: CustomThemes.grey7DColorTextTheme(context).copyWith(fontSize: 16.sp,fontWeight: FontWeight.w400),),
        ],
      ),
    );
  }
}
