import 'dart:convert';

import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/app_theme/custom_themes.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/pusher/pusher_methods.dart';
import '../../../../data/models/chat_models/conversation_model.dart';
import '../../../../domain/controllers/chat_cubit/chat_cubit.dart';
import '../../../widgets/conversations_widgets/chat_text_field.dart';
import '../../../widgets/conversations_widgets/message_item_widget.dart';
import '../../../widgets/shared_widget/custom_divider.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';
import '../../../widgets/shared_widget/custom_app_bar.dart';

class ChatScreenArgs extends Equatable {
  final int receiverId;
  final String name;

  const ChatScreenArgs({required this.receiverId, required this.name});

  @override
  // TODO: implement props
  List<Object?> get props => [
        receiverId,
        name,
      ];
}

class ChatScreen extends StatefulWidget {
  final ChatScreenArgs chatScreenArgs;
  const ChatScreen({super.key, required this.chatScreenArgs,});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    cubit = ChatCubit.get(context);
    cubit.getChats(receiverId: widget.chatScreenArgs.receiverId);
    subscribeChannel();
    super.initState();
  }

  PusherChannelsFlutter pusher = PusherChannelsFlutter();

  @override
  void dispose() {
    pusher.disconnect();
    super.dispose();
  }

  void unsubscribe() async {
    final list = <int>[
      widget.chatScreenArgs.receiverId,
      int.parse(userId.toString()),
    ]..sort();
    await pusher.unsubscribe(channelName: "private.chat.${list.join(".")}");
  }

  void subscribeChannel() async {
    final list = <int>[widget.chatScreenArgs.receiverId, int.parse(userId.toString())]..sort();
    try {
      await pusher.init(
        apiKey: "d7e9da7b3bc9de6317b3",
        cluster: "eu",
        onEvent: (PusherEvent event) {
          var data = jsonDecode(event.data);
          cubit.addMessage(
            conversation: Conversation(
              message: data["message"].toString(),
              senderId: int.parse(data["sender_id"].toString()),
              receiverId: int.parse(data["reciever_id"].toString()),
            ),
          );
          controller.clear();
        },
        onSubscriptionError: (String message, dynamic e) {},
        onSubscriptionSucceeded: (String channelName, dynamic data) {},
      );
      await pusher.subscribe(channelName: "private.chat.${list.join(".")}");
      await pusher.connect();
    } catch (e) {}
  }

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: appBarSize,
        child: CustomAppBar(
          title: widget.chatScreenArgs.name,
          titleStyle: CustomThemes.darkGreyColorTextTheme(context)
              .copyWith(fontWeight: FontWeight.w600, fontSize: 16.sp),
          backgroundColor: AppColors.whiteColor,
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {},
  builder: (context, state) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomDivider(),
            const CustomSizedBox(
              height: 15,
            ),
            Expanded(
              child: cubit.getChat
                  ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
                  : ListView.separated(
                reverse: true,
                separatorBuilder: (BuildContext context, int index) {
                  return const CustomSizedBox(
                    height: 16,
                  );
                },
                itemCount: cubit.conversationsList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return MessageItemWidget(
                    isMyMessage:
                    cubit.conversationsList![index].senderId ==
                        int.parse(
                          userId.toString(),
                        )
                        ? true
                        : false,
                    text: cubit.conversationsList![index].message,
                  );
                },
              ),
            ),
            ChatTextField(
              controller: controller,
              onTap: () {
                // testPayCallTabs();
                cubit.sendMessage(
                    receiverId: widget.chatScreenArgs.receiverId,
                    message: controller.text);
              },
            ),
          ],
        );
  },
).symmetricPadding(
          horizontal: 24,
          vertical: 13,
        ),
      ),
    );
  }
}
