import 'package:anam/core/assets_path/images_path.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_elevated_button.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/custom_themes.dart';

class TechServicesWidget extends StatelessWidget {
  const TechServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 325.h,
              width: double.infinity,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Image.asset(
                ImagesPath.personDummyImage,
                fit: BoxFit.cover,
              ),
            ),
            PositionedDirectional(
              start: 15.w,
              bottom: 18.h,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ScreenName.vendorDetailsScreen);
                },
                child: Container(
                  height: 48.h,
                  width: 48.w,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    ImagesPath.profilePicture,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
        const CustomSizedBox(height: 16,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "اسم المتجر",
              style: CustomThemes.greyColor34TextTheme(context).copyWith(
                fontSize: 14.sp,
                height: 1,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                CustomElevatedButton(
                  title: "تعديل",
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  buttonSize: Size(120.w, 40.h),
                ),
                const CustomSizedBox(
                  width: 8,
                ),
                CustomElevatedButton(
                  title: "متابعة",
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  buttonSize: Size(120.w, 40.h),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
