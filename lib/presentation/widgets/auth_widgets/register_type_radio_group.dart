import 'package:anam/domain/controllers/auth_cubit/auth_cubit.dart';
import 'package:anam/domain/controllers/auth_cubit/auth_state.dart';
import 'package:anam/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterTypeRadioGroup extends StatefulWidget {
  const RegisterTypeRadioGroup({super.key});

  @override
  RegisterTypeRadioGroupState createState() => RegisterTypeRadioGroupState();
}

class RegisterTypeRadioGroupState extends State<RegisterTypeRadioGroup> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RadioListTile<String>(
              contentPadding: EdgeInsets.zero,
              title: Text(LocaleKeys.vendor.tr()),
              value: 'vendor',
              groupValue: cubit.selectedRole,
              onChanged: cubit.changeRegisterType,
            ),
            RadioListTile<String>(
              contentPadding: EdgeInsets.zero,
              title: Text(LocaleKeys.user.tr()),
              value: 'user',
              groupValue: cubit.selectedRole,
              onChanged: cubit.changeRegisterType,
            ),
          ],
        );
      },
    );
  }
}
