import 'dart:convert';

import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/assets_path/fonts_path.dart';
import 'package:anam/core/assets_path/svg_path.dart';
import 'package:anam/core/cache_helper/shared_pref_methods.dart';
import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../core/pusher/pusher_methods.dart';
import '../../../domain/controllers/chat_cubit/chat_cubit.dart';
import '../conversations_widgets/chat_text_field.dart';
import '../conversations_widgets/message_item_widget.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';

class ChatBottomSheet extends StatefulWidget {
  final int receiverId;

  const ChatBottomSheet({super.key, required this.receiverId});

  @override
  State<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<ChatBottomSheet> {
  late ChatCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    cubit = ChatCubit.get(context);
    cubit.getChats(receiverId: widget.receiverId);
    _pusherMethods = PusherMethods(pusher: pusher);
    subscribeChannel();
    super.initState();
  }

  late final PusherMethods _pusherMethods;
  PusherChannelsFlutter pusher = PusherChannelsFlutter();

  @override
  void dispose() {
    super.dispose();
  }

  void unsubscribe() async {
    final list = <int>[
      widget.receiverId,
      int.parse(userId.toString()),
    ]..sort();
    await pusher.unsubscribe(channelName: "private.chat.${list.join(".")}");
  }

  void subscribeChannel() {
    _pusherMethods.channelSubscription(
      receiverId: widget.receiverId,
      senderId: int.parse(userId.toString()),
      onEvent: (PusherEvent event) {
        print("onEvent ====> : ${event.data}");
      },
      onSubscriptionError: (String message, dynamic e) {
        print("onSubscriptionError: $message Exception: $e");
      },
      onSubscriptionSucceeded: (String channelName, dynamic data) {
        print("onSubscriptionSucceeded: $channelName data: $data");
      },
    );
  }

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22.r),
          topRight: Radius.circular(22.r),
        ),
      ),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 45.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 36.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22.r),
                    topRight: Radius.circular(22.r),
                  ),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        SvgPath.cancel,
                        width: 13.w,
                        height: 13.h,
                        colorFilter: const ColorFilter.mode(
                          AppColors.whiteColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const CustomSizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        "احمد خالد",
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: AppColors.whiteColor,
                          fontFamily: FontsPath.boutrosAsma,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const CustomSizedBox(
                height: 15,
              ),
              SizedBox(
                height: 300.h,
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return MessageItemWidget(
                      isMyMessage: index % 2 == 0 ? true : false,
                    ).onlyDirectionalPadding(bottom: 15);
                  },
                ),
              ).symmetricPadding(horizontal: 27),
              const CustomSizedBox(
                height: 10,
              ),
              ChatTextField(
                controller: controller,
                onTap: () {
                  // testPayCallTabs();
                  cubit.sendMessage(
                      receiverId: widget.receiverId, message: controller.text);
                },
              ).symmetricPadding(horizontal: 27),
              const CustomSizedBox(
                height: 25,
              ),
            ],
          );
        },
      ),
    );
  }
}
