import 'package:anam/presentation/screens/main_layout_screens/conversations_screens/chat_screen.dart';

import '../../../../core/app_router/screens_name.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/constants/extensions.dart';
import '../../../../domain/controllers/chat_cubit/chat_cubit.dart';
import '../../../../presentation/widgets/shared_widget/custom_divider.dart';
import '../../../../presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:anam/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/conversations_widgets/conversation_Item.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  @override
  void initState() {
    ChatCubit.get(context).allChatsItemsPageNumber = 1;
    ChatCubit.get(context).getChatList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSizedBox(
              height: 20,
            ),
            Text(
              LocaleKeys.conversation.tr(),
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 20.sp,
                  ),
            ).symmetricPadding(horizontal: 16),
            const CustomSizedBox(
              height: 15,
            ),
            const CustomDivider().symmetricPadding(horizontal: 16),
            const CustomSizedBox(
              height: 20,
            ),
            BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                ChatCubit cubit = ChatCubit.get(context);
                return Expanded(
                  child: cubit.getChatItemsLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : ListView.separated(
                          separatorBuilder: (_, index) => CustomDivider(
                            isOnlyPadding: true,
                            dividerColor:
                                AppColors.dividerColor.withOpacity(.4),
                          ),
                          itemCount: cubit.chatsItemsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  ScreenName.chatScreen,
                                  arguments: ChatScreenArgs(
                                    receiverId:
                                        cubit.chatsItemsList[index].id ?? 0,
                                    name:
                                        cubit.chatsItemsList[index].name ?? "", image: cubit.chatsItemsList[index].image ?? "",
                                  ),
                                );
                              },
                              child: ConversationItem(
                                chatItemModel: cubit.chatsItemsList[index],
                              ),
                            );
                          },
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
