

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  const CustomAppBar({super.key, required this.title, this.backgroundColor, this.titleStyle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: false,
        backgroundColor: backgroundColor,

        elevation: 0,
        title: Text(
          title.tr(),
          textAlign: TextAlign.start,
          style: titleStyle??Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontSize: 20.sp),
        )

    );
  }
}