import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../data/models/products_model/product_model.dart';
import '../shared_widget/custom_circle_button.dart';

class ProductDetailsImagesWidget extends StatefulWidget {
  final List<Images> imagesList;

  const ProductDetailsImagesWidget({super.key, required this.imagesList});

  @override
  State<ProductDetailsImagesWidget> createState() =>
      _ProductDetailsImagesWidgetState();
}

class _ProductDetailsImagesWidgetState
    extends State<ProductDetailsImagesWidget> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 254.h,
          width: double.infinity,
          child: PageView.builder(
            controller: controller,
            itemCount: widget.imagesList.length,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                widget.imagesList[index].image!,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        PositionedDirectional(
          end: 28.w,
          top: 20.h,
          child: Row(
            children: [
              CustomCircleButton(
                iconPath: Icons.ios_share,
                onPressed: () {},
                backgroundColor: AppColors.whiteColor,
                iconSize: 14.r,
                elevation: 0,
                width: 25.w,
                height: 25.h,
              ),
              const CustomSizedBox(
                width: 10,
              ),
              CustomCircleButton(
                iconPath: Icons.favorite,
                onPressed: () {},
                iconColor: AppColors.favoriteRedColor,
                iconSize: 14.r,
                width: 25.w,
                elevation: 0,
                height: 25.h,
              ),
            ],
          ),
        ),
        Positioned.fill(
            bottom: 14.h,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SmoothPageIndicator(
                controller: controller,
                count: widget.imagesList.length,
                effect: SlideEffect(
                  spacing: 6.9.w,
                  radius: 4.0,
                  dotWidth: 6.w,
                  dotHeight: 6.h,
                  paintStyle: PaintingStyle.fill,
                  dotColor: Colors.white.withOpacity(.7),
                  activeDotColor: Colors.white,
                ),
              ),
            ),),
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
