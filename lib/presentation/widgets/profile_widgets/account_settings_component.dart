import 'dart:async';

import 'package:anam/core/cache_helper/cache_keys.dart';
import 'package:anam/core/cache_helper/shared_pref_methods.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/domain/controllers/requests_cubit/requests_cubit.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/assets_path/svg_path.dart';
import '../../../core/constants/constants.dart';
import '../../../core/enums/user_type_enum.dart';
import '../../../translations/locale_keys.g.dart';
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
        if (CacheHelper.getData(key: CacheKeys.token) != null)
          Text(
            LocaleKeys.accountSettings.tr(),
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: 20.sp, height: 1),
          ),
        if (CacheHelper.getData(key: CacheKeys.token) != null && userType != UserTypeEnum.vendor.name)
          AccountSettingItemWidget(
            onPressed: () {
              RequestsCubit.get(context).getPreviousRequests();
              Navigator.pushNamed(context, ScreenName.oldOrdersScreen);
            },
            iconPath: SvgPath.oldOrders,
            title: LocaleKeys.previousOrders.tr(),
          ),
        if (CacheHelper.getData(key: CacheKeys.token) != null && userType == UserTypeEnum.user.name)
          AccountSettingItemWidget(
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.followingScreen);
            },
            iconPath: SvgPath.followersList,
            title: LocaleKeys.followingList.tr(),
          ),
        if (CacheHelper.getData(key: CacheKeys.token) != null && userType == UserTypeEnum.vendor.name)
          AccountSettingItemWidget(
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.followersScreen);
            },
            iconPath: SvgPath.followersList,
            title: LocaleKeys.followersList.tr(),
          ),
        if (CacheHelper.getData(key: CacheKeys.token) != null && userType == UserTypeEnum.vendor.name)
          AccountSettingItemWidget(
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.productControlScreen);
            },
            iconPath: SvgPath.controllSetting,
            title: LocaleKeys.controlPanel.tr(),
          ),
        if (CacheHelper.getData(key: CacheKeys.token) != null && userType == UserTypeEnum.vendor.name)
          AccountSettingItemWidget(
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.packageSubscriptionsScreen);
            },
            iconPath: SvgPath.choices,
            title: LocaleKeys.subscriptions.tr(),
          ),
        if (CacheHelper.getData(key: CacheKeys.token) != null)
          AccountSettingItemWidget(
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.notificationsScreen);
            },
            iconPath: SvgPath.notification,
            title: LocaleKeys.notifications.tr(),
          ),
        // AccountSettingItemWidget(
        //   onPressed: () {},
        //   iconPath: SvgPath.help,
        //   title: "عن الشركة",
        // ),

        AccountSettingItemWidget(
          onPressed: () {
            showProgressIndicator(context);
            if(CacheHelper.getData(key: CacheKeys.initialLocale)=="ar"||CacheHelper.getData(key: CacheKeys.initialLocale)==null){
              EasyLocalization.of(context)?.setLocale(Locale('en'));
              CacheHelper.saveData(key: CacheKeys.initialLocale, value: "en");
            }else{
              EasyLocalization.of(context)?.setLocale(Locale('ar'));
              CacheHelper.saveData(key: CacheKeys.initialLocale, value: "ar");
            }
            Timer(
              const Duration(seconds: 1),
                  () async {
                    // MainLayoutCubit.get(context).handleAuthMethods();
                    Navigator.pushNamedAndRemoveUntil(
                        context, ScreenName.splashScreen, (route) => false);
              },
            );
            // print(token);
          },
          iconPath: SvgPath.lang,
          isBordered: true,
          title: LocaleKeys.lang,
        ),
        if (CacheHelper.getData(key: CacheKeys.token) != null)
          AccountSettingItemWidget(
            onPressed: () {
              showProgressIndicator(context);


              Timer(
                const Duration(seconds: 1),
                () async {
                  await CacheHelper.clearAllData().then(
                    (value) {
                      Phoenix.rebirth(context);
                      // MainLayoutCubit.get(context).handleAuthMethods();
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
