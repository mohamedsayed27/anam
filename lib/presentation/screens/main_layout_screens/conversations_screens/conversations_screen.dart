import 'package:anam/core/app_router/screens_name.dart';
import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_divider.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:anam/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/conversations_widgets/conversation_Item.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});

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

            const CustomSizedBox(height: 15,),
            const CustomDivider().symmetricPadding(horizontal: 16),
            const CustomSizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_,index) => CustomDivider(
                  isOnlyPadding: true,
                  dividerColor: AppColors.dividerColor.withOpacity(.4),
                ),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, ScreenName.chatScreen);
                    },
                    child: const ConversationItem(),
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
