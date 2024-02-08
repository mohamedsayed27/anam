import 'package:anam/core/constants/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../translations/locale_keys.g.dart';
import '../shared_widget/custom_sized_box.dart';
import '../shared_widget/order_component.dart';
import 'order_component_widget.dart';

class VendorOrdersComponent extends StatelessWidget {
  const VendorOrdersComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.orders.tr(),
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontSize: 20.sp,
          ),
        ).onlyDirectionalPadding(start: 16),
        const CustomSizedBox(
          height: 10,
        ),
        SizedBox(
          height: 150.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
            separatorBuilder: (_,index) => const CustomSizedBox(width: 10,),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return  const OrderComponentWidget();
            },
          ),
        )
      ],
    );
  }
}
