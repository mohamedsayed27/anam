import 'package:anam/domain/controllers/auth_cubit/auth_cubit.dart';
import 'package:anam/domain/controllers/profile_cubit/profile_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/assets_path/images_path.dart';
import '../../../domain/controllers/profile_cubit/profile_state.dart';
import '../../../translations/locale_keys.g.dart';
import '../shared_widget/custom_sized_box.dart';

class IntroUserDetails extends StatefulWidget {
  const IntroUserDetails({super.key});

  @override
  State<IntroUserDetails> createState() => _IntroUserDetailsState();
}

class _IntroUserDetailsState extends State<IntroUserDetails> {
  @override
  void initState() {
    ProfileCubit.get(context).showProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        ProfileCubit cubit = ProfileCubit.get(context);
        return InkWell(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          onTap: cubit.profileModel != null
              ? () {
                  Navigator.pushNamed(context, ScreenName.personalDataScreen);
                }
              : null,
          child: Row(
            children: [
              Container(
                height: 55.h,
                width: 55.w,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: cubit.profileModel != null
                    ? CachedNetworkImage(
                        imageUrl: cubit.profileModel!.image!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[200]!,
                          highlightColor: Colors.grey[300]!,
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
                      )
                    : Shimmer.fromColors(
                        baseColor: Colors.grey[200]!,
                        highlightColor: Colors.grey[300]!,
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
              ),
              const CustomSizedBox(
                width: 28,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cubit.profileModel != null
                        ? Text(
                            "${cubit.profileModel!.firstName!} ${cubit.profileModel!.lastName}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 16.sp),
                          )
                        : Shimmer.fromColors(
                            baseColor: Colors.grey[200]!,
                            highlightColor: Colors.grey[300]!,
                            child: Container(
                              height: 16.h,
                              width: 64.w,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                    Text(
                      LocaleKeys.profileSettings.tr(),
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontSize: 12.sp,
                                decoration: TextDecoration.underline,
                              ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 12.r,
              )
            ],
          ),
        );
      },
    );
  }
}
