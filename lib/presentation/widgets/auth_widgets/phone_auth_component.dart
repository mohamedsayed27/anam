import 'package:anam/core/constants/extensions.dart';
import 'package:anam/domain/controllers/auth_cubit/auth_cubit.dart';
import 'package:anam/domain/controllers/auth_cubit/auth_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../translations/locale_keys.g.dart';

class PhoneComponent extends StatefulWidget {
  final String? Function(String?)? validator;
  const PhoneComponent({super.key, this.validator});

  @override
  State<PhoneComponent> createState() => _PhoneComponentState();
}

class _PhoneComponentState extends State<PhoneComponent> {
  InputBorder dropDownBorder = OutlineInputBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(9.r),
      topRight: Radius.circular(9.r),
    ),
    borderSide: BorderSide(
      color: AppColors.authBorderColor,
      width: 0.74.w,
    ),
  );
  InputBorder textFieldBorder = OutlineInputBorder(
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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        print(cubit.countriesList);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: AppColors.whiteColor,
              child: Container(
                height: 55.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(9.r),
                    topRight: Radius.circular(9.r),
                  ),
                  border: Border.all(
                    color: AppColors.authBorderColor,
                    width: 0.74.w,
                  ),
                ),
                child: Stack(
                  children: [
                    Text(
                      "البلد / المنطقة",
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 10.sp),
                    ).onlyDirectionalPadding(top: 5, start: 12),
                    DropdownButtonFormField(
                      items: cubit.countriesList
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text("${e.code}   ${e.name}"),
                              ))
                          .toList(),
                      hint: Text(
                        "اختر البلد",
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontSize: 14.sp),
                      ).onlyDirectionalPadding(top: 5),
                      onChanged: cubit.changeCity,
                      // isExpanded: true,
                      padding: EdgeInsetsDirectional.only(top: 5.h, start: 8.w),
                      alignment: Alignment.topCenter,
                      icon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 24.r,
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontSize: 12.sp),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      value: cubit.chosenCity,
                    )
                  ],
                ),
              ),
            ),
            TextFormField(
              controller: cubit.phoneController,
              validator: widget.validator,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 11.85.sp,
                  ),
              decoration: InputDecoration(
                hintText: LocaleKeys.phone.tr(),
                hintStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 11.85.sp,
                    ),
                border: textFieldBorder,
                enabledBorder: textFieldBorder,
                disabledBorder: textFieldBorder,
                focusedBorder: textFieldBorder,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 3.h,
                  horizontal: 10.w,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
