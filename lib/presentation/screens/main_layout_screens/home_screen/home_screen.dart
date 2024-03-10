import 'package:anam/core/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/cache_helper/cache_keys.dart';
import '../../../../core/cache_helper/shared_pref_methods.dart';
import '../../../../core/enums/services_type_enum.dart';
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
import '../../../widgets/shared_widget/custom_outlined_button.dart';
import '../../../widgets/shared_widget/search_bar_widget.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';
import '../services_screens/add_laborer_screen.dart';
import '../services_screens/add_store_screen.dart';
import '../services_screens/add_vet_store_screen.dart';

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
    super.initState();
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
    _itemsTypeTabController.dispose();
    _followersTabController.dispose();
    _followersServicesTabController.dispose();
    expandController.dispose();
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
              child: Row(
                children: [
                  const Expanded(child: SearchBarWidget()),
                  if (appearMapButton == false &&
                      CacheHelper.getData(key: CacheKeys.userType) != null &&
                      CacheHelper.getData(key: CacheKeys.userType) !=
                          UserTypeEnum.user.name)
                    const CustomSizedBox(
                      width: 8,
                    ),
                  if (appearMapButton == false &&
                      CacheHelper.getData(key: CacheKeys.userType) != null &&
                      CacheHelper.getData(key: CacheKeys.userType) !=
                          UserTypeEnum.user.name)
                    BlocConsumer<ServicesCubit, ServicesState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        ServicesCubit cubit = ServicesCubit.get(context);
                        return cubit.selectedServicesValue != null
                            ? CustomOutlinedButton(
                                height: 40.h,
                                onPressed: () {
                                  if (cubit.selectedServicesValue!.type ==
                                      ServicesTypeEnum.veterinary.name) {
                                    cubit.vetImage = null;
                                    cubit.vetNameAr.clear();
                                    cubit.vetNameEn.clear();
                                    cubit.vetPhone.clear();
                                    cubit.vetAddressAr.clear();
                                    cubit.vetAddressEn.clear();
                                    cubit.mapCoordinates;
                                    cubit.mapLocation;
                                    cubit.vetEmail.clear();
                                    cubit.chosenCity = null;
                                    cubit.chosenCity = null;
                                    cubit.qualificationsAr.clear();
                                    cubit.qualificationsEn.clear();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const AddVetScreen(),
                                      ),
                                    );
                                  } else if (cubit
                                          .selectedServicesValue!.type ==
                                      ServicesTypeEnum
                                          .livestock_transportation.name) {
                                    cubit.storeImage = null;
                                    cubit.storeNameAr.clear();
                                    cubit.storeNameEn.clear();
                                    cubit.storePhone.clear();
                                    cubit.chosenCity = null;
                                    cubit.trunkTypeEn.clear();
                                    cubit.storeImages = [];
                                    cubit.trunkTypeAr.clear();
                                    cubit.mapCoordinates = null;
                                    cubit.mapLocation = null;
                                    cubit.storeEmail.clear();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const AddStoreScreen(),
                                      ),
                                    );
                                  } else if (cubit
                                          .selectedServicesValue!.type ==
                                      ServicesTypeEnum.laborers.name) {
                                    cubit.laborerImage = null;
                                    cubit.laborerNameAr.clear();
                                    cubit.laborerNameEn.clear();
                                    cubit.laborerPhone.clear();
                                    cubit.laborerAddressAr.clear();
                                    cubit.laborerAddressEn.clear();
                                    cubit.professionAr.clear();
                                    cubit.professionEn.clear();
                                    cubit.mapCoordinates = null;
                                    cubit.mapLocation = null;
                                    cubit.laborerEmail.clear();
                                    cubit.nationalityEn.clear();
                                    cubit.nationalityAr.clear();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const AddLaborerScreen()));
                                  }
                                },
                                radius: 89,
                                foregroundColor: AppColors.greyColor9D,
                                borderColor: AppColors.greyColor9D,
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                                      cubit.selectedServicesValue!.name!,
                                      style: CustomThemes.grey7DColorTextTheme(
                                              context)
                                          .copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const CircularProgressIndicator();
                      },
                    ),
                ],
              ).onlyDirectionalPadding(
                start: 16,
                end: 16,
                top: 16,
                bottom: 10,
              ),
            )
          ],
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              TabBarView(
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
                          if (index == 1) {
                            isFollowingTap = false;
                            expandController.forward();
                          } else {
                            isFollowingTap = true;
                            expandController.reverse();
                          }
                          setState(() {});
                        },
                      ),
                      const CustomSizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: isMap
                            ? const HomeGoogleMapsView()
                            : isFollowingTap &&
                                    CacheHelper.getData(
                                            key: CacheKeys.userType) !=
                                        null &&
                                    CacheHelper.getData(
                                            key: CacheKeys.userType) ==
                                        UserTypeEnum.user.name
                                ? const ProductsFollowingListViewWidget()
                                : const AllProductsListViewWidget(),
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
