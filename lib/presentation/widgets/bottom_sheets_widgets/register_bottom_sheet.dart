import 'package:anam/core/assets_path/svg_path.dart';
import 'package:anam/core/constants/constants.dart';
import 'package:anam/domain/controllers/auth_cubit/auth_cubit.dart';
import 'package:anam/domain/controllers/auth_cubit/auth_state.dart';
import 'package:anam/presentation/widgets/auth_widgets/phone_auth_component.dart';
import 'package:anam/presentation/widgets/auth_widgets/social_auth_button.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_divider.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_elevated_button.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:anam/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import 'base_bottom_sheet_widget.dart';
import '../shared_widget/bottom_sheet_title_text_widget.dart';
import 'continue_registering_bottom_sheet.dart';

class RegisterBottomSheet extends StatefulWidget {

  const RegisterBottomSheet({super.key, });

  @override
  State<RegisterBottomSheet> createState() => _RegisterBottomSheetState();
}

class _RegisterBottomSheetState extends State<RegisterBottomSheet> {

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseBottomSheetWidget(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ScreenTitleTextWidget(
                    title: LocaleKeys.loginOrSubscribe,
                  ),
                  const CustomSizedBox(
                    height: 17,
                  ),
                  const CustomDivider(),
                  const CustomSizedBox(
                    height: 12,
                  ),
                  Text(
                    LocaleKeys.welcome.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 12.sp),
                  ),
                  const CustomSizedBox(
                    height: 13,
                  ),
                  PhoneComponent(
                    validator: (value){
                      if(value!.isEmpty){
                        return LocaleKeys.pleaseEnterYourPhone.tr();
                      }else if(value.length<9){
                        return LocaleKeys.invalidPhoneNumber.tr();
                      }
                      return null;
                    },
                  ),
                  // const CustomSizedBox(
                  //   height: 17,
                  // ),
                  // RichText(
                  //   textAlign: TextAlign.start,
                  //   text: TextSpan(
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .headlineSmall!
                  //         .copyWith(fontSize: 12.sp),
                  //     text:
                  //         "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من",
                  //     children: [
                  //       WidgetSpan(
                  //         alignment: PlaceholderAlignment.middle,
                  //         baseline: TextBaseline.alphabetic,
                  //         child: InkWell(
                  //           onTap: () {},
                  //           child: Text(
                  //             " مولد النص العربى",
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .headlineMedium!
                  //                 .copyWith(
                  //                   fontSize: 12.sp,
                  //                   decoration: TextDecoration.underline,
                  //                   decorationColor: AppColors.blackColor,
                  //                 ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const CustomSizedBox(
                    height: 17,
                  ),
                  CustomElevatedButton(
                    title: LocaleKeys.continueText.tr(),
                    onPressed: (){
                      if(cubit.chosenCity!=null){
                        if(formKey.currentState!.validate()){
                          Navigator.of(context).pop();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) {
                              return const ContinueRegisteringBottomSheet();
                            },
                          );
                        }
                      }else{
                        showToast(errorType: 1, message: LocaleKeys.pleaseChooseYourCountry.tr(),);
                      }

                    },
                    buttonSize: Size(double.infinity, 40.h),
                  ),
                  const CustomSizedBox(
                    height: 17,
                  ),
                  Row(
                    children: [
                      const Expanded(child: CustomDivider()),
                      const CustomSizedBox(
                        width: 15,
                      ),
                      Text(
                        LocaleKeys.orText.tr(),
                        style:
                            Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  fontSize: 12.sp,
                                ),
                      ),
                      const CustomSizedBox(
                        width: 15,
                      ),
                      const Expanded(child: CustomDivider()),
                    ],
                  ),
                  const CustomSizedBox(
                    height: 17,
                  ),
                  SocialAuthButton(
                    iconPath: SvgPath.google,
                    title: "${LocaleKeys.continueUsing.tr()} Google",
                    onPressed: () {},
                  ),
                  const CustomSizedBox(
                    height: 13,
                  ),
                  SocialAuthButton(
                    iconPath: SvgPath.facebook,
                    title: "${LocaleKeys.continueUsing.tr()} Facebook",
                    onPressed: () {},
                  ),
                  const CustomSizedBox(
                    height: 13,
                  ),
                  SocialAuthButton(
                    iconPath: SvgPath.appleLogo,
                    title: "${LocaleKeys.continueUsing.tr()} Apple",
                    onPressed: () {},
                  ),
                  const CustomSizedBox(
                    height: 13,
                  ),
                  SocialAuthButton(
                    iconPath: SvgPath.email,
                    title: "${LocaleKeys.continueUsing.tr()} Gmail",
                    onPressed: () {},
                  ),
                  const CustomSizedBox(
                    height: 13,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
