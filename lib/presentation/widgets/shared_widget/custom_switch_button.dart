import 'package:anam/data/models/products_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../domain/controllers/products_cubit/products_cubit.dart';
import '../../../domain/controllers/products_cubit/products_state.dart';

class CustomSwitchButton extends StatelessWidget {
  final double itemWidth;
  final double itemHeight;
  final double circleHeightAndWidth;
  final ProductDataModel productDataModel;

  const CustomSwitchButton({
    Key? key,
    this.itemWidth = 42,
    required this.productDataModel,
    this.itemHeight = 24,
    this.circleHeightAndWidth = 22,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        ProductsCubit cubit = ProductsCubit.get(context);
        return InkWell(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          onTap: () async {
            if(!cubit.vendorProducts[productDataModel.id!.toString()]!){
              cubit.changeProductStatus(productId: productDataModel.id!, status: "on");
            }
            else if(cubit.vendorProducts[productDataModel.id!.toString()]!){
              cubit.changeProductStatus(productId: productDataModel.id!, status: "off");
            }
            },
          child: SizedBox(
            width: itemWidth.w,
            height: itemHeight.h,
            child: Stack(
              children: [
                Container(
                  width: itemWidth.w,
                  height: itemHeight.h,
                  decoration: BoxDecoration(
                    color: !cubit.vendorProducts[productDataModel.id!.toString()]
                        ? AppColors.grey7DColor
                        : AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(
                      15.r,
                    ),
                  ),
                ),
                AnimatedContainer(
                  alignment:
                      !cubit.vendorProducts[productDataModel.id!.toString()] ? Alignment.centerLeft : Alignment.centerRight,
                  duration: const Duration(milliseconds: 150),
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Card(
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    shape: const CircleBorder(),
                    child: Container(
                      width: circleHeightAndWidth.w,
                      height: circleHeightAndWidth.h,
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: cubit.vendorProducts[productDataModel.id!.toString()]
                          ? Icon(
                              Icons.check,
                              size: 12.r,
                              color: AppColors.primaryColor,
                            )
                          : null,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
