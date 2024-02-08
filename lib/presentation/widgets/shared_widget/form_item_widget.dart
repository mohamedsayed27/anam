import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_themes.dart';
import 'custom_sized_box.dart';
import 'custom_text_form_field.dart';

class FormItemWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final String hintText;
  final bool isRequired;
  final bool enabled;

  const FormItemWidget({
    super.key,
    this.controller,
    required this.title,
    required this.hintText,
    this.isRequired = false, this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title.tr(),
            style: CustomThemes.greyColor34TextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            children: [
              if (isRequired)
                TextSpan(
                  text: " *",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.red,
                  ),
                )
            ],
          ),
        ),
        const CustomSizedBox(
          height: 8,
        ),
        CustomTextField(
          hintText: hintText,
          enabled: enabled,
          filled: enabled==false?true:null,
          fillColor: enabled==false?AppColors.greyColor9D:null,
          controller: controller,
        ),
      ],
    );
  }
}
