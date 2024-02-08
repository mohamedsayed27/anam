import 'package:anam/core/assets_path/images_path.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shared_widget/title_and_body_text_widget.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 42.h,
        width: 42.w,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Image.asset(
          ImagesPath.profilePicture,
          fit: BoxFit.cover,
        ),
      ),
      title: const TileAndBodyTextWidget(
        titleText: "أحمد خالد",
        bodyText: "لقد تم توليد هذا النص من مولد النص العربى",
        titleFontSize: 16,
        bodyFontSize: 14,
        bodyMaxLines: 1,
        titleMaxLines: 1,
        spaceBetweenTitleAndBody: 0,
      ),
      contentPadding: EdgeInsets.zero,
      trailing: Text(
        "15:41",
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
          fontSize: 12.sp,
        ),
      ),
    ).symmetricPadding(horizontal: 16);
  }
}
