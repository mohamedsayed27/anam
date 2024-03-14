import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:anam/presentation/widgets/shared_widget/product_item_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_router/screens_name.dart';
import '../../../../domain/controllers/products_cubit/products_cubit.dart';
import '../../../../domain/controllers/products_cubit/products_state.dart';
import '../../../widgets/shared_widget/search_bar_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
            return Column(
              children: [
                Material(
                  type: MaterialType.transparency,
                  child: Hero(
                    tag: "searchField",
                    child: Material(
                      color: Colors.transparent,
                      child: SearchBarWidget(
                        controller: cubit.searchValue,
                        onSearchClicked: () {
                          if (cubit.searchValue.text.isNotEmpty) {
                            cubit.allSearchedProductsPageNumber = 1;
                            cubit.getAllSearchedProducts();
                          }
                        },
                        autofocus: true,
                        enabled: true,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: cubit.getSearchedProductsLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : ListView.separated(
                          itemBuilder: (_, index) {
                            return ProductItemComponent(
                              isFavorite:
                                  cubit.searchedProductsList[index].isFavorite ?? false,
                              onPressed: () {
                                ProductsCubit.get(context).getProductReview(
                                  productId:
                                      cubit.searchedProductsList[index].id.toString(),
                                );
                                Navigator.pushNamed(
                                  context,
                                  ScreenName.productDetailsScreen,
                                  arguments: cubit.searchedProductsList[index],
                                );
                              },
                              productDataModel: cubit.searchedProductsList[index],
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const CustomSizedBox();
                          },
                          itemCount: cubit.searchedProductsList.length,
                        ),
                )
              ],
            );
          },
        ).symmetricPadding(
          horizontal: 16,
          vertical: 24,
        ),
      ),
    );
  }
}
