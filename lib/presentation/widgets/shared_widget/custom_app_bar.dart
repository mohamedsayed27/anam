

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: false,
        elevation: 0,
        title: Text(
          title.tr(),
          textAlign: TextAlign.start,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontSize: 20.sp),
        )

    );
  }
}