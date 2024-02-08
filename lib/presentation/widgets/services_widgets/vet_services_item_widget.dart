import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/enums/user_type_enum.dart';
import 'package:anam/data/models/vet_models/vet_model.dart';
import 'package:anam/domain/controllers/profile_cubit/profile_cubit.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_elevated_button.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/constants/constants.dart';

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
                imageUrl:vetModel.image!,
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
                  ProfileCubit.get(context).showVendorProfile(id: vetModel.vendor!.id!).then((value) {
                    Navigator.pushNamed(context, ScreenName.vendorDetailsScreen,arguments:ProfileCubit.get(context).vendorProfileModel );
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
                    imageUrl:vetModel.vendor!.image!,
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
              ),
            ),
          ],
        ),
        const CustomSizedBox(height: 16,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              vetModel.vendor!.name??"dummy",
              style: CustomThemes.greyColor34TextTheme(context).copyWith(
                fontSize: 14.sp,
                height: 1,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                if(vetModel.vendor!.id.toString() == userId)CustomElevatedButton(
                  title: "تعديل",
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  buttonSize: Size(120.w, 40.h),
                ),
                const CustomSizedBox(
                  width: 8,
                ),
                if(userType==UserTypeEnum.user.name)CustomElevatedButton(
                  title: vetModel.vendor!.isFollowed!!=true?"متابعة":"الغاء المتابعة",
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  buttonSize: Size(120.w, 40.h),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
