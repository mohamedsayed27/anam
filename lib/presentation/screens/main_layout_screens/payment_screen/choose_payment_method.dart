import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/assets_path/svg_path.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_theme/custom_themes.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';

class ChoosePaymentMethod extends StatelessWidget {
  const ChoosePaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "اختر طريقة الدفع",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: 20.sp),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          Text(
            "لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف",
            style: CustomThemes.grey7DColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          CustomSizedBox(height: 33,),
          CustomOutlinedButton(
            height: 50,
            onPressed: () {},
            radius: 8,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "بطاقة ائتمان",
                      style:
                          CustomThemes.grey7DColorTextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const CustomSizedBox(
                      width: 8,
                    ),
                    SvgPicture.asset(
                      SvgPath.masterCard,
                      width: 23.w,
                      height: 13.h,
                    ),
                    const CustomSizedBox(
                      width: 8,
                    ),
                    SvgPicture.asset(
                      SvgPath.visa,
                      width: 23.w,
                      height: 13.h,
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.grey7DColor,
                  size: 22.r,
                ),
              ],
            ),
          ),
        ],
      ).symmetricPadding(horizontal: 16),
    );
  }
}
