import 'dart:io';

import 'package:anam/presentation/widgets/bottom_sheets_widgets/auht_register_type_bottom_sheet.dart';
import 'package:anam/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twitter_login/twitter_login.dart';

import '../../../../core/app_router/screens_name.dart';
import '../../../../core/cache_helper/cache_keys.dart';
import '../../../../core/cache_helper/shared_pref_methods.dart';
import '../../../../core/constants/extensions.dart';
import '../../../../core/enums/user_type_enum.dart';
import '../../../../domain/controllers/auth_cubit/auth_state.dart';
import '../../../../domain/controllers/main_layout_cubit/main_layout_cubit.dart';
import '../../../../domain/controllers/products_cubit/products_cubit.dart';
import '../../../../presentation/widgets/bottom_sheets_widgets/login_bottom_sheet.dart';
import '../../../../presentation/widgets/bottom_sheets_widgets/register_bottom_sheet.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/assets_path/svg_path.dart';
import '../../../../core/constants/constants.dart';
import '../../../../domain/controllers/auth_cubit/auth_cubit.dart';
import '../../../widgets/auth_widgets/social_auth_button.dart';
import '../../../widgets/profile_widgets/account_settings_component.dart';
import '../../../widgets/profile_widgets/intro_user_details.dart';
import '../../../widgets/shared_widget/custom_divider.dart';
import '../../../widgets/shared_widget/custom_elevated_button.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  sign() async {
    final twitterLogin = TwitterLogin(
      // Consumer API keys
      apiKey: 'd8u6VdPmV7QPRSCXjxYmKln8J',
      // Consumer API Secret keys
      apiSecretKey: 'gA89LiVHwJH5k0l4zZkfqjNS0YoFd88WYIeoTgfjPA5ZDuMHsN',
      // Registered Callback URLs in TwitterApp
      // Android is a deeplink
      // iOS is a URLScheme
      redirectURI: 'mainLayoutScreen://',
    );
    final authResult = await twitterLogin.login();
    print(authResult.user?.id);
    print(authResult.user?.name);
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        // success
        break;
      case TwitterLoginStatus.cancelledByUser:
        // cancel
        break;
      case TwitterLoginStatus.error:
        // error
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    token = CacheHelper.getData(key: CacheKeys.token);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSizedBox(
              height: 20,
            ),
            Text(
              LocaleKeys.profile.tr(),
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 20.sp,
              ),
            ).symmetricPadding(horizontal: 16),
            const CustomSizedBox(
              height: 15,
            ),
            const CustomDivider().symmetricPadding(horizontal: 16),
            const CustomSizedBox(
              height: 20,
            ),
            Expanded(child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is SocialLoginLoadingState) {
                  showProgressIndicator(context);
                }
                if (state is SocialLoginSuccessState) {
                  MainLayoutCubit.get(context).handleAuthMethods();
                  Navigator.pushNamedAndRemoveUntil(
                      context, ScreenName.splashScreen, (route) => false);

                  /*if(CacheHelper.getData(key: CacheKeys.userType)==UserTypeEnum.user.name){
                    ProductsCubit.get(context).userFollowingProductsPageNumber==1;
                    ProductsCubit.get(context).getUserFollowingProducts();
                  }
                  ProductsCubit.get(context).allProductsPageNumber == 1;
                  ProductsCubit.get(context).getAllProducts();*/
                }
                if (state is SocialLoginErrorState) {
                  Navigator.pop(context);
                  showToast(errorType: 1, message: state.error);
                }
              },
              builder: (context, state) {
                AuthCubit.get(context);
                return ListView(
                  children: [
                    if (token == null)
                      Text(
                        LocaleKeys.loginToReserveProducts.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontSize: 12.sp),
                      ).onlyDirectionalPadding(start: 28, end: 29),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    if (token == null)
                      CustomElevatedButton(
                        title: LocaleKeys.login.tr(),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) {
                              return const LoginBottomSheet();
                            },
                          );
                        },
                        buttonSize: Size(double.infinity, 45.h),
                      ).symmetricPadding(horizontal: 27),
                    if (token == null)
                      const CustomSizedBox(
                        height: 16,
                      ),
                    if (token == null)
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 12.sp),
                          text: "${LocaleKeys.donnotHaveAccount.tr()} ",
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              baseline: TextBaseline.alphabetic,
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (_) {
                                      return const RegisterBottomSheet();
                                    },
                                  );
                                },
                                child: Text(
                                  LocaleKeys.subscribe.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                    fontSize: 12.sp,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.blackColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).onlyDirectionalPadding(start: 27),
                    if (token == null)
                      const CustomSizedBox(
                        height: 16,
                      ),
                    if (token == null)
                      Row(
                        children: [
                          const Expanded(child: CustomDivider()),
                          const CustomSizedBox(
                            width: 15,
                          ),
                          Text(
                            LocaleKeys.orText.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                              fontSize: 12.sp,
                            ),
                          ),
                          const CustomSizedBox(
                            width: 15,
                          ),
                          const Expanded(child: CustomDivider()),
                        ],
                      ).symmetricPadding(horizontal: 27),
                    if (token == null)
                      const CustomSizedBox(
                        height: 16,
                      ),
                    if (token == null)
                      SocialAuthButton(
                        iconPath: SvgPath.google,
                        title: "${LocaleKeys.continueUsing.tr()} Google",
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => const AuthRegisterTypeBottomSheet(socialType: 'g',),
                          );
                        },
                      ).symmetricPadding(horizontal: 27),

                    if (token == null)
                      const CustomSizedBox(
                        height: 8,
                      ),
                    if (token == null)
                      SocialAuthButton(
                        iconPath: SvgPath.twitter,
                        title: "${LocaleKeys.continueUsing.tr()} X-Twitter",
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => const AuthRegisterTypeBottomSheet(socialType: 't',),
                          );
                        },
                      ).symmetricPadding(horizontal: 27),
                    if (token != null)
                      const IntroUserDetails()
                          .onlyDirectionalPadding(start: 38, end: 29),
                    CustomDivider(
                      isOnlyPadding: true,
                      top: 10,
                      dividerColor: AppColors.dividerColor.withOpacity(.4),
                      start: 29,
                      end: 27,
                    ),
                    if (token != null)
                      const CustomSizedBox(
                        height: 25,
                      ),
                    // ShowYourProductContainer(
                    //   onPressed: () {
                    //     showModalBottomSheet(
                    //       isScrollControlled: true,
                    //       context: context,
                    //       builder: (_) => const RegisterAsAVendorBottomSheet(),
                    //     );
                    //   },
                    // ),
                    // const CustomSizedBox(
                    //   height: 16,
                    // ),
                    const AccountSettingsComponent(),
                  ],
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
