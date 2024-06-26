import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../shared_widget/custom_circle_button.dart';

class ServicesDetailsIntroImageWidget extends StatelessWidget {
  final String image;
  const ServicesDetailsIntroImageWidget({super.key, required this.image,});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 301.h,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl:image,
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[300]!,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
          // Image.network(
          //   image,
          //   fit: BoxFit.cover,
          // ),
        ),
        PositionedDirectional(
          start: 30.w,
          top: 20.h,
          child: CustomCircleButton(
            isSvgChild: true,
            onPressed: () {
              Navigator.pop(context);
            },
            width: 25.w,
            elevation: 0,
            height: 25.h,
          ),
        ),
      ],
    );
  }
}


