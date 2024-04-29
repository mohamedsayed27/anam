import 'package:anam/core/app_theme/custom_themes.dart';
import 'package:anam/core/assets_path/images_path.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/data/models/laborers_models/laborer_model.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_elevated_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/assets_path/svg_path.dart';
import '../../../../core/cache_helper/cache_keys.dart';
import '../../../../core/cache_helper/shared_pref_methods.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../widgets/bottom_sheets_widgets/chat_bottom.dart';
import '../../../widgets/bottom_sheets_widgets/login_bottom_sheet.dart';
import '../../../widgets/services_widgets/vet_services_images_widget.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';
import '../google_maps_screens/open_current_loctaion_screen.dart';

class LaborersServiceDetailsScreen extends StatelessWidget {
  final LaborerModel laborerModel;
  const LaborersServiceDetailsScreen({super.key, required this.laborerModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ServicesDetailsIntroImageWidget(image: laborerModel.image!,),
            const CustomSizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.storeName.tr(),
                  style: CustomThemes.darkGreyColorTextTheme(context).copyWith(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                IconTitleWidget(iconPath: SvgPath.nationality, title: laborerModel.nationality??""),
                const CustomSizedBox(
                  height: 16,
                ),
                IconTitleWidget(iconPath: SvgPath.bag, title: laborerModel.profession??""),
                const CustomSizedBox(
                  height: 16,
                ),
                 IconTitleWidget(
                    iconPath: SvgPath.phone, title: laborerModel.phone??""),
                const CustomSizedBox(
                  height: 16,
                ),
                 IconTitleWidget(
                    iconPath: SvgPath.location,
                    title: laborerModel.mapLocation??""),
                const CustomSizedBox(
                  height: 16,
                ),
                IconTitleWidget(
                    iconPath: SvgPath.email, title: laborerModel.email??"",),
                const CustomSizedBox(height: 48,),
                Row(
                  children: [
                    if(CacheHelper.getData(key: CacheKeys.token)!=null)Expanded(
                      child: CustomElevatedButton(
                        title: LocaleKeys.contactUs.tr(),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => ChatBottomSheet(receiverId:laborerModel.vendor!.id!, name: laborerModel.vendor!.name??"",image: laborerModel.vendor!.image??''),
                          );
                        },
                        titleSize: 16,
                      ),
                    ),
                    const CustomSizedBox(width: 16,),
                    Expanded(
                      child: CustomElevatedButton(
                        title: LocaleKeys.share.tr(),
                        onPressed: () {},
                        titleSize: 16,
                      ),
                    )
                  ],
                ),
                const CustomSizedBox(height: 24,),
                Text(
                  LocaleKeys.mapLocation.tr(),
                  style: CustomThemes.darkGreyColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const CustomSizedBox(height: 24,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>LocationOnMapScreen(initialLocation: LatLng(double.parse(laborerModel.coordinates!.split(",").first), double.parse(laborerModel.coordinates!.split(",").last.trim(),)),)));
                  },
                  child: SizedBox(
                    height: 193.h,
                    width: double.infinity,
                    child: Image.asset(ImagesPath.mapImage,fit: BoxFit.cover,),
                  ),
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
