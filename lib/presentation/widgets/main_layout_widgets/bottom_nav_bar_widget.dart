import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/assets_path/svg_path.dart';
import '../../../core/constants/constants.dart';
import '../../../core/enums/user_type_enum.dart';

class BottomNavBarWidget extends StatelessWidget {
  final void Function(int)? onTap;
  final int currentIndex;

  const BottomNavBarWidget({
    super.key,
    this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            blurRadius: 4.r,
            color: AppColors.blackColor.withOpacity(0.25),
          ),
        ],
      ),
      child: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        iconSize: 26.r,
        items: [
          BottomNavigationBarItem(
            label: "",
            icon: SvgPicture.asset(
              currentIndex == 0
                  ? SvgPath.profileFillNavIcon
                  : SvgPath.profileNavIcon,
              width: 26.w,
              height: 26.h,
            ),
          ),
          if (token != null)
            BottomNavigationBarItem(
              label: "",
              icon: SvgPicture.asset(
                currentIndex == 1
                    ? SvgPath.chatFillNavIcon
                    : SvgPath.chatNavIcon,
                width: 26.w,
                height: 26.h,
              ),
            ),
          if (token == null)
            BottomNavigationBarItem(
              label: "",
              icon: SvgPicture.asset(
                currentIndex == 1
                    ? SvgPath.homeFillNavIcon
                    : SvgPath.homeNavIcon,
                width: 26.w,
                height: 26.h,
              ),
            ),
          if (token != null)BottomNavigationBarItem(
            label: "",
            icon: SvgPicture.asset(
              currentIndex == 2 ? SvgPath.homeFillNavIcon : SvgPath.homeNavIcon,
              width: 26.w,
              height: 26.h,
            ),
          ),
          if (userType == UserTypeEnum.user.name && token != null)
            BottomNavigationBarItem(
              label: "",
              icon: SvgPicture.asset(
                currentIndex == 3
                    ? SvgPath.favoriteFillNavIcon
                    : SvgPath.favoriteNavIcon,
                width: 26.w,
                height: 26.h,
              ),
            ),
          if (userType == UserTypeEnum.vendor.name && token != null)
            BottomNavigationBarItem(
              label: "",
              icon: SvgPicture.asset(
                currentIndex == 3
                    ? SvgPath.ordersFillNavIcon
                    : SvgPath.ordersNavIcon,
                width: 26.w,
                height: 26.h,
              ),
            ),
        ],
      ),
    );
  }
}
