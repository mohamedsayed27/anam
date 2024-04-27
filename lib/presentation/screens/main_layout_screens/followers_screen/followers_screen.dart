import 'package:anam/presentation/widgets/shared_widget/custom_app_bar.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_divider.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/controllers/profile_cubit/profile_cubit.dart';
import '../../../../domain/controllers/profile_cubit/profile_state.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../widgets/followers_widgets/followers_widgets.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  void initState() {
    ProfileCubit.get(context).getVendorFollowing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: CustomAppBar(title: LocaleKeys.followersList),
      ),
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            ProfileCubit cubit = ProfileCubit.get(context);
            return cubit.getVendorFollowingLoading
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Column(
                    children: [
                      const CustomDivider(
                        hPadding: 16,
                      ),
                      const CustomSizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          itemBuilder: (_, index) {
                            return FollowersWidgets(
                              isAccepted: true,
                              userDataModel: cubit.vendorFollowingList[index],
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const CustomSizedBox(
                              height: 20,
                            );
                          },
                          itemCount: cubit.vendorFollowingList.length,
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
