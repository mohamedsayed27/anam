import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/constants/dummy_data.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/products_model/product_model.dart';
import 'product_image_widget.dart';

class ProductItemComponent extends StatelessWidget {
  final bool isFavorite;
  final void Function()? onPressed;
  final ProductDataModel productDataModel;
  const ProductItemComponent({super.key, required this.isFavorite, this.onPressed, required this.productDataModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.transparent,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemImageWidget(
            isFavorite: isFavorite,
            productDataModel: productDataModel,
          ),
          const CustomSizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                productDataModel.location??"",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 16.sp,
                ),
              ),
              Row(
                children: [
                  Text(
                    productDataModel.rate.toString(),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  Icon(
                    Icons.star,
                    color: AppColors.orangeColor,
                    size: 18.r,
                  ),
                ],
              )
            ],
          ),
          const CustomSizedBox(
            height: 4,
          ),
          Text(
            productDataModel.description??"",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontSize: 16.sp,
            ),
          ),
          const CustomSizedBox(
            height: 4,
          ),
          Text(
            "${productDataModel.regularPrice} ريال",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontSize: 16.sp,

            ),
          ),
        ],
      ),
    );
  }
}
