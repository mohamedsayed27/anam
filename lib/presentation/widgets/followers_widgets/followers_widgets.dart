import 'package:anam/core/assets_path/images_path.dart';
import 'package:anam/data/models/user_model/user_data_model.dart';
import 'package:anam/domain/controllers/profile_cubit/profile_cubit.dart';
import 'package:anam/domain/controllers/profile_cubit/profile_cubit.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/custom_themes.dart';
import '../../../domain/controllers/profile_cubit/profile_state.dart';
import '../shared_widget/custom_sized_box.dart';

class FollowersWidgets extends StatelessWidget {
  final bool isAccepted;
  final UserDataModel userDataModel;

  const FollowersWidgets(
      {super.key, required this.isAccepted, required this.userDataModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40.h,
          width: 40.w,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Image.asset(
            ImagesPath.personDummyImage,
            fit: BoxFit.cover,
          ),
        ),
        const CustomSizedBox(
          width: 30,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${userDataModel.name}",
                style: CustomThemes.greyColor34TextTheme(context).copyWith(
                  fontSize: 14.sp,
                  height: 1,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${userDataModel.address}",
                style: CustomThemes.grey7DColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  height: 1,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        isAccepted
            ? Text(
          userDataModel.createdAt,
          style: CustomThemes.grey7DColorTextTheme(context).copyWith(
            fontSize: 14.sp,
            height: 1,
            fontWeight: FontWeight.w400,
          ),
        )
            : BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = ProfileCubit.get(context);
            return CustomElevatedButton(
              title: "الغاء المتابعة",
              onPressed: () {
              },
              buttonSize: Size(
                132.w,
                36.h,
              ),
            );
          },
        ),
      ],
    );
  }
}
