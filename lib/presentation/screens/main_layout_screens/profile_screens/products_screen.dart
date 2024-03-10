import 'package:anam/core/app_router/screens_name.dart';
import 'package:anam/core/assets_path/svg_path.dart';
import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/data/models/products_model/product_model.dart';
import 'package:anam/domain/controllers/products_cubit/products_cubit.dart';
import 'package:anam/domain/controllers/products_cubit/products_state.dart';
import 'package:anam/presentation/screens/main_layout_screens/profile_screens/add_product_screen.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../widgets/shared_widget/custom_outlined_button.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    ProductsCubit.get(context)
        .showVendorProfile(id: int.parse(userId!.toString()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const CustomSizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "قائمة المنتجات",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontSize: 20.sp,
                      ),
                ),
                BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    ProductsCubit cubit = ProductsCubit.get(context);
                    return CustomOutlinedButton(
                      height: 40.h,
                      radius: 8.r,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, ScreenName.addProductScreen);
                        cubit.productNameAr.clear();
                        cubit.productNameEn.clear();
                        cubit.locationAr.clear();
                        cubit.locationEn.clear();
                        cubit.productPrice.clear();
                        cubit.productDescriptionAr.clear();
                        cubit.productDescriptionEn.clear();
                        cubit.productProsAr.clear();
                        cubit.productProsEn.clear();
                        cubit.productConsAr.clear();
                        cubit.productConsEn.clear();
                        cubit.youtubeLink.clear();
                        cubit.mapLocation = null;
                        cubit.productImages.clear();
                      },
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
                            "اضافة منتج",
                            style: CustomThemes.grey7DColorTextTheme(context)
                                .copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ).symmetricPadding(horizontal: 16),
            const CustomSizedBox(
              height: 8,
            ),
            BlocConsumer<ProductsCubit, ProductsState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                ProductsCubit cubit = ProductsCubit.get(context);
                return cubit.getVendorProfileData
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          itemBuilder: (_, index) {
                            return ProductElement(
                              productDataModel: cubit
                                  .vendorProfileModel!.productsList![index],
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const CustomSizedBox(
                              height: 16,
                            );
                          },
                          itemCount:
                              cubit.vendorProfileModel!.productsList!.length,
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

class ProductElement extends StatelessWidget {
  final ProductDataModel productDataModel;

  const ProductElement({
    super.key,
    required this.productDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        ProductsCubit cubit = ProductsCubit.get(context);
        if (state is DeleteProductSuccessState) {
          Navigator.pop(context);
          showToast(errorType: 1, message: "Deleted Successfully");
        }
        if (state is DeleteProductErrorState) {
          Navigator.pop(context);
          showToast(errorType: 0, message: "Error");
        }
        if (state is ShowProductMultiLangErrorState) {
          Navigator.pop(context);
        }
        if (state is ShowProductMultiLangSuccessState) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddProductScreen(
                productMultiLangModel: cubit.productMultiLangModel,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        ProductsCubit cubit = ProductsCubit.get(context);
        return Container(
          height: 54.h,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greyColor9D, width: 1.2.w),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              CustomSwitchButton(
                productDataModel: productDataModel,
              ),
              const CustomSizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productDataModel.name!,
                      style:
                          CustomThemes.greyColor34TextTheme(context).copyWith(
                        fontSize: 14.sp,
                        height: 1,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const CustomSizedBox(
                      height: 4,
                    ),
                    Text(
                      "${productDataModel.category!.name} ",
                      style:
                          CustomThemes.grey7DColorTextTheme(context).copyWith(
                        fontSize: 14.sp,
                        height: 1,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  cubit.getMultiLangProduct(id: productDataModel.id!);
                  showProgressIndicator(context);
                },
                child: SvgPicture.asset(
                  SvgPath.editIcon,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
              const CustomSizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  cubit.deleteProduct(productId: productDataModel.id!);
                  showProgressIndicator(context);
                },
                child: SvgPicture.asset(
                  SvgPath.trash,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
              const CustomSizedBox(
                width: 16,
              ),
              SvgPicture.asset(
                productDataModel.isApproved! == false
                    ? SvgPath.notConfirmed
                    : SvgPath.accepted,
                width: 24.w,
                height: 24.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
