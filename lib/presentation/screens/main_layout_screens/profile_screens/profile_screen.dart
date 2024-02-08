import 'package:anam/core/app_router/screens_name.dart';
import 'package:anam/core/cache_helper/cache_keys.dart';
import 'package:anam/core/cache_helper/shared_pref_methods.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/domain/controllers/auth_cubit/auth_cubit.dart';
import 'package:anam/domain/controllers/auth_cubit/auth_state.dart';
import 'package:anam/presentation/widgets/bottom_sheets_widgets/continue_registering_bottom_sheet.dart';
import 'package:anam/presentation/widgets/bottom_sheets_widgets/login_bottom_sheet.dart';
import 'package:anam/presentation/widgets/bottom_sheets_widgets/register_bottom_sheet.dart';
import 'package:anam/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/assets_path/images_path.dart';
import '../../../../core/constants/constants.dart';
import '../../../widgets/bottom_sheets_widgets/register_as_a_vendor_bottom_sheet.dart';
import '../../../widgets/profile_widgets/account_settings_component.dart';
import '../../../widgets/profile_widgets/intro_user_details.dart';
import '../../../widgets/profile_widgets/show_your_product_container.dart';
import '../../../widgets/shared_widget/custom_divider.dart';
import '../../../widgets/shared_widget/custom_elevated_button.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    token = CacheHelper.getData(key: CacheKeys.token);
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = AuthCubit.get(context);
            return Form(
              key: key,
              child: ListView(
                children: [
                  const CustomSizedBox(
                    height: 20,
                  ),
                  Text(
                    LocaleKeys.profile.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 20.sp),
                  ).onlyDirectionalPadding(start: 28),
                  if(token==null)Text(
                    LocaleKeys.loginToReserveProducts.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 12.sp),
                  ).onlyDirectionalPadding(start: 28, end: 29),
                  const CustomSizedBox(
                    height: 16,
                  ),
                  if(token==null)CustomElevatedButton(
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
                  if(token==null)const CustomSizedBox(
                    height: 16 ,
                  ),
                  if(token==null)RichText(
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
                                  return RegisterBottomSheet();
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
                  if(token!=null)IntroUserDetails().onlyDirectionalPadding(start: 38, end: 29),
                  CustomDivider(
                    isOnlyPadding: true,
                    top: 10,
                    dividerColor: AppColors.dividerColor.withOpacity(.4),
                    start: 29,
                    end: 27,
                  ),
                  if(token!=null)const CustomSizedBox(
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
                  AccountSettingsComponent(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
