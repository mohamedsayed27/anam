import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:anam/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets_path/svg_path.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

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
          onPressed: () {},
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
