import 'package:anam/core/app_router/screens_name.dart';
import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/core/enums/user_type_enum.dart';
import 'package:anam/presentation/widgets/bottom_sheets_widgets/add_order_bottom_sheet.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_divider.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_elevated_button.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:anam/presentation/widgets/shared_widget/order_component.dart';
import 'package:anam/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../domain/controllers/requests_cubit/requests_cubit.dart';
import '../../../../domain/controllers/requests_cubit/requests_state.dart';
import '../../../widgets/shared_widget/custom_outlined_button.dart';

class OrdersScreen extends StatefulWidget {
  final bool isPreviousOrders;

  const OrdersScreen({super.key, required this.isPreviousOrders});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  ScrollController previousScrollController  = ScrollController();
  ScrollController scrollController  = ScrollController();
  @override
  void initState() {
    super.initState();
    if(widget.isPreviousOrders==false){
      RequestsCubit.get(context).getAllRequests();
      RequestsCubit.get(context).allRequestsPageNumber = 1;
    }
    previousScrollController.addListener(() {
      if (previousScrollController.position.maxScrollExtent ==
          previousScrollController.offset) {
        RequestsCubit.get(context).getPreviousRequests();
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        RequestsCubit.get(context).getAllRequests();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomSizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.orders.tr(),
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontSize: 20.sp,
                        color: AppColors.blackColor,
                      ),
                ),
                if(userType==UserTypeEnum.user.name)CustomOutlinedButton(
                  height: 40.h,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => AddOrderBottomSheet(),
                    );
                  },
                  radius: 8.r,
                  borderColor: AppColors.greyColor9D,
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: AppColors.greyColor71,
                        size: 18.r,
                      ),
                      const CustomSizedBox(
                        width: 8,
                      ),
                      Text(
                        LocaleKeys.addOrder.tr(),
                        style:
                            CustomThemes.grey7DColorTextTheme(context).copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).symmetricPadding(horizontal: 16),
            const CustomSizedBox(
              height: 5,
            ),
            CustomDivider(
              dividerColor: AppColors.dividerColor.withOpacity(.6),
            ),
            Expanded(
              child: BlocConsumer<RequestsCubit, RequestsState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  RequestsCubit cubit = RequestsCubit.get(context);
                  return cubit.getAllRequestsLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : widget.isPreviousOrders
                          ? ListView.separated(
                    controller: previousScrollController,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                              separatorBuilder: (_, index) =>
                                  const CustomSizedBox(
                                height: 15,
                              ),
                              itemCount: cubit.previousRequestList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return OrderComponent(
                                  onPressed: () {
                                    // Navigator.pushNamed(
                                    //     context, ScreenName.orderDetailsScreen,);
                                  },
                                  titleFontSize: 16,
                                  cityFontSize: 14,
                                  descriptionFontSize: 14,
                                  isTherePhoto: true,
                                  priceFontSize: 14,
                                  locationIconSize: 12,
                                  orderTypeHPadding: 13,
                                  borderRadius: 16,
                                  orderTypeVPadding: 6,
                                  orderTypeFontSize: 14,
                                  itemHeight: 140,
                                  itemWidth: 320,
                                  requestModel:
                                      cubit.previousRequestList[index],
                                );
                              },
                            )
                          : ListView.separated(
                    controller: scrollController,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 12.h),
                              separatorBuilder: (_, index) =>
                                  const CustomSizedBox(
                                height: 15,
                              ),
                              itemCount: cubit.requestList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return OrderComponent(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, ScreenName.orderDetailsScreen,arguments: cubit.requestList[index]);
                                  },
                                  titleFontSize: 16,
                                  cityFontSize: 14,
                                  descriptionFontSize: 14,
                                  isTherePhoto: true,
                                  priceFontSize: 14,
                                  locationIconSize: 12,
                                  orderTypeHPadding: 13,
                                  borderRadius: 16,
                                  orderTypeVPadding: 6,
                                  orderTypeFontSize: 14,
                                  itemHeight: 140,
                                  itemWidth: 320,
                                  requestModel: cubit.requestList[index],
                                );
                              },
                            );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
