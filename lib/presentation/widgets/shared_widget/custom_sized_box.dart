import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;
  const CustomSizedBox({super.key, this.height, this.width, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.h,
      width: width?.w,
      child: child,
    );
  }
}
