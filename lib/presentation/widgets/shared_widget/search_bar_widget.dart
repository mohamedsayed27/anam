import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:anam/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets_path/svg_path.dart';

class SearchBarWidget extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onSearchClicked;
  final TextEditingController? controller;
  final void Function(String)? onSubmitted;
  final bool? enabled;
  final bool autofocus;
  final bool readOnly;
  const SearchBarWidget({
    super.key,
    this.onTap,
    this.controller,
    this.onSearchClicked,
    this.enabled, this.autofocus = false, this.readOnly = false, this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(89.r),
      borderSide: BorderSide(
        color: AppColors.searchBarBorderColor,
        width: 0.89.w,
      ),
    );
    return TextField(
      onTap: onTap,
      onSubmitted: onSubmitted,
      controller: controller,
      autofocus: autofocus,
      enabled: enabled,
      readOnly: readOnly,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        disabledBorder: border,
        hintText: "البحث",
        hintStyle: Theme.of(context).textTheme.titleSmall,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: IconButton(
          onPressed: onSearchClicked,
          icon: SvgPicture.asset(
            SvgPath.searchIcon,
            colorFilter: const ColorFilter.mode(
              Color(0xff343434),
              BlendMode.srcIn,
            ),
            height: 13.h,
            width: 13.w,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.h,
          horizontal: 10.w,
        ),
      ),
    );
  }
}
