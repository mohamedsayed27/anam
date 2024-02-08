import 'package:anam/core/assets_path/images_path.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/core/network/api_end_points.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/app_theme/app_colors.dart';
import '../shared_widget/title_and_body_text_widget.dart';

class RatingContainerWidget extends StatelessWidget {
  final double rating;
  final String comment;
  final String image;
  final String name;
  final String date;
  const RatingContainerWidget({super.key, required this.rating, required this.comment, required this.image, required this.name, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310.w,
      padding: EdgeInsetsDirectional.all(10.r),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.greyColor9D,
            width: 0.72.w,
          ),
          borderRadius: BorderRadius.circular(16.r),),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                ignoreGestures: true,
                itemCount: 5,
                itemSize: 18.r,
                itemPadding: EdgeInsets.zero,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: AppColors.orangeColor,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const CustomSizedBox(width: 14,),
              Text(
                "$rating",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 16.sp,),
              ),
            ],
          ),
          const CustomSizedBox(height: 7,),
          Expanded(
            child: Text(
              comment,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontSize: 16.sp, height: 1.49.h),
            ),
          ),
          const CustomSizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                height: 40.h,
                width: 40.w,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child:
                CachedNetworkImage(
                  imageUrl:"${EndPoints.imagesBaseUrl}/${image}",
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
              const CustomSizedBox(
                width: 10,
              ),
               Expanded(
                child: TileAndBodyTextWidget(
                  titleText: name,
                  bodyText: date,
                  titleFontSize: 16,
                  bodyFontSize: 16,
                  spaceBetweenTitleAndBody: 0,
                ),
              ),
            ],
          )
        ],
      ),
    ).onlyDirectionalPadding(end: 10);
  }
}
