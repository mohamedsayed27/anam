import 'package:anam/core/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';

class OrderTypeDropDownButtonWidget extends StatefulWidget {
  const OrderTypeDropDownButtonWidget({super.key});

  @override
  State<OrderTypeDropDownButtonWidget> createState() => _OrderTypeDropDownButtonWidgetState();
}


class _OrderTypeDropDownButtonWidgetState extends State<OrderTypeDropDownButtonWidget> {
  String? value ;

  List<String> itemsList = [
    "مستلزمات الرحلات",
    "الرحلات الرحلات",
    "مستلزمات",
  ];
  @override
  void initState() {
    value = itemsList.first;
    super.initState();
  }
  InputBorder dropDownBorder = OutlineInputBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(9.r),
      topRight: Radius.circular(9.r),
    ),
    borderSide: BorderSide(
      color: AppColors.authBorderColor,
      width: 0.74.w,
    ),
  );
  InputBorder textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(9.r),
      bottomRight: Radius.circular(9.r),
    ),
    borderSide: BorderSide(
      color: AppColors.authBorderColor,
      width: 0.74.w,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteColor,
      child: Container(
        height: 55.h,
        width: double.infinity,
        decoration: BoxDecoration(
          // color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColors.authBorderColor,
            width: 0.74.w,
          ),
        ),
        child: Stack(
          children: [
            Text(
              "التصنيف *",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: 10.sp),
            ).onlyDirectionalPadding(top: 5,start: 12),
            DropdownButtonFormField(
              items: itemsList
                  .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
                  .toList(),
              onChanged: (value) {

              },
              // isExpanded: true,
              padding: EdgeInsetsDirectional.only(
                  top: 5.h,start: 8.w
              ),
              alignment: Alignment.topCenter,
              icon: Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 24.r,
              ),
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontSize: 12.sp),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              value: value,
            )
          ],
        ),
      ),
    );
  }
}
