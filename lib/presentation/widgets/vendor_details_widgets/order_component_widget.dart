import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../order_widgets/order_type_container.dart';
import '../shared_widget/custom_sized_box.dart';

class OrderComponentWidget extends StatelessWidget {

  final void Function()? onPressed;
  const OrderComponentWidget({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onPressed,
      child: Container(
        width: 322.w,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withOpacity(.10),
              blurRadius: 4.r,
              spreadRadius: 0.r,
              offset: Offset(0, 1.h),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "نص تلقائي",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 18.sp),
                ),
                const CustomSizedBox(
                  height: 2.18,
                ),
                const OrderTypeContainer(
                  hPadding: 10,
                  vPadding: 6,
                  fontSize: 12,
                  radius: 4,
                ),
              ],
            ),
            // Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_pin,
                  color: AppColors.grey7DColor,
                  size: 14.r,
                ),
                Text(
                  "الرياض، السعودية",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(
                    fontSize: 14.sp,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.grey7DColor,
                  ),
                ),
              ],
            ),
            const CustomSizedBox(
              height: 3,
            ),
            Text(
              "نص تلقائي نص تلقائي نص تلقائي",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(
                fontSize: 14.sp,
              ),
            ),
            const CustomSizedBox(
              height: 3,
            ),
            Text(
              "2,500 ريال ",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
