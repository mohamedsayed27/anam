import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/assets_path/fonts_path.dart';
import 'package:anam/core/assets_path/svg_path.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../conversations_widgets/chat_text_field.dart';
import '../conversations_widgets/message_item_widget.dart';

class ChatBottomSheet extends StatelessWidget {
  const ChatBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22.r),
          topRight: Radius.circular(22.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 45.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 36.w),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22.r),
                topRight: Radius.circular(22.r),
              ),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    SvgPath.cancel,
                    width: 13.w,
                    height: 13.h,
                    colorFilter: const ColorFilter.mode(
                      AppColors.whiteColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const CustomSizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    "احمد خالد",
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: AppColors.whiteColor,
                      fontFamily: FontsPath.boutrosAsma,
                    ),
                  ),
                )
              ],
            ),
          ),
          const CustomSizedBox(
            height: 15,
          ),
          SizedBox(
            height: 300.h,
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return MessageItemWidget(
                        isMyMessage: index % 2 == 0 ? true : false)
                    .onlyDirectionalPadding(bottom: 15);
              },
            ),
          ).symmetricPadding(horizontal: 27),
          const CustomSizedBox(
            height: 10,
          ),
          const ChatTextField().symmetricPadding(horizontal: 27),
          const CustomSizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
