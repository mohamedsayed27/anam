import 'package:anam/core/app_theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../translations/locale_keys.g.dart';
import '../shared_widget/title_and_body_text_widget.dart';

class PersonalDataItemWidget extends StatelessWidget {
  final String title;
  final String body;

  const PersonalDataItemWidget({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TileAndBodyTextWidget(
          titleText: title.tr(),
          bodyText: body.tr(),
          titleFontSize: 12,
          bodyFontSize: 12,
          spaceBetweenTitleAndBody: 2,
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            LocaleKeys.edit.tr(),
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 12.sp,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.blackColor,
                ),
          ),
        )
      ],
    );
  }
}
