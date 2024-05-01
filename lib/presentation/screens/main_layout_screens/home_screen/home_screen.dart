import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/domain/controllers/products_cubit/products_cubit.dart';
import 'package:anam/presentation/widgets/home_screen_widgets/search_bar_and_services_buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache_helper/cache_keys.dart';
import '../../../../core/cache_helper/shared_pref_methods.dart';
import '../../../../core/enums/user_type_enum.dart';
import '../../../../domain/controllers/services_cubit/services_cubit.dart';
import '../../../../domain/controllers/services_cubit/services_state.dart';
import '../../../widgets/home_screen_widgets/all_products_list_view_widget.dart';
import '../../../widgets/home_screen_widgets/categories_and_subcategories_tab_bars_widgets/product_categories_tab_bar_widget.dart';
import '../../../widgets/home_screen_widgets/categories_and_subcategories_tab_bars_widgets/sub_categories_tab_bar_widget.dart';
import '../../../widgets/home_screen_widgets/following_and_followers_tab_bar.dart';
import '../../../widgets/home_screen_widgets/products_following_list_view_widget.dart';
import '../../../widgets/home_screen_widgets/services_categories_tab_bar.dart';
import '../../../widgets/home_screen_widgets/show_map_button.dart';
import '../../../widgets/home_screen_widgets/tab_bar_widget.dart';
import '../../../widgets/maps_widgets/home_google_map_view.dart';
import '../../../widgets/services_widgets/services_all_products_list.dart';
import '../../../widgets/services_widgets/services_following_list.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _itemsTypeTabController;
  late TabController _followersTabController;
  late TabController _followersServicesTabController;
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _itemsTypeTabController = TabController(
      length: 2,
      vsync: this,
    );
    _followersTabController = TabController(
      length: CacheHelper.getData(key: CacheKeys.userType) != null &&
              CacheHelper.getData(key: CacheKeys.userType) ==
                  UserTypeEnum.user.name
          ? 2
          : 1,
      vsync: this,
    );
    _followersServicesTabController = TabController(
      length: CacheHelper.getData(key: CacheKeys.userType) != null &&
              CacheHelper.getData(key: CacheKeys.userType) ==
                  UserTypeEnum.user.name
          ? 2
          : 1,
      vsync: this,
    );
    prepareAnimations();
    if(CacheHelper.getData(key: CacheKeys.userType)==UserTypeEnum.user.name){
      ProductsCubit.get(context).userFollowingProductsPageNumber==1;
      ProductsCubit.get(context).getUserFollowingProducts();
    }
    ProductsCubit.get(context).allProductsPageNumber = 1;
    print("home page number :${ProductsCubit.get(context).allProductsPageNumber}");
    ProductsCubit.get(context).getAllProducts();
  }

  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    if (CacheHelper.getData(key: CacheKeys.userType) !=
            UserTypeEnum.user.name &&
        CacheHelper.getData(key: CacheKeys.userType) == null) {
      expandController.forward();
    }
  }

  @override
  void dispose() {
    // _itemsTypeTabController.dispose();
    // _followersTabController.dispose();
    // _followersServicesTabController.dispose();
    // expandController.dispose();
    super.dispose();
  }

  bool isMap = false;
  bool appearMapButton = true;
  bool isFollowingTap = true;
  bool isServicesFollowingTap = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (_, isScrolled) => [
            SliverToBoxAdapter(
              child: HomeTabBarWidget(
                tabController: _itemsTypeTabController,
                onTap: (index) {
                  if (index == 0) {
                    setState(() {
                      appearMapButton = true;
                    });
                  } else {
                    setState(() {
                      appearMapButton = false;
                    });
                  }
                },
              ).onlyDirectionalPadding(
                start: 16,
                end: 16,
                top: 16,
              ),
            ),
            SliverToBoxAdapter(
              child:
                  SearchBarAndServicesButtonsWidget(mapButton: appearMapButton),
            )
          ],
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _itemsTypeTabController,
                children: [
                  Column(
                    children: [
                      SizeTransition(
                        axisAlignment: 1.0,
                        sizeFactor: animation,
                        child: const Column(
                          children: [
                            ProductCategoriesTabBarWidget(),
                            SubCategoriesTabBarWidget(),
                          ],
                        ),
                      ),
                      FollowingAndFollowersTabBar(
                        tabController: _followersTabController,
                        onTap: (index) {
                          if (token != null &&
                              userType != UserTypeEnum.vendor.name) {
                            if (index == 1) {
                              isFollowingTap = false;
                              expandController.forward();
                            } else {
                              isFollowingTap = true;
                              expandController.reverse();
                            }
                            setState(() {});
                          }
                        },
                      ),
                      const CustomSizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: isMap
                            ? HomeGoogleMapsView(
                          productsList:
                          ProductsCubit.get(context).productsList,
                        )
                            : isFollowingTap &&
                                    CacheHelper.getData(
                                            key: CacheKeys.userType) !=
                                        null &&
                                    CacheHelper.getData(
                                            key: CacheKeys.userType) ==
                                        UserTypeEnum.user.name
                                ?  ProductsFollowingListViewWidget(isGetAll: isFollowingTap,)
                                :  AllProductsListViewWidget(isGetAll: !isFollowingTap,),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const ServicesCategoriesTabBarWidget(),
                      FollowingAndFollowersTabBar(
                        tabController: _followersServicesTabController,
                        onTap: (index) {
                          if (index == 1) {
                            isServicesFollowingTap = false;
                          } else {
                            isServicesFollowingTap = true;
                          }
                          setState(() {});
                        },
                      ),
                      const CustomSizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: BlocConsumer<ServicesCubit, ServicesState>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            var cubit = ServicesCubit.get(context);
                            return TabBarView(
                              controller: _followersServicesTabController,
                              children: [
                                if (CacheHelper.getData(
                                        key: CacheKeys.userType) ==
                                    UserTypeEnum.user.name)
                                  cubit.selectedServicesValue != null
                                      ? const ServicesFollowingList()
                                      : const Center(
                                          child: CircularProgressIndicator
                                              .adaptive()),
                                cubit.selectedServicesValue != null
                                    ? const ServicesAllProductsList()
                                    : const Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Visibility(
                child: ShowMapButton(
                  isMap: isMap,
                  onPressed: () {
                    setState(() {
                      isMap = !isMap;
                    });
                  },
                ).onlyDirectionalPadding(bottom: 22),
                visible: appearMapButton,
              )
            ],
          ),
        ),
      ),
    );
  }
}
