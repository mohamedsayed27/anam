import 'package:anam/presentation/widgets/home_screen_widgets/product_shimmer_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../domain/controllers/products_cubit/products_cubit.dart';
import '../../../domain/controllers/products_cubit/products_state.dart';
import '../shared_widget/custom_sized_box.dart';
import '../shared_widget/product_item_component.dart';

class AllProductsListViewWidget extends StatefulWidget {
  const AllProductsListViewWidget({super.key});

  @override
  State<AllProductsListViewWidget> createState() =>
      _AllProductsListViewWidgetState();
}

class _AllProductsListViewWidgetState extends State<AllProductsListViewWidget> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    var cubit = ProductsCubit.get(context);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        cubit.getAllProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        ProductsCubit cubit = ProductsCubit.get(context);
        return (cubit.getCategory && cubit.showCategoryModel == null) ||
                (cubit.getAllProductsLoading)
            ? const ProductShimmerListWidget()
            : ListView.separated(
                controller:
                    cubit.showCategoryModel == null ? scrollController : null,
                separatorBuilder: (_, index) {
                  return const CustomSizedBox(
                    height: 16,
                  );
                },
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                itemCount: cubit.selectedCategoryIndex == null &&
                        cubit.showCategoryModel == null
                    ? cubit.productsList.length
                    : cubit.selectedSubCategoryIndex == null
                        ? cubit.showCategoryModel!.products!.length
                        : cubit
                            .showCategoryModel!
                            .subCategories![cubit.selectedSubCategoryIndex!]
                            .productsList!
                            .length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductItemComponent(
                    isFavorite: false,
                    onPressed: () {
                      ProductsCubit.get(context).getProductReview(
                        productId: cubit.selectedCategoryIndex == null &&
                                cubit.showCategoryModel == null
                            ? cubit.productsList[index].id!.toString()
                            : cubit.selectedSubCategoryIndex == null
                                ? cubit.showCategoryModel!.products![index].id!
                                    .toString()
                                : cubit
                                    .showCategoryModel!
                                    .subCategories![
                                        cubit.selectedSubCategoryIndex!]
                                    .productsList![index]
                                    .id!
                                    .toString(),
                      );
                      Navigator.pushNamed(
                        context,
                        ScreenName.productDetailsScreen,
                        arguments: cubit.selectedCategoryIndex == null &&
                                cubit.showCategoryModel == null
                            ? cubit.productsList[index]
                            : cubit.selectedSubCategoryIndex == null
                                ? cubit.showCategoryModel!.products![index]
                                : cubit
                                    .showCategoryModel!
                                    .subCategories![
                                        cubit.selectedSubCategoryIndex!]
                                    .productsList![index],
                      );
                    },
                    productDataModel: cubit.selectedCategoryIndex == null &&
                            cubit.showCategoryModel == null
                        ? cubit.productsList[index]
                        : cubit.selectedSubCategoryIndex == null
                            ? cubit.showCategoryModel!.products![index]
                            : cubit
                                .showCategoryModel!
                                .subCategories![cubit.selectedSubCategoryIndex!]
                                .productsList![index],
                  );
                },
              );
      },
    );
  }
}
// 01103073714
