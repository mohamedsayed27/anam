import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBlackTextW400 extends StatelessWidget {
  final String title;
  final double? fontSize;
  final int? maxLines;
final TextOverflow? overflow;
final TextAlign? textAlign;
  const CustomBlackTextW400({super.key, required this.title, this.fontSize, this.maxLines, this.overflow, this.textAlign,});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(fontSize: fontSize?.sp),
    );
  }
}
