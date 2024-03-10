import 'package:anam/core/assets_path/images_path.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../data/models/requests/request_model.dart';
import '../order_widgets/order_type_container.dart';

class OrderComponent extends StatelessWidget {
  final double? itemHeight;
  final double? itemWidth;
  final double? topPadding;
  final double? borderRadius;
  final double? locationIconSize;
  final double titleFontSize;
  final double cityFontSize;
  final double descriptionFontSize;
  final double priceFontSize;
  final bool isTherePhoto;
  final double orderTypeHPadding;
  final double orderTypeVPadding;
  final double orderTypeFontSize;
  final void Function()? onPressed;
  final RequestModel requestModel;
  const OrderComponent({
    super.key,
    required this.titleFontSize,
    required this.cityFontSize,
    required this.descriptionFontSize,
    required this.priceFontSize,
    this.isTherePhoto = false,
    required this.orderTypeHPadding,
    required this.orderTypeVPadding,
    required this.orderTypeFontSize,
    this.itemHeight,
    this.itemWidth,
    this.onPressed,
    this.borderRadius,
    this.locationIconSize,
    this.topPadding, required this.requestModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius?.h ?? 4.r),
      onTap: onPressed,
      child: Container(
        width: itemWidth?.w ?? double.infinity,
        height: isTherePhoto?170.h:null,
        padding:
            EdgeInsetsDirectional.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius?.h ?? 4.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withOpacity(.10),
              blurRadius: 4.r,
              spreadRadius: 0.r,
              offset: Offset(0, 1.h),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isTherePhoto)
              Container(
                height: 41.h,
                width: 41.w,
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
            if (isTherePhoto)
              const CustomSizedBox(
                width: 5,
              ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          requestModel.title??"",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: titleFontSize.sp),
                        ),
                      ),
                      const CustomSizedBox(
                        height: 2.18,
                      ),
                      OrderTypeContainer(
                        hPadding: orderTypeHPadding,
                        vPadding: orderTypeVPadding,
                        fontSize: orderTypeFontSize,
                      ),
                    ],
                  ),
                  if (isTherePhoto)
                    const CustomSizedBox(
                      width: 20,
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: AppColors.blackColor,
                              size: locationIconSize?.r ?? 5.r,
                            ),
                            Expanded(
                              child: Text(
                                requestModel.mapLocation??"",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                      fontSize: cityFontSize.sp,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.blackColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const CustomSizedBox(
                          height: 2.18,
                        ),
                        Expanded(

                          child: Text(
                            requestModel.description??"",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: descriptionFontSize.sp,
                                ),
                          ),
                        ),
                        const CustomSizedBox(
                          height: 2.18,
                        ),
                        Text(
                          "${requestModel.price} ريال ",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontSize: priceFontSize.sp,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
