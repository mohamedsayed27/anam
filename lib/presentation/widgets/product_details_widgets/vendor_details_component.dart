import 'package:anam/core/cache_helper/cache_keys.dart';
import 'package:anam/core/cache_helper/shared_pref_methods.dart';
import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/data/models/products_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/assets_path/images_path.dart';
import '../../../domain/controllers/products_cubit/products_cubit.dart';
import '../../../domain/controllers/products_cubit/products_state.dart';
import '../../../domain/controllers/services_cubit/services_cubit.dart';
import '../../../domain/controllers/services_cubit/services_state.dart';
import '../shared_widget/custom_sized_box.dart';
import '../shared_widget/custom_circle_button.dart';

class VendorDetailsComponent extends StatelessWidget {
  final ProductDataModel productDataModel;

  const VendorDetailsComponent({super.key, required this.productDataModel});

  @override
  Widget build(BuildContext context) {
    print(productDataModel.uploadedBy!.name);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productDataModel.name ?? "",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const CustomSizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.orangeColor,
                        size: 18.r,
                      ),
                      Text(
                        productDataModel.rate.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontSize: 16.sp,
                            ),
                      ),
                    ],
                  ),
                  const CustomSizedBox(
                    width: 11,
                  ),
                  CircleAvatar(
                    radius: 1.5.r,
                    backgroundColor: AppColors.blackColor,
                  ),
                  const CustomSizedBox(
                    width: 8.6,
                  ),
                  Text(
                    "آراء العملاء",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontSize: 16.sp,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.grey7DColor,
                        ),
                  ),
                ],
              ),
              const CustomSizedBox(
                height: 5,
              ),
              Text(
                productDataModel.location ?? "",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontSize: 16.sp,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.grey7DColor,
                    ),
              ),
            ],
          ),
        ),
        const CustomSizedBox(
          width: 15,
        ),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: 79.h,
              width: 61.h,
            ),
            Container(
              height: 61.h,
              width: 61.w,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.network(
                productDataModel.uploadedBy!.image!,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 48.h,
              child: BlocConsumer<ServicesCubit, ServicesState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  ServicesCubit cubit = ServicesCubit.get(context);
                  return CustomCircleButton(
                    width: 28.w,
                    height: 28.h,
                    iconPath: cubit.followedVendors.isNotEmpty
                        ? cubit.followedVendors[
                                productDataModel.uploadedBy!.id.toString()]
                            ? Icons.remove
                            : Icons.add
                        : Icons.add,
                    iconSize: 25.r,
                    iconColor: Colors.white,
                    onPressed: () {
                      if(CacheHelper.getData(key: CacheKeys.token)!=null){
                        print(cubit.followedVendors[
                        productDataModel.uploadedBy!.id!.toString()]);
                        if(!cubit.followedVendors[
                        productDataModel.uploadedBy!.id!.toString()]){
                          cubit.followVendor(vendorId: productDataModel.uploadedBy!.id!);
                        }else{
                          cubit.unfollowVendor(vendorId: productDataModel.uploadedBy!.id!);
                        }
                      }
                    },
                    backgroundColor: cubit.followedVendors.isNotEmpty
                        ?cubit.followedVendors[
                            productDataModel.uploadedBy!.id.toString()]
                        ? AppColors.primaryColor
                        : AppColors.orangeColor:AppColors.primaryColor,
                  );
                },
              ),
            ),
          ],
        )
      ],
    ).symmetricPadding(horizontal: 16);
  }
}
