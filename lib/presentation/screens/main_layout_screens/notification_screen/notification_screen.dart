import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/assets_path/svg_path.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../core/app_theme/custom_themes.dart';
import '../../../../domain/controllers/profile_cubit/profile_cubit.dart';
import '../../../../domain/controllers/profile_cubit/profile_state.dart';
import '../../../widgets/shared_widget/custom_divider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    ProfileCubit cubit = ProfileCubit.get(context);
    if (cubit.notifications.isEmpty) cubit.getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "الاشعارات",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: 20.sp),
            ).symmetricPadding(horizontal: 16),
            const CustomSizedBox(
              height: 10,
            ),
            const CustomDivider().symmetricPadding(horizontal: 16),
            const CustomSizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  ProfileCubit cubit = ProfileCubit.get(context);
                  return state is GetNotificationsLoadingState
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemBuilder: (_, index) {
                            return NotificationItem(
                              title: cubit.notifications[index].message ?? "",
                              date: Jiffy.parse(
                                      cubit.notifications[index].createdAt ??
                                          "")
                                  .Hm
                                  .toString(),
                              isBorder: index != 2,
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const CustomSizedBox();
                          },
                          itemCount: cubit.notifications.length,
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String date;
  final bool isBorder;

  const NotificationItem({
    super.key,
    required this.title,
    required this.date,
    required this.isBorder,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: isBorder
          ? UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.greyColor9D,
                width: 1.w,
              ),
            )
          : null,
      trailing: Text(
        date,
        style: CustomThemes.grey7DColorTextTheme(context).copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(
        SvgPath.infoCircle,
        width: 15.w,
        height: 15.h,
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(fontSize: 14.sp),
      ),
    );
  }
}
