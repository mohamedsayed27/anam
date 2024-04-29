import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/enums/user_type_enum.dart';
import 'package:anam/data/models/vet_models/vet_model.dart';
import 'package:anam/domain/controllers/profile_cubit/profile_cubit.dart';
import 'package:anam/presentation/screens/main_layout_screens/services_screens/add_vet_store_screen.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_elevated_button.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/cache_helper/cache_keys.dart';
import '../../../core/cache_helper/shared_pref_methods.dart';
import '../../../core/constants/constants.dart';
import '../../../domain/controllers/services_cubit/services_cubit.dart';
import '../../../domain/controllers/services_cubit/services_state.dart';
import '../../../translations/locale_keys.g.dart';

class VetServicesWidget extends StatelessWidget {
  final VetModel vetModel;

  const VetServicesWidget({super.key, required this.vetModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 230.h,
              width: double.infinity,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: CachedNetworkImage(
                imageUrl: vetModel.image!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: AppColors.shimmerFirstColor,
                  highlightColor: AppColors.shimmerSecondColor,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            PositionedDirectional(
              start: 15.w,
              bottom: 18.h,
              child: InkWell(
                onTap: () {
                  ProfileCubit.get(context)
                      .showVendorProfile(id: vetModel.vendor!.id!)
                      .then((value) {
                    Navigator.pushNamed(context, ScreenName.vendorDetailsScreen,
                        arguments:
                            ProfileCubit.get(context).vendorProfileModel);
                  });
                },
                child: Container(
                  height: 48.h,
                  width: 48.w,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: vetModel.vendor!.image!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: AppColors.shimmerFirstColor,
                      highlightColor: AppColors.shimmerSecondColor,
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ],
        ),
        const CustomSizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              vetModel.vendor!.name ?? "dummy",
              style: CustomThemes.greyColor34TextTheme(context).copyWith(
                fontSize: 14.sp,
                height: 1,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                if (vetModel.vendor!.id.toString() == userId)
                  BlocConsumer<ServicesCubit, ServicesState>(
                    listener: (context, state) {
                      var cubit = ServicesCubit.get(context);
                      if (state is ShowVetMultiLangErrorState) {
                        Navigator.pop(context);
                      }
                      if (state is ShowVetMultiLangSuccessState) {
                        Navigator.pop(context);
                        // Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddVetScreen(
                              veterinarianMultiLangModel:
                                  cubit.veterinarianMultiLangModel,
                            ),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      var cubit = ServicesCubit.get(context);
                      return CustomElevatedButton(
                        title: LocaleKeys.edit.tr(),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          cubit.getMultiLangVeterinarian(id: vetModel.id!);
                          showProgressIndicator(context);
                        },
                        buttonSize: Size(120.w, 40.h),
                      );
                    },
                  ),
                const CustomSizedBox(
                  width: 8,
                ),
                if (CacheHelper.getData(key: CacheKeys.userType) ==
                    UserTypeEnum.user.name)
                  BlocConsumer<ServicesCubit, ServicesState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      var cubit = ServicesCubit.get(context);
                      return CustomElevatedButton(
                        title: cubit.followedVendors[
                                vetModel.vendor!.id!.toString()]
                            ? LocaleKeys.unFollow.tr()
                            : LocaleKeys.follow.tr(),
                        onPressed: () {
                          print(cubit.followedVendors[
                          vetModel.vendor!.id!.toString()]);
                          if(!cubit.followedVendors[
                          vetModel.vendor!.id!.toString()]){
                            cubit.followVendor(vendorId: vetModel.vendor!.id!);
                          }else{
                            cubit.unfollowVendor(vendorId: vetModel.vendor!.id!);
                          }
                        },
                        padding: EdgeInsets.zero,
                        buttonSize: Size(120.w, 40.h),
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
