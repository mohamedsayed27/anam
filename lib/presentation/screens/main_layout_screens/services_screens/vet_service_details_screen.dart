import 'package:anam/core/app_theme/custom_themes.dart';
import 'package:anam/core/assets_path/images_path.dart';
import 'package:anam/core/constants/dummy_data.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/data/models/vet_models/vet_model.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/assets_path/svg_path.dart';
import '../../../widgets/services_widgets/vet_services_images_widget.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';

class VetServiceDetailsScreen extends StatelessWidget {
  final VetModel vetModel;
  const VetServiceDetailsScreen({super.key, required this.vetModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ServicesDetailsIntroImageWidget(image: vetModel.image!,),
            const CustomSizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vetModel.vendor!.name??"",
                  style: CustomThemes.darkGreyColorTextTheme(context).copyWith(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                IconTitleWidget(
                    iconPath: SvgPath.location,
                    title: vetModel.address??""),
                const CustomSizedBox(
                  height: 16,
                ),
                 IconTitleWidget(iconPath: SvgPath.location, title: vetModel.country!.name??""),
                const CustomSizedBox(
                  height: 16,
                ),
                IconTitleWidget(iconPath: SvgPath.personFill, title: vetModel.qualification??""),
                const CustomSizedBox(
                  height: 16,
                ),
                IconTitleWidget(
                    iconPath: SvgPath.phone, title:vetModel.phone??""),
                const CustomSizedBox(
                  height: 16,
                ),
                IconTitleWidget(
                    iconPath: SvgPath.location,
                    title: vetModel.address??""),
                const CustomSizedBox(
                  height: 16,
                ),
                IconTitleWidget(
                    iconPath: SvgPath.email, title: vetModel.vendor!.email??""),
                const CustomSizedBox(height: 48,),
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        title: "تواصل معنا",
                        onPressed: () {},
                        titleSize: 16,
                      ),
                    ),
                    const CustomSizedBox(width: 16,),
                    Expanded(
                      child: CustomElevatedButton(
                        title: "مشاركة",
                        onPressed: () {},
                        titleSize: 16,
                      ),
                    )
                  ],
                ),
                const CustomSizedBox(height: 24,),
                Text(
                  "الموقع على الخريطة",
                  style: CustomThemes.darkGreyColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const CustomSizedBox(height: 24,),
                SizedBox(
                  height: 193.h,
                  width: double.infinity,
                  child: Image.asset(ImagesPath.mapImage,fit: BoxFit.cover,),
                ),
              ],
            ).symmetricPadding(horizontal: 16)
          ],
        ),
      ),
    );
  }
}

class IconTitleWidget extends StatelessWidget {
  final String iconPath;
  final String title;

  const IconTitleWidget({
    super.key,
    required this.iconPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 18.w,
          height: 18.h,
          colorFilter: const ColorFilter.mode(
            AppColors.darkGreyTextColor,
            BlendMode.srcIn,
          ),
        ),
        const CustomSizedBox(
          width: 24,
        ),
        Text(
          title,
          style: CustomThemes.darkGreyColorTextTheme(context).copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
