import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';


class CustomSwitchButton extends StatefulWidget {
  final double itemWidth;
  final double itemHeight;
  final double circleHeightAndWidth;
  const CustomSwitchButton({Key? key,  this.itemWidth = 52,  this.itemHeight = 32,  this.circleHeightAndWidth = 24, })
      : super(key: key);

  @override
  State<CustomSwitchButton> createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton> {
  bool isOnOrOff = false;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () async {
        setState(() {
          isOnOrOff = !isOnOrOff;

        });
      },
      child: SizedBox(
        width: widget.itemWidth.w,
        height: widget.itemHeight.h,
        child: Stack(
          children: [
            Container(
              width: widget.itemWidth.w,
              height: widget.itemHeight.h,
              decoration: BoxDecoration(
                color: !isOnOrOff ? AppColors.orderDestinationTypeWidget : AppColors.primaryColor,
                borderRadius: BorderRadius.circular(
                  15.r,
                ),
              ),
            ),
            AnimatedContainer(
              alignment:
                  !isOnOrOff ? Alignment.centerLeft : Alignment.centerRight,
              duration: const Duration(milliseconds: 150),
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: const CircleBorder(),
                child: Container(
                  width: widget.circleHeightAndWidth.w,
                  height: widget.circleHeightAndWidth.h,
                  decoration: BoxDecoration(
                    color: !isOnOrOff ? AppColors.greyTextColor : AppColors.whiteColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
