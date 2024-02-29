import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/assets_path/fonts_path.dart';
import 'package:anam/core/assets_path/svg_path.dart';
import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../domain/controllers/chat_cubit/chat_cubit.dart';
import '../conversations_widgets/chat_text_field.dart';
import '../conversations_widgets/message_item_widget.dart';

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
    print(userId);
    print(widget.receiverId);
    channelSubscription(receiverId: widget.receiverId, senderId: int.parse(userId.toString(),),);
    super.initState();
  }

  void channelSubscription({
    required int receiverId,
    required int senderId,
  })async{
    PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
    final  list = <int>[receiverId, senderId]..sort();
    try {
      await pusher.init(
        apiKey: "d7e9da7b3bc9de6317b3",
        cluster: "eu",
        // authParams: {
        //   "PUSHER_APP_ID":"1751503",
        // },
        // onConnectionStateChange: onConnectionStateChange,
        // onError: (),
        onSubscriptionSucceeded: (String channelName, dynamic data) {
          print("onSubscriptionSucceeded: $channelName data: $data");
        },
        onEvent: (PusherEvent event) {
          print("onEvent: $event");
        },
        onSubscriptionError: (String message, dynamic e) {
          print("onSubscriptionError: $message Exception: $e");
        },
        onDecryptionFailure: (error, data){

        },
        onMemberAdded: (String channelName, PusherMember member) {
          print("onMemberAdded: $channelName user: $member");
        },
        onConnectionStateChange: (dynamic currentState, dynamic previousState) {
          print("Connection: $currentState");
        },
        onMemberRemoved: (error, pusherMember){

        },

        // authEndpoint: "<Your Authendpoint>",
        // onAuthorizer: onAuthorizer
      );
      await pusher.subscribe(channelName: "private.chat.${list.first}.${list.last}");
      await pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
    print(pusher.connectionState);



    // print(pusher.channels);

    // print(pp.members);
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
               ChatTextField(controller: controller,onTap: (){
                 cubit.sendMessage(receiverId: widget.receiverId, message: controller.text);
               },).symmetricPadding(horizontal: 27),
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
