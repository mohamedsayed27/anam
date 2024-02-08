import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_elevated_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../translations/locale_keys.g.dart';

class ContactContainerWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String price;
  final String rate;
  const ContactContainerWidget({super.key, this.onPressed, required this.price, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${price} ريال",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 24.sp,
                    color: AppColors.blackColor,
                  ),
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: AppColors.orangeColor,
                  size: 18.r,
                ),
                Text(
                  rate,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.blackColor,
                      ),
                ),
              ],
            ),
          ],
        ),
        CustomElevatedButton(
          title: LocaleKeys.contact.tr(),
          buttonSize: Size(212.w, 48.h),
          radius: 6,
          onPressed: onPressed,
        )
      ],
    ).symmetricPadding(horizontal: 16);
  }
}
