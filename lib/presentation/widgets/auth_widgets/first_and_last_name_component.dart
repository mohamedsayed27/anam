import 'package:anam/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../domain/controllers/auth_cubit/auth_cubit.dart';
import '../../../domain/controllers/auth_cubit/auth_state.dart';

class FirstLastNameComponent extends StatefulWidget {
  final TextEditingController? firstNameController;
  final TextEditingController? secondNameController;
  const FirstLastNameComponent({super.key, this.firstNameController, this.secondNameController});

  @override
  State<FirstLastNameComponent> createState() => _FirstLastNameComponentState();
}

class _FirstLastNameComponentState extends State<FirstLastNameComponent> {
  InputBorder sNameTextFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(9.r),
      topRight: Radius.circular(9.r),
    ),
    borderSide: BorderSide(
      color: AppColors.authBorderColor,
      width: 0.74.w,
    ),
  );
  InputBorder fNameTextFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(9.r),
      bottomRight: Radius.circular(9.r),
    ),
    borderSide: BorderSide(
      color: AppColors.authBorderColor,
      width: 0.74.w,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50.h,
          padding: EdgeInsets.only(
            top: 5.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9.r),
              topRight: Radius.circular(9.r),
            ),
            border: Border.all(
              color: AppColors.authBorderColor,
              width: 0.74.w,
            ),
          ),
          child: TextFormField(
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 12.sp,
            ),
            controller: widget.firstNameController,
            expands: true,
            maxLines: null,
            minLines: null,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              labelText: LocaleKeys.firstName.tr(),
              floatingLabelStyle:
              Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 15.sp,
              ),
              labelStyle:
              Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 11.85.sp,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
              ),
            ),
          ),
        ),
        Container(
          height: 50.h,
          padding: EdgeInsets.only(
            top: 5.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(9.r),
              bottomLeft: Radius.circular(9.r),
            ),
            border: Border.all(
              color: AppColors.authBorderColor,
              width: 0.74.w,
            ),
          ),
          child: TextFormField(
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 12.sp,
              ),
              expands: true,
              controller: widget.secondNameController,
              maxLines: null,
              minLines: null,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                labelText: LocaleKeys.lastNam.tr(),
                floatingLabelStyle:
                Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 15.sp,
                ),
                labelStyle:
                Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 11.85.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                ),
              )),
        ),
      ],
    );
  }
}
