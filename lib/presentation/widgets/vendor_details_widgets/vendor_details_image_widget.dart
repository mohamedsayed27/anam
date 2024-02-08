import 'package:anam/data/models/vendor_data_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/app_theme/app_colors.dart';
import '../shared_widget/custom_circle_button.dart';

class VendorDetailsImagesWidget extends StatelessWidget {
  final VendorProfileModel vendorProfileModel;
  const VendorDetailsImagesWidget({super.key, required this.vendorProfileModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          height: 105.h,
          width: 75.h,
        ),
        Container(
          height: 75.h,
          width: 75.w,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: CachedNetworkImage(
            imageUrl:vendorProfileModel.image!,
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
        if(vendorProfileModel.isFollowed!=null)Positioned(
          top: 60.h,
          child: CustomCircleButton(
            width: 28.w,
            height: 28.h,
            iconPath: vendorProfileModel.isFollowed!?Icons.check:Icons.add,
            iconSize: 20.r,
            iconColor: Colors.white,
            onPressed: () {},
            backgroundColor: vendorProfileModel.isFollowed!?AppColors.primaryColor:AppColors.orangeColor,
          ),
        ),
      ],
    );
  }
}
