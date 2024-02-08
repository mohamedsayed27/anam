import 'package:anam/core/assets_path/images_path.dart';
import 'package:anam/data/models/stores_models/store_data_model.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_elevated_button.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/constants/constants.dart';
import '../../../core/enums/user_type_enum.dart';
import '../../../domain/controllers/profile_cubit/profile_cubit.dart';
import '../../../domain/controllers/services_cubit/services_cubit.dart';
import '../../../domain/controllers/services_cubit/services_state.dart';

class StoreServicesWidget extends StatelessWidget {
  final StoreDataModel storeDataModel;

  const StoreServicesWidget({
    super.key,
    required this.storeDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 325.h,
              width: double.infinity,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: CachedNetworkImage(
                imageUrl: storeDataModel.image!,
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
                      .showVendorProfile(id: storeDataModel.vendor!.id!)
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
                    imageUrl: storeDataModel.vendor!.image!,
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
              storeDataModel.vendor?.name ?? "",
              style: CustomThemes.greyColor34TextTheme(context).copyWith(
                fontSize: 14.sp,
                height: 1,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                if (storeDataModel.vendor!.id.toString() == userId)
                  CustomElevatedButton(
                    title: "تعديل",
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    buttonSize: Size(120.w, 40.h),
                  ),
                const CustomSizedBox(
                  width: 8,
                ),
                if (userType == UserTypeEnum.user.name)
                  BlocConsumer<ServicesCubit, ServicesState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      var cubit = ServicesCubit.get(context);
                      return CustomElevatedButton(
                        title: cubit.followedVendors[
                                storeDataModel.vendor!.id!.toString()]
                            ? "الغاء المتابعة"
                            : "متابعة",
                        onPressed: () {},
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
