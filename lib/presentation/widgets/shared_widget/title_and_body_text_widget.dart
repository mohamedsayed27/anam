import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';

class TileAndBodyTextWidget extends StatelessWidget {
  final String titleText;
  final String bodyText;
  final double spaceBetweenTitleAndBody;
  final double titleFontSize;
  final double bodyFontSize;
  final double? horizontalPadding;
  final int? titleMaxLines;
  final int? bodyMaxLines;

  const TileAndBodyTextWidget({
    super.key,
    required this.titleText,
    required this.bodyText,
    required this.titleFontSize,
    required this.bodyFontSize,
    required this.spaceBetweenTitleAndBody, this.horizontalPadding, this.titleMaxLines, this.bodyMaxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          maxLines: titleMaxLines??1,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: titleFontSize.sp,
                color: AppColors.blackColor,
              ),
        ),
        CustomSizedBox(
          height: spaceBetweenTitleAndBody,
        ),
        Text(
          bodyText,
          maxLines: bodyMaxLines??1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontSize: bodyFontSize.sp,
              ),
        ),
      ],
    ).symmetricPadding(horizontal: horizontalPadding);
  }
}
