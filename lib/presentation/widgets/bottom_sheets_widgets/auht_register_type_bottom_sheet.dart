import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/auth_widgets/register_type_radio_group.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/controllers/auth_cubit/auth_cubit.dart';
import '../../../domain/controllers/auth_cubit/auth_state.dart';
import '../../../translations/locale_keys.g.dart';
import '../shared_widget/custom_elevated_button.dart';
import '../shared_widget/custom_sized_box.dart';

class AuthRegisterTypeBottomSheet extends StatelessWidget {
  final String socialType;
  const AuthRegisterTypeBottomSheet({super.key, required this.socialType});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomSizedBox(
          height: 16,
        ),
        const RegisterTypeRadioGroup(),
        const CustomSizedBox(
          height: 16,
        ),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            AuthCubit cubit = AuthCubit.get(context);
            return CustomElevatedButton(
              title: LocaleKeys.continueText.tr(),
              onPressed: cubit.selectedRole!=null? (){
                Navigator.pop(context);
                socialType=="g"?cubit.googleSignIn():cubit.twitterSignIn();
              }:null,
              buttonSize: Size(double.infinity, 40.h),
            );
          },
        ),
        const CustomSizedBox(
          height: 32,
        ),
      ],
    ).symmetricPadding(horizontal: 16);
  }
}
