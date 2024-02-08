import 'package:anam/presentation/widgets/bottom_sheets_widgets/base_bottom_sheet_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/reg_exp.dart';
import '../../../domain/controllers/auth_cubit/auth_cubit.dart';
import '../../../domain/controllers/auth_cubit/auth_state.dart';
import '../../../translations/locale_keys.g.dart';
import '../auth_widgets/custom_text_field.dart';
import '../shared_widget/bottom_sheet_title_text_widget.dart';
import '../shared_widget/custom_divider.dart';
import '../shared_widget/custom_elevated_button.dart';
import '../shared_widget/custom_sized_box.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheetWidget(
        child: SingleChildScrollView(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if(state is LoginLoadingState){
            showProgressIndicator(context);
          }
          if(state is LoginSuccessState){
            Navigator.pushNamedAndRemoveUntil(context, ScreenName.splashScreen, (route) => false);
          }
          if(state is LoginErrorState){
            Navigator.pop(context);
            showToast(errorType: 1, message: state.error);
          }
        },
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ScreenTitleTextWidget(
                  title: LocaleKeys.login,
                ),
                const CustomSizedBox(
                  height: 1,
                ),
                const CustomDivider(),
                const CustomSizedBox(
                  height: 24,
                ),
                CustomTextField(
                  hintText: LocaleKeys.email.tr(),
                  controller: cubit.loginEmailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.pleaseEnterEmail.tr();
                    } else if (!RegularExp.emailRegex.hasMatch(value)) {
                      return LocaleKeys.pleaseEnterValidateEmail.tr();
                    }
                    return null;
                  },
                  // height: 45,
                ),
                const CustomSizedBox(
                  height: 14,
                ),
                CustomTextField(
                  hintText: LocaleKeys.password.tr(),
                  controller: cubit.loginPasswordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.enterPassword.tr();
                    } else if (value.length < 9) {
                      return LocaleKeys.validatePassword.tr();
                    }
                    return null;
                  },
                  // height: 45,
                ),
                const CustomSizedBox(
                  height: 14,
                ),
                CustomElevatedButton(
                  title: LocaleKeys.login.tr(),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      cubit.login(
                        email: cubit.loginEmailController.text,
                        password: cubit.loginPasswordController.text,
                      );
                    }
                  },
                  buttonSize: Size(double.infinity, 40.h),
                ),
                const CustomSizedBox(
                  height: 24,
                ),
              ],
            ),
          );
        },
      ),
    ));
  }
}
