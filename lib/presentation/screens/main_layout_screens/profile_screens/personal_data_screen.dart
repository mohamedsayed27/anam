import 'package:anam/core/constants/extensions.dart';
import 'package:anam/core/parameters/update_profile_parameters.dart';
import 'package:anam/domain/controllers/profile_cubit/profile_cubit.dart';
import 'package:anam/domain/controllers/profile_cubit/profile_state.dart';
import 'package:anam/presentation/widgets/auth_widgets/first_and_last_name_component.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_divider.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/assets_path/images_path.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/reg_exp.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../widgets/auth_widgets/custom_text_field.dart';
import '../../../widgets/profile_widgets/personal_data_item_widget.dart';
import '../../../widgets/shared_widget/custom_elevated_button.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  @override
  void initState() {
    var cubit = ProfileCubit.get(context);
    cubit.firstNameController.text = cubit.profileModel!.firstName!;
    cubit.secondNameController.text = cubit.profileModel!.lastName!;
    cubit.emailController.text = cubit.profileModel!.email!;
    cubit.phoneController.text = cubit.profileModel!.phone ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if(state is UpdateProfileLoadingState){
              showProgressIndicator(context);
            }
            if(state is UpdateProfileSuccessState){
              Navigator.pop(context);
            }
            if(state is UpdateProfileErrorState){
              Navigator.pop(context);
              showToast(errorType: 1, message: state.error);
            }
          },
          builder: (context, state) {
            var cubit = ProfileCubit.get(context);
            return cubit.getProfileData
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : ListView(
                    padding:
                        EdgeInsets.symmetric(vertical: 23.h, horizontal: 28.w),
                    children: [
                      Text(
                        LocaleKeys.personalData.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 20.sp),
                      ),
                      const CustomSizedBox(height: 12),
                      const CustomDivider(),
                      const CustomSizedBox(
                        height: 24,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              height: 132.h,
                              width: 132.w,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: cubit.profileImage == null
                                  ? CachedNetworkImage(
                                      imageUrl: cubit.profileModel!.image!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey[200]!,
                                          highlightColor: Colors.grey[300]!,
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        );
                                      },
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : Image.file(
                                      cubit.profileImage!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            InkWell(
                              onTap: () {
                                cubit.getImagePick();
                              },
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              splashColor: Colors.transparent,
                              child: Container(
                                height: 132.h,
                                width: 132.w,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Colors.black38,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add_a_photo_outlined,
                                    size: 35.r, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const CustomSizedBox(
                        height: 24,
                      ),
                      FirstLastNameComponent(
                        firstNameController: cubit.firstNameController,
                        secondNameController: cubit.secondNameController,
                      ),
                      const CustomSizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        hintText: LocaleKeys.email.tr(),
                        controller: cubit.emailController,
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
                        height: 16,
                      ),
                      CustomTextField(
                        hintText: "رقم الهاتف",
                        controller: cubit.phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.pleaseEnterYourPhone.tr();
                          } else if (value.length < 9) {
                            return LocaleKeys.invalidPhoneNumber.tr();
                          }
                          return null;
                        },
                        // height: 45,
                      ),
                      const CustomSizedBox(height: 32),
                      CustomElevatedButton(
                        title: LocaleKeys.saveData.tr(),
                        onPressed: () {
                          cubit.updateProfile(
                              updateProfileParameters: UpdateProfileParameters(
                            phone: cubit.phoneController.text,
                            email: cubit.emailController.text,
                            method: "PUT",
                            image: cubit.profileImage,
                            firstName: cubit.firstNameController.text,
                            lastName: cubit.secondNameController.text,
                          ));
                        },
                        buttonSize: Size(double.infinity, 48.h),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
