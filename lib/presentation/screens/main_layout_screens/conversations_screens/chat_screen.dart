import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/conversations_widgets/message_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/conversations_widgets/chat_text_field.dart';
import '../../../widgets/shared_widget/custom_divider.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';
import '../../../widgets/shared_widget/custom_app_bar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
