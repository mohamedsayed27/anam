import 'package:anam/core/constants/dummy_data.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/assets_path/svg_path.dart';
import '../shared_widget/custom_sized_box.dart';

class InfoWindowWidget extends StatefulWidget {
  const InfoWindowWidget({super.key,});

  @override
  State<InfoWindowWidget> createState() => _InfoWindowWidgetState();
}

class _InfoWindowWidgetState extends State<InfoWindowWidget> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(9.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.12),
            blurRadius: 12.r,
            offset: Offset(0, 4.h), // changes position of shadow
          ),
        ]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: 165.h,
                width: 255.w,
                child: PageView.builder(
                  itemCount: DummyData.camelsDummyImages.length,
                  controller: controller,
                  itemBuilder: (BuildContext context, int index) {
                    return CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                      "}",
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
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    );
                    //   Image.asset(
                    //   DummyData.camelsDummyImages[index],
                    //   fit: BoxFit.cover,
                    // );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SmoothPageIndicator(
                  controller: controller,
                  count: DummyData.camelsDummyImages.length,
                  effect: SlideEffect(
                    spacing: 3.9.w,
                    radius: 4.0,
                    dotWidth: 4.6.w,
                    dotHeight: 4.6.h,
                    paintStyle: PaintingStyle.fill,
                    dotColor: Colors.white.withOpacity(.7),
                    activeDotColor: Colors.white,
                  ),
                ),
              ).symmetricPadding(vertical: 9.38),
              PositionedDirectional(
                start: 14.w,
                top: 14.h,
                child: InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    SvgPath.like,
                    width: 15.w,
                    height: 13.h,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 10.sp,
                      color: AppColors.blackColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "2.0",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 10.sp,
                          color: AppColors.blackColor,
                        ),
                      ),
                      Icon(
                        Icons.star,
                        color: AppColors.orangeColor,
                        size: 17.r,
                      ),
                    ],
                  )
                ],
              ),
              const CustomSizedBox(
                height: 2,
              ),
              Text(
                "نص تلقائي  نص تلقائي",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 10.sp,
                ),
              ),
              const CustomSizedBox(
                height: 2,
              ),
              Text(
                "2,900 ريال",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 10.sp,
                  color: AppColors.blackColor,

                ),
              ),
            ],
          ).symmetricPadding(horizontal: 18,vertical: 5),
        ],
      ),
    );
  }
}
