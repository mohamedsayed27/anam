import 'package:anam/core/assets_path/images_path.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/models/chat_models/chat_item_model.dart';
import '../shared_widget/title_and_body_text_widget.dart';

class ConversationItem extends StatelessWidget {
  final ChatItemModel chatItemModel;
  const ConversationItem({super.key, required this.chatItemModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 42.h,
        width: 42.w,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: CachedNetworkImage(
          imageUrl: chatItemModel.image!,
          fit: BoxFit.cover,
          placeholder: (context, url) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[300]!,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                  BorderRadius.circular(8.0),
                ),
              ),
            );
          },
          errorWidget: (context, url, error) =>
          const Icon(Icons.error),
        ),
      ),
      title: TileAndBodyTextWidget(
        titleText: chatItemModel.name??"",
        titleFontSize: 16,
        bodyFontSize: 14,
        bodyMaxLines: 1,
        titleMaxLines: 1,
        spaceBetweenTitleAndBody: 0,
      ),
      contentPadding: EdgeInsets.zero,
      trailing: Text(
        Jiffy.parse(chatItemModel.updatedAt!).jm,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
          fontSize: 12.sp,
        ),
      ),
    ).symmetricPadding(horizontal: 16);
  }
}
