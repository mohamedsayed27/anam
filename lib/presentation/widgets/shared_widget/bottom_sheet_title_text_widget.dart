import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets_path/svg_path.dart';
import '../../../translations/locale_keys.g.dart';

class ScreenTitleTextWidget extends StatelessWidget {
  final String title;
  const ScreenTitleTextWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.tr(),
      textAlign: TextAlign.start,
      style: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(fontSize: 20.sp),
    );
  }
}
