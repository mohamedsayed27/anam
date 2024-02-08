import 'package:anam/core/constants/extensions.dart';
import '../../../../domain/controllers/home_cubit/home_cubit.dart';
import '../../../../domain/controllers/home_cubit/home_state.dart';
import 'package:anam/presentation/widgets/home_screen_widgets/categories_and_subcategories_tab_bars_widgets/sub_categoris_item_widget.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/controllers/products_cubit/products_cubit.dart';
import '../../../../domain/controllers/products_cubit/products_state.dart';
import '../sub_categories_shimmer_widget.dart';

class SubCategoriesTabBarWidget extends StatelessWidget {
  const SubCategoriesTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ProductsCubit.get(context);
        return cubit.selectedCategoryIndex != null
            ? CustomSizedBox(
                height: 35,
                width: double.infinity,
                child: cubit.showCategoryModel!=null?ListView.separated(
                  separatorBuilder: (_,index)=>const CustomSizedBox(width: 10,),
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  itemCount: cubit.showCategoryModel!.subCategories!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SubCategoriesTabBarItemWidget(
                      title: cubit.showCategoryModel!.subCategories![index].name!,
                      isSelected: cubit.selectedSubCategoryIndex == index,
                      onTap: () {
                        cubit.changeCategoriesTabBarWidget(
                          index,
                          isCategories: false,
                        );
                      },
                    );
                  },
                ):const SubCategoriesShimmersList(),
              ).symmetricPadding(vertical: 18)

            : const SizedBox.shrink();
      },
    );
  }
}
