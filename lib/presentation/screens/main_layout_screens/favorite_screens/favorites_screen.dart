import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_router/screens_name.dart';
import '../../../../domain/controllers/products_cubit/products_cubit.dart';
import '../../../../domain/controllers/products_cubit/products_state.dart';
import '../../../widgets/shared_widget/product_item_component.dart';
import '../../../widgets/shared_widget/search_bar_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    ProductsCubit cubit = ProductsCubit.get(context);
    cubit.getFavoriteProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            ProductsCubit cubit = ProductsCubit.get(context);
            return ListView.separated(
              separatorBuilder: (_, index) => const CustomSizedBox(
                height: 16,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: cubit.favoriteProductsList.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductItemComponent(
                  isFavorite: true,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      ScreenName.productDetailsScreen,
                      arguments: cubit.favoriteProductsList[index],
                    );
                  },
                  productDataModel: cubit.favoriteProductsList[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
