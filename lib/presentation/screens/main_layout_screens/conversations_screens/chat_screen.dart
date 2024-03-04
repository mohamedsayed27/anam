import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/conversations_widgets/message_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../widgets/conversations_widgets/chat_text_field.dart';
import '../../../widgets/shared_widget/custom_divider.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';
import '../../../widgets/shared_widget/custom_app_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // void tryPusher()async{
  //   PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  //   try {
  //     await pusher.init(
  //       apiKey: "d7e9da7b3bc9de6317b3",
  //       cluster: "eu",
  //
  //       // onConnectionStateChange: onConnectionStateChange,
  //       // onError: (),
  //       onSubscriptionSucceeded: (error, data){
  //
  //         print(data);
  //       },
  //       onEvent: (event){
  //
  //         print(event);
  //       },
  //
  //       onSubscriptionError: (error, data){
  //         print(data);
  //       },
  //       onDecryptionFailure: (error, data){
  //
  //       },
  //       onMemberAdded: (error, pusherMember){
  //
  //       },
  //       onMemberRemoved: (error, pusherMember){
  //
  //       },
  //       // authEndpoint: "<Your Authendpoint>",
  //       // onAuthorizer: onAuthorizer
  //     );
  //     await pusher.subscribe(channelName: 'presence-chatbox');
  //     await pusher.connect();
  //   } catch (e) {
  //     print("ERROR: $e");
  //   }
  //   print(pusher.connectionState);
  //   print(pusher.channels);
  //   PusherChannel pp = PusherChannel(channelName: "channelName");
  //   print(pp.members);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: appBarSize,
        child: const CustomAppBar(
          title: "احمد خالد",
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomDivider(),
            const CustomSizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return MessageItemWidget(
                          isMyMessage: index % 2 == 0 ? true : false)
                      .onlyDirectionalPadding(bottom: 15);
                },
              ),
            ),
            const ChatTextField(),
          ],
        ).symmetricPadding(horizontal: 24, vertical: 13),
      ),
    );
  }
}
