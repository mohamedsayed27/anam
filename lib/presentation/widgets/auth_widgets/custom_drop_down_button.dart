import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';

class CustomDropDownButton<T> extends StatelessWidget {
  final void Function(T?)? onChanged;
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final double? height;
  final String? Function(T?)? validator;
  final String hint;
  const CustomDropDownButton({
    super.key,
    this.onChanged,
    this.items,
    this.value,
    this.validator,
    required this.hint, this.height,
  });

  @override
  Widget build(BuildContext context) {
    InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(9.r),
      borderSide: BorderSide(
        color: AppColors.authBorderColor,
        width: 0.74.w,
      ),
    );
    return SizedBox(
      height: height?.h,
      child: DropdownButtonFormField<T>(
        validator: validator,
        items: items,

        onChanged: onChanged,
        value: value,
        isExpanded: true,
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 24.r,
        ),
        style:
            Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 14.sp),
        borderRadius: BorderRadius.circular(9.r),
        decoration: InputDecoration(
          border: border,
          enabledBorder: border,
          disabledBorder: border,
          focusedBorder: border,
          contentPadding: EdgeInsets.symmetric(
            vertical: 9.h,
            horizontal: 10.w,
          ),
          hintText: hint,
          hintStyle: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(fontSize: 14.sp),
        ),
      ),
    );
  }
}
