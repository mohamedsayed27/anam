import 'package:anam/core/app_theme/app_colors.dart';
import 'package:anam/core/app_theme/custom_themes.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_outlined_button.dart';
import 'package:anam/presentation/widgets/vendor_details_widgets/ratings_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/controllers/products_cubit/products_cubit.dart';
import '../../../domain/controllers/products_cubit/products_state.dart';
import '../shared_widget/custom_sized_box.dart';

class RatingComponentBuilder extends StatelessWidget {
  final String componentTitle;
  final String buttonTitle;
  final void Function()? onAddPressed;

  const RatingComponentBuilder({
    super.key,
    required this.componentTitle,
    this.onAddPressed,
    required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              componentTitle.tr(),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 20.sp,
                  ),
            ),
            CustomOutlinedButton(
              height: 40.h,
              onPressed: onAddPressed,
              radius: 8.r,
              borderColor: AppColors.greyColor9D,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: AppColors.greyColor71,
                    size: 18.r,
                  ),
                  const CustomSizedBox(
                    width: 8,
                  ),
                  Text(
                    buttonTitle.tr(),
                    style: CustomThemes.grey7DColorTextTheme(context).copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).symmetricPadding(horizontal: 16),
        const CustomSizedBox(
          height: 16,
        ),
        BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = ProductsCubit.get(context);
            return SizedBox(
              height: 190.h,
              child:cubit.getProductReviewLoading==false? ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                separatorBuilder: (_, index) => const CustomSizedBox(
                  width: 10,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: cubit.reviewsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return RatingContainerWidget(
                    rating: cubit.reviewsList[index].rate!.toDouble(),
                    comment: cubit.reviewsList[index].review!,
                    image: cubit.reviewsList[index].user!.image!,
                    name: cubit.reviewsList[index].user!.name!,
                    date: cubit.reviewsList[index].createdAt!,
                  );
                },
              ):const Center(child: CircularProgressIndicator.adaptive(),),
            );
          },
        )
      ],
    );
  }
}
