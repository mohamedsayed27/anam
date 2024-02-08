import 'package:anam/presentation/widgets/shared_widget/custom_outlined_button.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialAuthButton extends StatelessWidget {
  final String iconPath;
  final String title;
  final void Function()? onPressed;

  const SocialAuthButton({super.key, required this.iconPath, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      onPressed: onPressed,
      height: 36.h,
      width : double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            height: 18.h,
            width: 18.w,
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 12.sp,
                  ),
            ),
          ),
          const CustomSizedBox(
            height: 18,
            width: 18,
          ),
        ],
      ),
    );
  }
}
