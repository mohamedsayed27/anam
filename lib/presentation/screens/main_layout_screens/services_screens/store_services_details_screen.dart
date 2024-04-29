import 'package:anam/core/app_theme/custom_themes.dart';
import 'package:anam/core/assets_path/images_path.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/data/models/stores_models/store_data_model.dart';
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
import '../../../widgets/services_widgets/store_images_list_widget.dart';
import '../../../widgets/services_widgets/vet_services_images_widget.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';
import '../google_maps_screens/open_current_loctaion_screen.dart';

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
                    if(CacheHelper.getData(key: CacheKeys.token)!=null) Expanded(
                      child: CustomElevatedButton(
                        title: LocaleKeys.contactUs.tr(),
                        onPressed: () {

                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => ChatBottomSheet(receiverId:storeDataModel.vendor!.id!, name: storeDataModel.vendor!.name??'',image: storeDataModel.vendor!.image??'',),
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
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>LocationOnMapScreen(initialLocation: LatLng(double.parse(storeDataModel.coordinates!.split(",").first), double.parse(storeDataModel.coordinates!.split(",").last.trim(),)),)));
                  },
                  child: SizedBox(
                    height: 193.h,
                    width: double.infinity,
                    child: Image.asset(ImagesPath.mapImage,fit: BoxFit.cover,),
                  ),
                )
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
