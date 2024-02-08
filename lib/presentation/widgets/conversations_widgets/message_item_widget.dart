import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/assets_path/images_path.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageItemWidget extends StatelessWidget {
  final bool isMyMessage;

  const MessageItemWidget({super.key, required this.isMyMessage});

  @override
  Widget build(BuildContext context) {
    return isMyMessage
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 32.h,
                width: 32.w,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  ImagesPath.profile2,
                  fit: BoxFit.cover,
                ),
              ),
              const CustomSizedBox(
                width: 13,
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.greyColor9D,
                      width: 0.72.w,
                    ),
                  ),
                  child: Text(
                    "لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.إذا كنت تحتاج إلى عدد أكبر من الفقرات " ,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 16.sp, height: 1.5.h),
                  ),
                ),
              )
            ],
          ).onlyDirectionalPadding(end: 16)
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.greyColor9D,
                      width: 0.72.w,
                    ),
                  ),
                  child: Text(
                    "لقد تم توليد هى، حيث يمكننصوص الأخرى إض] تحتاج إلى عدد أكبر من الفقرات ",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 16.sp, height: 1.5.h),
                  ),
                ),
              ),
              const CustomSizedBox(
                width: 13,
              ),
              Container(
                height: 32.h,
                width: 32.w,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  ImagesPath.profile2,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ).onlyDirectionalPadding(start: 16);
  }
}
