import 'package:anam/core/constants/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/assets_path/images_path.dart';
import '../../../core/constants/dummy_data.dart';
import '../../../core/network/api_end_points.dart';
import '../../../data/models/vendor_data_model.dart';
import '../../../translations/locale_keys.g.dart';
import '../shared_widget/custom_sized_box.dart';
import '../shared_widget/product_image_widget.dart';

class VetComponentBuilder extends StatelessWidget {
  final VendorProfileModel vendorProfileModel;
  const VetComponentBuilder({super.key, required this.vendorProfileModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.veterinaryServices.tr(),
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontSize: 20.sp,
          ),
        ).onlyDirectionalPadding(start: 16),
        SizedBox(
          height: 160.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
            separatorBuilder: (_,index) => CustomSizedBox(width: 10.w,),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                height: 160.h,
                width: 140.w,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: CachedNetworkImage(
                  imageUrl:"${vendorProfileModel.veterinarians?[index].image}"??"",
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
              );
            },
          ),
        )
      ],
    );
  }
}
