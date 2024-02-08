import 'package:anam/core/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final void Function()? onTap;
  final bool expands;
  final bool enabled;
  final double? height;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final TextAlignVertical? textAlignVertical;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.maxLines,
    this.minLines,
    this.expands = false,
    this.enabled = true,
    this.keyboardType,
    this.textAlignVertical,
    this.height, this.prefix, this.onTap, this.validator,
  });

  @override
  Widget build(BuildContext context) {
    InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        color: AppColors.authBorderColor,
        width: 0.74.w,
      ),
    );
    return SizedBox(
      height: height?.h,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        minLines: minLines,
        expands: expands,
        onTap: onTap,
        enabled: enabled,
        keyboardType: keyboardType,
        textAlignVertical: textAlignVertical,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(fontSize: 12.sp),
        decoration: InputDecoration(
          border: border,
          enabledBorder: border,
          disabledBorder: border,
          prefixIcon: prefix,
          focusedBorder: border,
          contentPadding: EdgeInsets.symmetric(
            vertical: 9.h,
            horizontal: 10.w,
          ),
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintStyle: Theme.of(context)
              .textTheme
              .titleSmall
        ),
      ),
    );
  }
}
