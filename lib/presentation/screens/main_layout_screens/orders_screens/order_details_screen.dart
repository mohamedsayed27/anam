import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/screens/map_screen.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_divider.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_elevated_button.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:anam/translations/locale_keys.g.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/assets_path/images_path.dart';
import '../../../../core/constants/constants.dart';
import '../../../../data/models/requests/request_model.dart';
import '../../../widgets/bottom_sheets_widgets/chat_bottom.dart';
import '../../../widgets/order_widgets/order_type_container.dart';
import '../../../widgets/shared_widget/custom_app_bar.dart';
import '../../../widgets/shared_widget/title_and_body_text_widget.dart';
import '../google_maps_screens/open_current_loctaion_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final RequestModel requestModel;
  const OrderDetailsScreen({super.key, required this.requestModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: appBarSize,
        child: CustomAppBar(
          title: requestModel.title??"",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomDivider(),
              const CustomSizedBox(
                height: 27,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 68.h,
                        width: 68.w,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: CachedNetworkImage(
                          imageUrl:requestModel.userInformation!.image!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[200]!,
                            highlightColor: Colors.grey[300]!,
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      CustomSizedBox(
                        height: 8.83.h,
                      ),
                      Text(
                        requestModel.userInformation?.name??"",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontSize: 20.sp,
                                ),
                      ),
                    ],
                  ),
                  CustomSizedBox(
                    width: 50.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          requestModel.title??"",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 16.h),
                        ),
                        const CustomSizedBox(
                          height: 2.18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: AppColors.blackColor,
                              size: 12.sp,
                            ),
                            Text(
                              requestModel.mapLocation??"",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    fontSize: 14.sp,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ],
                        ),
                        const CustomSizedBox(
                          height: 2.18,
                        ),
                        Text(
                          "${requestModel.price} ${LocaleKeys.sar.tr()} ",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontSize: 16.sp,
                              ),
                        ),
                        const CustomSizedBox(
                          height: 10,
                        ),
                        const OrderTypeContainer(
                          hPadding: 19,
                          vPadding: 8.1,
                          fontSize: 10.8,
                          radius: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const CustomSizedBox(
                height: 27,
              ),
              const CustomDivider(),
              const CustomSizedBox(
                height: 28,
              ),
              TileAndBodyTextWidget(
                titleText: LocaleKeys.description.tr(),
                bodyText: requestModel.description??"",
                titleFontSize: 24,
                bodyFontSize: 16,
                bodyMaxLines: 7,
                spaceBetweenTitleAndBody: 11,
              ),
              const CustomSizedBox(
                height: 27,
              ),
              const CustomDivider(),
              const CustomSizedBox(
                height: 28,
              ),
              // const TileAndBodyTextWidget(
              //   titleText: "الملاحظات",
              //   bodyText:
              //       "لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد",
              //   titleFontSize: 24,
              //   bodyFontSize: 16,
              //   bodyMaxLines: 7,
              //   spaceBetweenTitleAndBody: 11,
              // ),
              // const CustomSizedBox(
              //   height: 19,
              // ),
              Text(
                LocaleKeys.locationOnMap.tr(),
                style: CustomThemes.darkGreyColorTextTheme(context).copyWith(
                  fontSize: 20.sp,
                  height: 1,
                  fontWeight: FontWeight.w400,
                ),
              ).symmetricPadding(horizontal: 16),
              const CustomSizedBox(height: 22,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>LocationOnMapScreen(initialLocation: LatLng(double.parse(requestModel.coordinates!.split(",").first), double.parse(requestModel.coordinates!.split(",").last.trim(),)),)));
                },
                child: SizedBox(
                  height: 193.h,
                  width: double.infinity,
                  child: Image.asset(ImagesPath.mapImage,fit: BoxFit.cover,),
                ),
              ).symmetricPadding(horizontal: 16),
              const CustomSizedBox(
                height: 40,
              ),
              CustomElevatedButton(
                title: LocaleKeys.contact.tr(),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => ChatBottomSheet(receiverId: requestModel.userInformation!.id!, name: requestModel.userInformation!.name??'',image: requestModel.userInformation!.image??''),
                  );
                },
                radius: 9.r,
                buttonSize: Size(double.infinity, 48.h),
              )
            ],
          ).symmetricPadding(horizontal: 16),
        ),
      ),
    );
  }
}
