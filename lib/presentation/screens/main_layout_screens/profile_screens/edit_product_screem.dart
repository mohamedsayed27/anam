import 'package:anam/core/assets_path/images_path.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../../try_screen.dart';
import '../../../widgets/auth_widgets/custom_drop_down_button.dart';
import '../../../widgets/auth_widgets/custom_text_field.dart';
import '../../../widgets/shared_widget/custom_divider.dart';
import '../../../widgets/shared_widget/custom_elevated_button.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 20.h),
          children: [
            Text(
              "تعديل منتج",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: 20.sp),
            ),
            const CustomSizedBox(
              height: 10,
            ),
            const CustomDivider(),
            const CustomSizedBox(
              height: 10,
            ),
            Text(
              "عرض 001",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: 16.sp),
            ),
            const CustomSizedBox(
              height: 17,
            ),
            CustomDropDownButton(
              height: 45,
              onChanged: (value) {},
              hint: LocaleKeys.mainClassification.tr(),
              items: items
                  .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e,
                    style:
                    Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 14.sp)),
              ))
                  .toList(),
              value: mainCategoryValue,
            ),
            const CustomSizedBox(
              height: 11,
            ),
            CustomDropDownButton(
              height: 45,
              onChanged: (value) {},
              hint: LocaleKeys.subCategory.tr(),
              items: items
                  .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
                  .toList(),
              value: subcategoryValue,
            ),
            const CustomSizedBox(
              height: 11,
            ),
            CustomTextField(
              hintText: LocaleKeys.displayName.tr(),
              height: 45,
            ),
            const CustomSizedBox(
              height: 11,
            ),
            CustomTextField(
              hintText: LocaleKeys.price.tr(),
              height: 45,
            ),
            const CustomSizedBox(
              height: 11,
            ),
            CustomTextField(
              hintText: LocaleKeys.description.tr(),
              minLines: null,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.multiline,
              height: 140,
            ),
            const CustomSizedBox(
              height: 11,
            ),
            CustomTextField(
              prefix: Icon(
                Icons.camera_alt,
                size: 20.r,
                color: AppColors.authBorderColor,
              ),
              hintText: LocaleKeys.uploadImages.tr(),
              enabled: false,
              height: 45,
            ),
            const CustomSizedBox(
              height: 11,
            ),
            CustomSizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 36.h,
                    width: 50.w,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Image.asset(
                      ImagesPath.uploadedImages,
                      fit: BoxFit.cover,
                    ),
                  ).onlyDirectionalPadding(end: 5);
                },
              ),
            ),
            const CustomSizedBox(
              height: 11,
            ),
            CustomTextField(
              prefix: Icon(
                Icons.link_rounded,
                size: 20.r,
                color: AppColors.authBorderColor,
              ),
              hintText: LocaleKeys.youtubeLink.tr(),
              height: 45,
            ),
            const CustomSizedBox(
              height: 11,
            ),
            CustomTextField(
              hintText: LocaleKeys.pros.tr(),
              minLines: null,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.multiline,
              height: 86,
            ),
            const CustomSizedBox(
              height: 11,
            ),
            CustomTextField(
              hintText: LocaleKeys.cons.tr(),
              minLines: null,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.multiline,
              height: 86,
            ),
            const CustomSizedBox(
              height: 40,
            ),
            CustomElevatedButton(
              title: LocaleKeys.uploadYourProduct.tr(),
              onPressed: () {},
              buttonSize: Size(double.infinity, 48.h),
            ),
          ],
        ),
      ),
    );
  }
}
