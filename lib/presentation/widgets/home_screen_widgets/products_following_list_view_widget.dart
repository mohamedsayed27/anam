import 'package:anam/presentation/widgets/home_screen_widgets/product_shimmer_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../domain/controllers/products_cubit/products_cubit.dart';
import '../../../domain/controllers/products_cubit/products_state.dart';
import '../shared_widget/custom_sized_box.dart';
import '../shared_widget/product_item_component.dart';

class ProductsFollowingListViewWidget extends StatelessWidget {
  final bool isGetAll;
  const ProductsFollowingListViewWidget({super.key, required this.isGetAll});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        ProductsCubit cubit = ProductsCubit.get(context);
        return cubit.getUserFollowingList
            ? const ProductShimmerListWidget()
            : NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification) {
                    if (scrollNotification.metrics.pixels ==
                        scrollNotification.metrics.maxScrollExtent) {
                      if(isGetAll) {
                        cubit.getUserFollowingProducts();
                      }
                    }
                  }
                  return true;
                },
                child: ListView.separated(
                  separatorBuilder: (_, index) {
                    return const CustomSizedBox(
                      height: 16,
                    );
                  },
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  itemCount: cubit.userFollowingProductsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductItemComponent(
                      isFavorite: false,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, ScreenName.productDetailsScreen,
                            arguments: cubit.userFollowingProductsList[index]);
                      },
                      productDataModel: cubit.userFollowingProductsList[index],
                    );
                  },
                ),
              );
      },
    );
  }
}
