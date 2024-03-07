import 'package:anam/core/app_router/screens_name.dart';
import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/constants/reg_exp.dart';
import 'package:anam/core/parameters/register_parameters.dart';
import 'package:anam/presentation/widgets/auth_widgets/custom_text_field.dart';
import 'package:anam/presentation/widgets/auth_widgets/first_and_last_name_component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/controllers/auth_cubit/auth_cubit.dart';
import '../../../domain/controllers/auth_cubit/auth_state.dart';
import '../../../domain/controllers/main_layout_cubit/main_layout_cubit.dart';
import '../../../domain/controllers/profile_cubit/profile_cubit.dart';
import '../../../domain/controllers/profile_cubit/profile_state.dart';
import '../../../facebook_login_test.dart';
import '../../../translations/locale_keys.g.dart';
import '../auth_widgets/custom_drop_down_button.dart';
import '../auth_widgets/register_type_radio_group.dart';
import '../shared_widget/custom_divider.dart';
import '../shared_widget/custom_elevated_button.dart';
import '../shared_widget/custom_sized_box.dart';
import 'base_bottom_sheet_widget.dart';
import '../shared_widget/bottom_sheet_title_text_widget.dart';

class ContinueRegisteringBottomSheet extends StatefulWidget {
  const ContinueRegisteringBottomSheet({super.key});

  @override
  State<ContinueRegisteringBottomSheet> createState() => _ContinueRegisteringBottomSheetState();
}

class _ContinueRegisteringBottomSheetState extends State<ContinueRegisteringBottomSheet> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseBottomSheetWidget(
      child: SingleChildScrollView(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if(state is RegisterLoadingState){
              showProgressIndicator(context);
            }
            if(state is RegisterSuccessState){
              MainLayoutCubit.get(context).handleAuthMethods();
              Navigator.pushNamedAndRemoveUntil(context, ScreenName.splashScreen, (route) => false);
            }
            if(state is RegisterErrorState){
              Navigator.pop(context);
              showToast(errorType: 1, message: state.error);
            }
          },
          builder: (context, state) {
            var cubit = AuthCubit.get(context);
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ScreenTitleTextWidget(
                    title: LocaleKeys.subscribe,
                  ),
                  const CustomSizedBox(
                    height: 1,
                  ),
                  const CustomDivider(),
                  const CustomSizedBox(
                    height: 29,
                  ),
                   FirstLastNameComponent(firstNameController: cubit.firstNameController, secondNameController: cubit.secondNameController,),
                  const CustomSizedBox(
                    height: 14,
                  ),
                  CustomTextField(
                    hintText: LocaleKeys.email.tr(),
                    controller: cubit.emailController,
                    validator: (value){
                      if(value!.isEmpty){
                        return LocaleKeys.pleaseEnterEmail.tr();
                      }else if (!RegularExp.emailRegex.hasMatch(value)){
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
                    controller: cubit.passwordController,
                    validator: (value){
                      if(value!.isEmpty){
                        return LocaleKeys.enterPassword.tr();
                      }else if (value.length<9){
                        return LocaleKeys.validatePassword.tr();
                      }
                      return null;
                    },
                    // height: 45,
                  ),
                  const CustomSizedBox(
                    height: 14,
                  ),
                  CustomTextField(
                    hintText: LocaleKeys.confirmPassword.tr(),
                    controller: cubit.confirmPasswordController,

                    validator: (value){
                      if(value!.isEmpty){
                        return LocaleKeys.enterConfirmPassword.tr();
                      }else if (cubit.confirmPasswordController.text!=cubit.passwordController.text){
                        return LocaleKeys.validateConfirmPassword.tr();
                      }
                      return null;
                    },
                    // height: 45,
                  ),
                  // CustomDropDownButton(
                  //   height: 45,
                  //   onChanged: (value) {},
                  //   hint: LocaleKeys.city.tr(),
                  //   items: cubit.countriesList
                  //       .map((e) => DropdownMenuItem(
                  //             value: e,
                  //             child: Text(e.name??""),
                  //           ))
                  //       .toList(),
                  //   value: cubit.choosenCity,
                  // ),
                  const RegisterTypeRadioGroup(),
                  CustomElevatedButton(
                    title: LocaleKeys.register.tr(),
                    onPressed: () {
                      if(cubit.firstNameController.text.isNotEmpty&&cubit.secondNameController.text.isNotEmpty){
                        if(formKey.currentState!.validate()){
                          cubit.register(registerParameters: RegisterParameters(
                              firstName: cubit.firstNameController.text,
                              lastName: cubit.secondNameController.text,
                              confirmPassword: cubit.passwordController.text,
                              password: cubit.passwordController.text,
                              countryId: cubit.chosenCity!.id.toString(),
                              email: cubit.emailController.text,
                              phone: cubit.phoneController.text,
                              type: cubit.selectedRole
                          ));
                        }
                      }else{
                        if(cubit.firstNameController.text.isEmpty){
                          showToast(errorType: 1, message: LocaleKeys.pleaseEnterFirstName.tr());
                        }
                        if(cubit.secondNameController.text.isEmpty){
                          showToast(errorType: 1, message: LocaleKeys.pleaseEnterSecondName.tr());
                        }
                      }
                    },
                    buttonSize: Size(double.infinity, 40.h),
                  ),
                  const CustomSizedBox(
                    height: 14,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
