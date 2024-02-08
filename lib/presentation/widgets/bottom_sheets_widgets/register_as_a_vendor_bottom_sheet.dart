import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/assets_path/images_path.dart';
import 'package:anam/presentation/widgets/auth_widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../translations/locale_keys.g.dart';
import '../../../try_screen.dart';
import '../auth_widgets/custom_drop_down_button.dart';
import '../auth_widgets/phone_auth_component.dart';
import '../shared_widget/custom_divider.dart';
import '../shared_widget/custom_elevated_button.dart';
import '../shared_widget/custom_sized_box.dart';
import 'base_bottom_sheet_widget.dart';
import '../shared_widget/bottom_sheet_title_text_widget.dart';

class RegisterAsAVendorBottomSheet extends StatelessWidget {
  const RegisterAsAVendorBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheetWidget(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const ScreenTitleTextWidget(
              title: LocaleKeys.vendorSubscription,
            ),
            const CustomSizedBox(
              height: 17,
            ),
            const CustomDivider(),
            const CustomSizedBox(
              height: 12,
            ),
            Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: 90.h,
                    width: 90.w,
                  ),
                  Positioned(
                    top: 0,
                    child: Image.asset(
                      ImagesPath.account,
                      height: 82.h,
                      width: 82.w,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 10,
                      child: Icon(
                        Icons.add_circle,
                        color: const Color(0xffB3B3B3),
                        size: 20.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const CustomSizedBox(
              height: 12,
            ),
            Text(
              LocaleKeys.welcome.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontSize: 14.sp),
            ),
            const CustomSizedBox(
              height: 11,
            ),
            CustomTextField(
              hintText: LocaleKeys.name.tr(),
              height: 45,
            ),
            const CustomSizedBox(
              height: 11,
            ),
            CustomTextField(
              hintText: LocaleKeys.email.tr(),
              height: 45,
            ),
            const CustomSizedBox(
              height: 11,
            ),
            const PhoneComponent(),
            const CustomSizedBox(
              height: 11,
            ),
            CustomTextField(
              prefix: Icon(
                Icons.my_location,
                size: 20.r,
                color: AppColors.authBorderColor,
              ),
              hintText: LocaleKeys.locationOnMap.tr(),
              enabled: false,
              height: 45,
            ),
            const CustomSizedBox(
              height: 11,
            ),
            CustomDropDownButton(
              height: 45,
              onChanged: (value){

              },
              hint: LocaleKeys.stateOrRegion.tr(),
              items: items
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              value: stateOrRegionValue,
            ),
            const CustomSizedBox(
              height: 11,
            ),
            CustomDropDownButton(
              height: 45,
              onChanged: (value){

              },
              hint: LocaleKeys.city.tr(),
              items: items
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              value: cityValue,
            ),
            const CustomSizedBox(
              height: 11,
            ),
            CustomTextField(
              hintText: LocaleKeys.locationDescription.tr(),
              height: 45,
            ),
            const CustomSizedBox(
              height: 40,
            ),
            CustomElevatedButton(
              title: LocaleKeys.continueText.tr(),
              onPressed: () {},
              buttonSize: Size(double.infinity, 40.h),
            ),
          ],
        ),
      ),
    );
  }
}
