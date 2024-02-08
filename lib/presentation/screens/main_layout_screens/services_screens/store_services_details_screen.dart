import 'package:anam/core/app_theme/custom_themes.dart';
import 'package:anam/core/assets_path/images_path.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/data/models/stores_models/store_data_model.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/assets_path/svg_path.dart';
import '../../../widgets/services_widgets/store_images_list_widget.dart';
import '../../../widgets/services_widgets/vet_services_images_widget.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';

class StoreServiceDetailsScreen extends StatelessWidget {
  final StoreDataModel storeDataModel;
  const StoreServiceDetailsScreen({super.key, required this.storeDataModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ServicesDetailsIntroImageWidget(image: storeDataModel.image!,),
            const CustomSizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storeDataModel.name??"",
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
                    title: storeDataModel.mapLocation??""),
                const CustomSizedBox(
                  height: 16,
                ),
                IconTitleWidget(iconPath: SvgPath.location, title: storeDataModel.country!.name??""),
                const CustomSizedBox(
                  height: 16,
                ),
                IconTitleWidget(
                    iconPath: SvgPath.phone, title: storeDataModel.phone??""),
                const CustomSizedBox(
                  height: 16,
                ),
                IconTitleWidget(
                    iconPath: SvgPath.location,
                    title: storeDataModel.mapLocation??""),
                const CustomSizedBox(
                  height: 16,
                ),
                IconTitleWidget(
                    iconPath: SvgPath.email, title: storeDataModel.email??""),
                const CustomSizedBox(
                  height: 16,
                ),
                StoreImagesComponentBuilder(images: storeDataModel.truckImages!,),
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
          // colorFilter: const ColorFilter.mode(
          //   AppColors.darkGreyTextColor,
          //   BlendMode.srcIn,
          // ),
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
