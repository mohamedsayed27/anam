import 'package:anam/presentation/widgets/home_screen_widgets/categories_and_subcategories_tab_bars_widgets/categories_tab_bar_item_widget.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/controllers/home_cubit/home_cubit.dart';
import '../../../../domain/controllers/home_cubit/home_state.dart';
import '../../../../domain/controllers/products_cubit/products_cubit.dart';
import '../../../../domain/controllers/products_cubit/products_state.dart';
import '../../../../domain/controllers/services_cubit/services_cubit.dart';
import '../categories_shimmer_effect.dart';

class ProductCategoriesTabBarWidget extends StatefulWidget {
  const ProductCategoriesTabBarWidget({super.key});

  @override
  State<ProductCategoriesTabBarWidget> createState() =>
      _ProductCategoriesTabBarWidgetState();
}

class _ProductCategoriesTabBarWidgetState
    extends State<ProductCategoriesTabBarWidget> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    var cubit = ProductsCubit.get(context);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        cubit.getAllCategories();
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
        var cubit = ProductsCubit.get(context);
        return Container(
          height: 90.h,
          padding: EdgeInsets.only(bottom: 4.h),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 4.r,
              offset: Offset(0, 4.h),
            )
          ]),
          child: cubit.getAllCategoriesLoading
              ? const CategoriesShimmerEffectList()
              : ListView.separated(
                  controller: scrollController,
                  separatorBuilder: (_, index) => const CustomSizedBox(
                    width: 4,
                  ),
                  itemCount: cubit.categoriesList.length,
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  itemBuilder: (BuildContext context, int index) {
                    return CategoriesTabBarItem(
                      onTap: () {
                        cubit.changeCategoriesTabBarWidget(
                          index,
                          categoryId: cubit.categoriesList[index].id!,
                        );
                      },
                      isSelected: index == cubit.selectedCategoryIndex,
                      imagePath: cubit.categoriesList[index].image!,
                      title: cubit.categoriesList[index].name!,
                    );
                  },
                ),
        );
      },
    );
  }
}
