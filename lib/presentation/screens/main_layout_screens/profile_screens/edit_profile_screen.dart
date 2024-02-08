import 'package:anam/core/assets_path/images_path.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_divider.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../widgets/auth_widgets/custom_text_field.dart';
import '../../../widgets/shared_widget/custom_elevated_button.dart';
import '../../../widgets/shared_widget/custom_app_bar.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: appBarSize,
        child: const CustomAppBar(
          title: LocaleKeys.editProfileScreen,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          children: [
            const CustomDivider(),
            const CustomSizedBox(height: 49),
            Center(
              child: Stack(
                children: [
                  Container(
                    height: 171.h,
                    width: 171.w,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      ImagesPath.profile2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 171.h,
                    width: 171.w,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.black38,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add_a_photo_outlined,
                        size: 35.r, color: Colors.white),
                  ),
                ],
              ),
            ),
            const CustomSizedBox(height: 33),
            CustomTextField(
              hintText: LocaleKeys.description.tr(),
              minLines: null,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.multiline,
              height: 85,
            ),
            const CustomSizedBox(height: 13),
            CustomTextField(
              hintText: LocaleKeys.locationDescription.tr(),
              height: 45,
            ),
            const CustomSizedBox(height: 33),
            CustomElevatedButton(
              title: LocaleKeys.saveData.tr(),
              onPressed: () {},
              buttonSize: Size(double.infinity, 48.h),
            ),
          ],
        ),
      ),
    );
  }
}
