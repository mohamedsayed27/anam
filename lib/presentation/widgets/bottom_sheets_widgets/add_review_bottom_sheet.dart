import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/parameters/review_product_parameters.dart';
import 'package:anam/presentation/widgets/auth_widgets/custom_text_field.dart';
import 'package:anam/presentation/widgets/order_widgets/order_type_drop_down_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../domain/controllers/products_cubit/products_cubit.dart';
import '../../../domain/controllers/products_cubit/products_state.dart';
import '../../../translations/locale_keys.g.dart';
import '../shared_widget/custom_divider.dart';
import '../shared_widget/custom_elevated_button.dart';
import '../shared_widget/custom_sized_box.dart';
import 'base_bottom_sheet_widget.dart';
import '../shared_widget/bottom_sheet_title_text_widget.dart';

class AddProductReviewBottomSheet extends StatefulWidget {
  final String id;

  const AddProductReviewBottomSheet({super.key, required this.id});

  @override
  State<AddProductReviewBottomSheet> createState() =>
      _AddProductReviewBottomSheetState();
}

class _AddProductReviewBottomSheetState
    extends State<AddProductReviewBottomSheet> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheetWidget(
      child: SingleChildScrollView(
        child: BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {
            ProductsCubit cubit = ProductsCubit.get(context);
            if (state is UploadReviewProductLoadingState) {
              showProgressIndicator(context);
            }
            if (state is UploadReviewProductSuccessState) {
              Navigator.pop(context);
              Navigator.pop(context);
              cubit.addProductReviewEmail.clear();
              cubit.addProductReviewLocation.clear();
              cubit.addProductReviewAge.clear();
              cubit.addProductReviewName.clear();
              cubit.addProductReviewDescription.clear();
              cubit.addProductReviewRate = 0;
              showToast(
                  errorType: 0, message: state.baseResponseModel.message!);
            }
            if (state is UploadReviewProductErrorState) {
              Navigator.pop(context);
              showToast(errorType: 1, message: state.error);
            }
          },
          builder: (context, state) {
            ProductsCubit cubit = ProductsCubit.get(context);
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ScreenTitleTextWidget(
                    title: "التقييم",
                  ),
                  const CustomSizedBox(
                    height: 1,
                  ),
                  const CustomDivider(),
                  const CustomSizedBox(
                    height: 29,
                  ),
                  CustomTextField(
                    hintText: LocaleKeys.fullName.tr(),
                    controller: cubit.addProductReviewName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الرجاء إدخال البيانات في حقل النص.";
                      }
                      return null;
                    },
                  ),
                  const CustomSizedBox(
                    height: 14,
                  ),
                  Container(
                    height: 48.h,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.authBorderColor,
                        width: 0.74.w,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "التقييم",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        RatingBar.builder(
                          initialRating: cubit.addProductReviewRate.toDouble(),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 16,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0.w),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star_border_outlined,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: cubit.changeProductReviewRate,
                        ),
                      ],
                    ),
                  ),
                  const CustomSizedBox(
                    height: 14,
                  ),
                  CustomTextField(
                    hintText: "${LocaleKeys.email.tr()}*",
                    controller: cubit.addProductReviewEmail,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الرجاء إدخال البيانات في حقل النص.";
                      }
                      return null;
                    },
                  ),
                  const CustomSizedBox(
                    height: 14,
                  ),
                  CustomTextField(
                    hintText: "النص",
                    controller: cubit.addProductReviewDescription,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الرجاء إدخال البيانات في حقل النص.";
                      }
                      return null;
                    },
                  ),
                  const CustomSizedBox(
                    height: 14,
                  ),
                  CustomTextField(
                    hintText: "العنوان",
                    controller: cubit.addProductReviewLocation,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الرجاء إدخال البيانات في حقل النص.";
                      }
                      return null;
                    },
                  ),
                  const CustomSizedBox(
                    height: 14,
                  ),
                  CustomTextField(
                    hintText: "العمر",
                    controller: cubit.addProductReviewAge,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الرجاء إدخال البيانات في حقل النص.";
                      }
                      return null;
                    },
                  ),
                  const CustomSizedBox(
                    height: 14,
                  ),
                  CustomElevatedButton(
                    title: "اضافة التقييم",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.addProductReview(
                          reviewProductParameters: ReviewProductParameters(
                            email: cubit.addProductReviewEmail.text,
                            adress: cubit.addProductReviewLocation.text,
                            age: cubit.addProductReviewAge.text,
                            name: cubit.addProductReviewName.text,
                            review: cubit.addProductReviewDescription.text,
                            rating: cubit.addProductReviewRate,
                          ),
                          id: widget.id,
                        );
                      }
                    },
                    buttonSize: Size(double.infinity, 40.h),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
