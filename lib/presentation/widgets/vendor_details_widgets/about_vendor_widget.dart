import 'package:anam/core/constants/extensions.dart';
import 'package:anam/data/models/vendor_data_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../translations/locale_keys.g.dart';
import '../shared_widget/custom_sized_box.dart';

class AboutVendorWidget extends StatelessWidget {
  final VendorProfileModel vendorProfileModel;
  const AboutVendorWidget({super.key, required this.vendorProfileModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.aboutMerchant.tr(),
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 20.sp,
              ),
        ),
        const CustomSizedBox(
          height: 5,
        ),
        Row(
          children: [
            Icon(
              Icons.location_pin,
              color: AppColors.blackColor,
              size: 18.sp,
            ),
            CustomSizedBox(
              width: 10,
            ),
            Text(
              vendorProfileModel.address??"",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontSize: 16.sp,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.blackColor,
                  ),
            ),
          ],
        ),
        const CustomSizedBox(
          height: 8,
        ),
        Text(
          vendorProfileModel.location??"",
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontSize: 16.sp,
              ),

        ),
      ],
    ).symmetricPadding(horizontal: 16);
  }
}
