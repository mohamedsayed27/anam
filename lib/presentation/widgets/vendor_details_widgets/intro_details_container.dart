import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/data/models/vendor_data_model.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_divider.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:anam/presentation/widgets/vendor_details_widgets/vendor_details_image_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../translations/locale_keys.g.dart';

class IntroDetailsContainer extends StatelessWidget {
  final VendorProfileModel vendorProfileModel;
  const IntroDetailsContainer({super.key, required this.vendorProfileModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 32.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.dividerColor,
          width: 0.3.w,
        ),
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            color: AppColors.blackColor.withOpacity(.15),
            blurRadius: 4.r,
          )
        ],
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VendorDetailsImagesWidget(vendorProfileModel: vendorProfileModel,),
                CustomSizedBox(
                  height: 2.h,
                ),
                Text(
                  vendorProfileModel.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 24.sp,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleBodyWidgets(
                  context,
                  body: LocaleKeys.ratings.tr(),
                  title: vendorProfileModel.reviewsNumber!.toString(),
                ),
                const CustomSizedBox(
                  height: 11.69,
                ),
                const CustomDivider(),
                const CustomSizedBox(
                  height: 11.69,
                ),
                titleBodyWidgets(
                  context,
                  body: LocaleKeys.ratings.tr(),
                  isTitleWidget: true,
                  titleWidget: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        vendorProfileModel.averageRating.toString(),
                        style:
                            Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  fontSize: 20.sp,
                                  color: AppColors.blackColor,
                                ),
                      ),
                      const CustomSizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.star,
                        color: AppColors.orangeColor,
                        size: 22.r,
                      ),
                    ],
                  ),
                ),
                const CustomSizedBox(
                  height: 11.69,
                ),
                const CustomDivider(),
                const CustomSizedBox(
                  height: 11.69,
                ),
                titleBodyWidgets(
                  context,
                  body: LocaleKeys.attachedPhotos.tr(),
                  title: vendorProfileModel.followersCount.toString(),
                ),
                const CustomSizedBox(
                  height: 11.69,
                ),
                const CustomDivider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget titleBodyWidgets(
    context, {
    Widget? titleWidget,
    String? title,
    required String body,
    bool isTitleWidget = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isTitleWidget) titleWidget!,
        if (isTitleWidget == false)
          Text(
            title!,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 20.sp,
                ),
          ),
        Text(
          body,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 16.sp,
              ),
        ),
      ],
    );
  }
}
