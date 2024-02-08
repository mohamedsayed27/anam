import 'package:anam/core/constants/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/dummy_data.dart';
import '../../../translations/locale_keys.g.dart';
import '../shared_widget/custom_sized_box.dart';
import '../shared_widget/product_image_widget.dart';

class AdsComponentBuilder extends StatelessWidget {
  const AdsComponentBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.ads.tr(),
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
            itemCount: DummyData.camelsDummyImages.length,
            itemBuilder: (context, index) {
              return Container(
                height: 160.h,
                width: 140.w,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Image.asset(
                  DummyData.camelsDummyImages[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
