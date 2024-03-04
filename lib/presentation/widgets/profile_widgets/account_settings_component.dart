import 'dart:async';

import 'package:anam/core/cache_helper/cache_keys.dart';
import 'package:anam/core/cache_helper/shared_pref_methods.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/domain/controllers/main_layout_cubit/main_layout_cubit.dart';
import 'package:anam/domain/controllers/requests_cubit/requests_cubit.dart';
import '../../../../domain/controllers/profile_cubit/profile_cubit.dart';
import '../../../../domain/controllers/profile_cubit/profile_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/assets_path/svg_path.dart';
import '../../../core/constants/constants.dart';
import '../../../core/enums/user_type_enum.dart';
import '../../../translations/locale_keys.g.dart';
import '../../screens/main_layout_screens/conversations_screens/conversations_screen.dart';
import '../../screens/main_layout_screens/favorite_screens/favorites_screen.dart';
import '../../screens/main_layout_screens/home_screen/home_screen.dart';
import '../../screens/main_layout_screens/orders_screens/orders_screen.dart';
import '../../screens/main_layout_screens/profile_screens/profile_screen.dart';
import '../bottom_sheets_widgets/add_order_bottom_sheet.dart';
import '../shared_widget/custom_sized_box.dart';
import 'account_seetings_item_widget.dart';

class AccountSettingsComponent extends StatelessWidget {
  const AccountSettingsComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (token != null)
          Text(
            LocaleKeys.accountSettings.tr(),
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: 20.sp, height: 1),
          ),
        if (token != null && userType != UserTypeEnum.vendor.name)
          AccountSettingItemWidget(
            onPressed: () {
              RequestsCubit.get(context).getPreviousServices();
              Navigator.pushNamed(context, ScreenName.oldOrdersScreen);
            },
            iconPath: SvgPath.oldOrders,
            title: "الطلبات السابقة",
          ),
        if (token != null && userType == UserTypeEnum.user.name)
          AccountSettingItemWidget(
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.followingScreen);
            },
            iconPath: SvgPath.followersList,
            title: "قائمة المتابعة",
          ),
        if (token != null && userType == UserTypeEnum.vendor.name)
          AccountSettingItemWidget(
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.followersScreen);
            },
            iconPath: SvgPath.followersList,
            title: "قائمة المتابعين",
          ),
        if (token != null && userType == UserTypeEnum.vendor.name)
          AccountSettingItemWidget(
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.productControlScreen);
            },
            iconPath: SvgPath.controllSetting,
            title: "لوحة التحكم",
          ),
        if (token != null)
          AccountSettingItemWidget(
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.notificationsScreen);
            },
            iconPath: SvgPath.notification,
            title: "الاشعارات",
          ),
        AccountSettingItemWidget(
          onPressed: () {},
          iconPath: SvgPath.help,
          title: "عن الشركة",
        ),
        if (token != null)
          AccountSettingItemWidget(
            onPressed: () {
              showProgressIndicator(context);
              Timer(
                const Duration(seconds: 1),
                () async {
                  await CacheHelper.clearAllData().then(
                    (value) {
                      MainLayoutCubit.get(context).screens = [
                        const ProfileScreen(),
                        const ConversationsScreen(),
                        const HomeScreen(),
                        if (userType == UserTypeEnum.user.name && token != null)
                          const FavoritesScreen(),
                        if (userType == UserTypeEnum.vendor.name &&
                            token != null)
                          const OrdersScreen(
                            isPreviousOrders: false,
                          ),
                      ];
                      Navigator.pushNamedAndRemoveUntil(
                          context, ScreenName.splashScreen, (route) => false);
                    },
                  );
                },
              );
              // print(token);
            },
            iconPath: SvgPath.logout,
            isBordered: false,
            title: LocaleKeys.logout,
          ),
      ],
    ).onlyDirectionalPadding(start: 29, end: 27);
  }
}
